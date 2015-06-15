//
//  ARTBeaconManager.m
//  RedHat
//
//  Created by Mike Post on 2015-06-10.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTBeaconManager.h"


@interface ARTBeaconManager()

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CLBeaconRegion *beaconRegion;

@end


@implementation ARTBeaconManager


- (id)init {
    self = [super init];
    
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    return self;
}


- (id)initWithUUIDString:(NSString *)uuid {
    self = [self init];
    
    if (self) {
        self.uuid = uuid;
    }
    return self;
}


- (void)monitorBeaconRegionWithIdentifier:(NSString*)identifier
{
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:self.uuid];
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID
                                                           identifier:identifier];
    
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
}


- (void)stopMonitoringBeaconRegion
{
    if (self.beaconRegion) {
        [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    }
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    //Hack to search for iOS beacons!
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon region entered!");
    
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    //Reset whatever needs resetting...
    NSLog(@"Exited beacon region...");
}


- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    NSLog(@"didRangeBeacons: %@", beacons);
}


- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    NSLog(@"didDetermineState");
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"monitoringDidFailForRegion");
}


@end

