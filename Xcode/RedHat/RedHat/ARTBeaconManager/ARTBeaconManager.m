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

@end


@implementation ARTBeaconManager


- (id)init {
    self = [super init];
    
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
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
    
}


#pragma mark - CLLocationManagerDelegate



@end

