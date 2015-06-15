//
//  ARTEsimoteBeaconViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-15.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTEsimoteBeaconManager.h"

@interface ARTEsimoteBeaconManager ()

@end


@implementation ARTEsimoteBeaconManager


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


@end
