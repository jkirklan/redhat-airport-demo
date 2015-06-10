//
//  ARTBeaconManager.h
//  RedHat
//
//  Created by Mike Post on 2015-06-10.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTBeaconRegister.h"

@protocol ARTBeaconManagerDelegate <NSObject>

@end


@interface ARTBeaconManager : NSObject <CLLocationManagerDelegate>

/**
 Created in case the calling class wants to set the UUID separately to using the convenience initialiser.
 */
@property (nonatomic, strong) NSString *uuid;

/**
 Convenience initialiser.
 */
- (id)initWithUUIDString:(NSString *)uuid;

/**
 Uses the CLLocationManager to monitor the device for entering beacon regions.
 NOTE: This assumes you've already initialisd the `uuid`!
 */
- (void)monitorBeaconRegionWithIdentifier:(NSString*)identifier;

@end
