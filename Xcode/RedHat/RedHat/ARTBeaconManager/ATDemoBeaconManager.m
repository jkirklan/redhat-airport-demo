//
//  ATBeaconManager.m
//  TorontoBOT
//
//  Created by Mike Post on 2014-04-24.
//  Copyright (c) 2014 Architech. All rights reserved.
//

#import "ATDemoBeaconManager.h"


#define ARCHITECH_PROXIMITY_UUID                [[NSUUID alloc] initWithUUIDString:@"E48AB15D-7608-4051-956E-AB4351CD3B7F"]

NSString *const kvoUserDefaultsDeviceBeaconID   = @"DeviceBeaconID";


@interface ATDemoBeaconManager()

@property (nonatomic, strong) CLBeaconRegion *iOSBeaconRegion;

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

@property (nonatomic, strong) NSDictionary *transmitterInfo;

@end


@implementation ATDemoBeaconManager

/**
 This should probably be a singleton. Let's not worry about that for prototype 1.
 */
- (id)init
{
    self = [super init];
    
    if (self)
    {
//        self.beaconManager = [[ESTBeaconManager alloc] init];
//        [self.beaconManager setDelegate:self];
//        
//        self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ARCHITECH_PROXIMITY_UUID
//                                                                identifier:ESTIMOTE_BEACON_REGION_ID];
        
        //Init bluetooth power...
        [self locationManager];
        [self peripheralManager];
    }
    
    return self;
}


#pragma mark - Getters
- (CLLocationManager *)locationManager
{
    //Check for bluetooth and set CLLocationManager...
    BOOL hasBluetooth = [CLLocationManager isRangingAvailable];
    
    if (hasBluetooth == YES) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(didFailEnablingBluetooth)]) {
            [self.delegate didFailEnablingBluetooth];
        }
    }

    return _locationManager;
}


- (CLBeaconRegion *)iOSBeaconRegion
{
    if (_iOSBeaconRegion == nil) {
        _iOSBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:ARCHITECH_PROXIMITY_UUID
                                                                   major:1001
                                                              identifier:kvoUserDefaultsDeviceBeaconID];

        [_iOSBeaconRegion setNotifyEntryStateOnDisplay:YES];
        [_iOSBeaconRegion setNotifyOnEntry:NO];
        [_iOSBeaconRegion setNotifyOnExit:YES];
    }

    return _iOSBeaconRegion;
}


- (CBPeripheralManager *)peripheralManager
{
    if (_peripheralManager == nil) {
        _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    
    return _peripheralManager;
}


- (NSDictionary *)transmitterInfo
{
    if (_transmitterInfo == nil) {
        _transmitterInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kvoUserDefaultsDeviceBeaconID];
    }
    return _transmitterInfo;
}


#pragma mark - Class Methods
- (BOOL)isTransmitterDevice
{
    BOOL isTransmitterDevice = YES;
    
    if (self.transmitterInfo == nil) {
        isTransmitterDevice = NO;
    }
    
    return isTransmitterDevice;
}


- (void)configureDeviceAsBeacon
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Call the peripheralDataWithMeasuredPower method to get power for the current device (iPad)...
    NSMutableDictionary *beaconInfo = [self.iOSBeaconRegion peripheralDataWithMeasuredPower:nil];
    
    //Store the beacon’s identifying information in NSUserDefaults...
    [defaults setObject:beaconInfo
                 forKey:kvoUserDefaultsDeviceBeaconID];
    
    BOOL isSaved = [defaults synchronize];
    
    //Pass the dictionary to the startAdvertising: method of a CBPeripheralManager to begin advertising the beacon...
    if (isSaved == YES) {
        [self.peripheralManager startAdvertising:beaconInfo];
    }
}


- (void)startSearchingForBeacons
{
    //Confirm it's not an iOS transmitter beacon...
    if ([self isTransmitterDevice] == YES) {
        [self.peripheralManager startAdvertising:self.transmitterInfo];
    }
    else {
        [self.locationManager requestWhenInUseAuthorization];

        //Receivers can search for beacons...
        [self locationManager:self.locationManager didStartMonitoringForRegion:self.iOSBeaconRegion];
    }
}


//- (void)stopEstimoteBeacons {
//    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
//}


#pragma mark - CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if ( (peripheral.state < CBPeripheralManagerStatePoweredOn) &&
         ([self.delegate respondsToSelector:@selector(didFailEnablingBluetooth)]) )
    {
        [self.delegate didFailEnablingBluetooth];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        NSDictionary *beaconInfo = [self.iOSBeaconRegion peripheralDataWithMeasuredPower:nil];
        [self.peripheralManager startAdvertising:beaconInfo];
    }
}


- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    NSLog(@"peripheralManagerDidStartAdvertising");

    if ( ([self.delegate respondsToSelector:@selector(didSetupDeviceAsBeacon:)]) &&
         ([self isTransmitterDevice] == YES) ) {
        [self.delegate didSetupDeviceAsBeacon:self.transmitterInfo];
    }
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"didStartMonitoringForRegion");
    [self.locationManager startRangingBeaconsInRegion:self.iOSBeaconRegion];
}


- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"didRangeBeacons");
}


- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"rangingBeaconsDidFailForRegion");
}


#pragma mark - ESTBeaconManagerDelegate
/*
- (void)beaconManager:(ESTBeaconManager *)manager
      didRangeBeacons:(NSArray *)beacons
             inRegion:(ESTBeaconRegion *)region
{
    NSLog(@"didRangeBeacons -> number found: %d", beacons.count);
    
    if ([beacons lastObject])
    {
        //For this prototype, we're only interested in the BLUE beacon!!!
        [beacons enumerateObjectsUsingBlock:^(ESTBeacon *beacon, NSUInteger idx, BOOL *stop)
        {
            BeaconIdentifier *beaconIdentifier = [[BeaconIdentifier alloc] initWithBeacon:beacon];
            
            if ([beaconIdentifier color] == ATBeaconColorBlue)
            {
                [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
                *stop = YES;
                NSLog(@"Found Blue! beaconIdentifier: %@", beaconIdentifier);
                
                if ([_delegate respondsToSelector:@selector(didFindEstimoteBeacons:inRegion:)]) {
                    [self.delegate didFindEstimoteBeacons:beacons
                                                 inRegion:region];
                }
            }
        }];
    }
}


-(void)beaconManager:(ESTBeaconManager *)manager
rangingBeaconsDidFailForRegion:(ESTBeaconRegion *)region
           withError:(NSError *)error
{
    NSLog(@"rangingBeaconsDidFailForRegion %@", error);

    if ([_delegate respondsToSelector:@selector(didFailFindingEstimoteBeaconsForRegion:withError:)]) {
        [self.delegate didFailFindingEstimoteBeaconsForRegion:region
                                                    withError:error];
    }
}
 */


@end

