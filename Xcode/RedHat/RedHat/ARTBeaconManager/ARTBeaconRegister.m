//
//  ARTBeaconRegister.m
//  RedHat
//
//  Created by Mike Post on 2015-06-10.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTBeaconRegister.h"

@interface ARTBeaconRegister()

@property (nonatomic, copy) ARTBeaconRegistrationCompletion registrationCompletion;

@property (nonatomic, copy) ARTBeaconRegistrationError registrationError;

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

@end


@implementation ARTBeaconRegister


- (id)init {
    self = [super init];
    
    if (self) {
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                         queue:nil];
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


- (void)registerBeaconWithCompletion:(ARTBeaconRegistrationCompletion)completion error:(ARTBeaconRegistrationError)error
{
    [self setRegistrationCompletion:completion];
    [self setRegistrationError:error];
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:self.uuid];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID
                                                                      identifier:bundleIdentifier];
    
    NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    [self.peripheralManager startAdvertising:beaconPeripheralData];
}


#pragma mark - CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        //Success
        dispatch_async(dispatch_get_main_queue(), ^{
            self.registrationCompletion();
        });
    }
    else {        
        NSError *error = [NSError errorWithDomain:@"REGISTRATION"
                                             code:100
                                         userInfo:@{NSLocalizedDescriptionKey: @"please check Bluetooth and retry!"}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.registrationError(error);
        });
    }
}


@end
