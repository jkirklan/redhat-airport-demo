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

@property (nonatomic, strong) CLBeaconRegion *beaconRegion;

@property (nonatomic, strong) NSDictionary *transmitterInfo;

@end


@implementation ATDemoBeaconManager

/**
 This should probably be a singleton. Let's not worry about that for prototype 1.
 */
- (id)init
{
    self = [super init];
    
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;

        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E48AB15D-7608-4051-956E-AB4351CD3B7F"];
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"ca.architech.myRegion"];
    }
    
    return self;
}


#pragma mark - Getters
- (NSDictionary *)transmitterInfo {
    _transmitterInfo = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    return _transmitterInfo;
}


#pragma mark - Class Methods
- (BOOL)isTransmitterDevice
{
    BOOL isTransmitterDevice = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([defaults objectForKey:kvoUserDefaultsDeviceBeaconID] == nil) {
        isTransmitterDevice = NO;
    }
    
    return isTransmitterDevice;
}


- (void)configureDeviceAsBeacon
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Store the beacon’s identifying information in NSUserDefaults...
    [defaults setObject:self.transmitterInfo
                 forKey:kvoUserDefaultsDeviceBeaconID];
    
    BOOL isSaved = [defaults synchronize];
    
    //Pass the dictionary to the startAdvertising: method of a CBPeripheralManager to begin advertising the beacon...
    if (isSaved == YES) {
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E48AB15D-7608-4051-956E-AB4351CD3B7F"];
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                    major:1
                                                                    minor:1
                                                               identifier:@"ca.architech.myRegion"];

        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                         queue:nil
                                                                       options:nil];
    }
}


- (void)startSearchingForBeacons
{
    if ([self isTransmitterDevice] == NO) {
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
        
        [self.locationManager requestWhenInUseAuthorization];
        [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];        
    }
}


- (void)stopSearchingForBeacons {
    [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}



#pragma mark - CBPeripheralManagerDelegate
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.transmitterInfo];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
        if ([self.delegate respondsToSelector:@selector(didFailEnablingBluetooth)]) {
            [self.delegate didFailEnablingBluetooth];
        }
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
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Region Entered: didEnterRegion");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}


-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"Beacon Found: didRangeBeacons %@", beacons);
    if ([self.delegate respondsToSelector:@selector(didFindiOSBeacons:inRegion:)]) {
        [self.delegate didFindiOSBeacons:beacons
                                inRegion:region];
    }
}

@end

