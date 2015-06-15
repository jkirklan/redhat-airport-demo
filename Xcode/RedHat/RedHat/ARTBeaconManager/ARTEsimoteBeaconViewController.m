//
//  ARTEsimoteBeaconViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-15.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTEsimoteBeaconViewController.h"

@interface ARTEsimoteBeaconViewController ()

@end


@implementation ARTEsimoteBeaconViewController


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];    
    [self beaconManager];
}


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
