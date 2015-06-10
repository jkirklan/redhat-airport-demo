//
//  ARTBeaconRegister.h
//  RedHat
//
//  Created by Mike Post on 2015-06-10.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^ARTBeaconRegistrationCompletion)(void);
typedef void(^ARTBeaconRegistrationError)(NSError *error);


@interface ARTBeaconRegister : NSObject <CBPeripheralManagerDelegate>

/**
 Created in case the calling class wants to set the UUID separately to using the convenience initialiser.
 */
@property (nonatomic, strong) NSString *uuid;

/**
 Convenience initialiser.
 */
- (id)initWithUUIDString:(NSString *)uuid;

/**
 Explicitly call this to regsiter the device as a beacon.
 */
- (void)registerBeaconWithCompletion:(ARTBeaconRegistrationCompletion)completion error:(ARTBeaconRegistrationError)error;

@end
