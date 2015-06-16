//
//  ARTEsimoteBeaconViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-15.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTEstimoteBeaconManager.h"

@interface ARTEstimoteBeaconManager ()

@end


@implementation ARTEstimoteBeaconManager


- (id)init
{
    self = [super init];
    
    if (self) {
        [self beaconManager];
    }
    return self;
}


#pragma mark - Getters
- (ESTBeaconManager *)beaconManager
{
    if (_beaconManager == nil) {
        _beaconManager = [[ESTBeaconManager alloc] init];
        [_beaconManager setDelegate:self];
        
        [_beaconManager  requestWhenInUseAuthorization];
        
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                               identifier:@"ca.architech.myRegion"];
    }
    return _beaconManager;
}


#pragma mark - Beacon handling
- (void)startSearchingForBeacons
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}


- (void)stopSearchingForBeacons
{
    [self.beaconManager stopMonitoringForRegion:self.beaconRegion];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


#pragma mark - ESTBeaconManagerDelegate
- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(CLBeaconRegion *)region
{
    //Awakes from the background mode.
    NSLog(@"didEnterRegion");
}


- (void)beaconManager:(id)manager
      didRangeBeacons:(NSArray *)beacons
             inRegion:(CLBeaconRegion *)region
{
    NSLog(@"didRangeBeacons %@", beacons);
    
    if ([beacons lastObject])
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        if ([self.delegate respondsToSelector:@selector(didFindEstimoteBeacons:inRegion:)]) {
            [self.delegate didFindEstimoteBeacons:beacons
                                         inRegion:region];
        }
    }
}


-(void)beaconManager:(id)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
           withError:(NSError *)error
{
    NSLog(@"rangingBeaconsDidFailForRegion %@", error);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if ([self.delegate respondsToSelector:@selector(didFailFindingEstimoteBeaconsForRegion:withError:)]) {
        [self.delegate didFailFindingEstimoteBeaconsForRegion:region
                                                    withError:error];
    }
}


#pragma mark - ESTUtilityManagerDelegate
- (void)utilityManager:(ESTUtilityManager *)manager didDiscoverBeacons:(NSArray *)beacons {
    NSLog(@"didDiscoverBeacons %@", beacons);
}


- (void)utilityManagerDidFailDiscovery:(ESTUtilityManager *)manager {
    NSLog(@"utilityManagerDidFailDiscovery %@", manager);
}



@end
