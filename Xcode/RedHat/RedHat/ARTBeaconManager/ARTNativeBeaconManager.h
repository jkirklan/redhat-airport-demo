//
//  ATBeaconManager.h
//  TorontoBOT
//
//  Created by Mike Post on 2014-04-24.
//  Copyright (c) 2014 Architech. All rights reserved.
//


/**
 @class A manager to be used to set up or monitor any native iOS beacons, set up on any iOS devices.
 */

@import CoreLocation;
@import CoreBluetooth;


@protocol ARTNativeBeaconDelegate <NSObject>

- (void)didFindiOSBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region;

- (void)didFailFindingiOSBeaconsForRegion:(CLBeaconRegion *)region withError:(NSError *)error;

@optional
- (void)didFailEnablingBluetooth;

- (void)didSetupDeviceAsBeacon:(NSDictionary *)beaconInfo;

@end


/**
 @class The intention is for this to manage both iOS AND Estimote beacons.
 */
@interface ARTNativeBeaconManager : NSObject <CLLocationManagerDelegate, CBPeripheralManagerDelegate> {
}

@property (nonatomic, assign) id <ARTNativeBeaconDelegate> delegate;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

/**
 @return YES if the device has been configured to be a beacon transmitter.
 */
- (BOOL)isTransmitterDevice;

/**
 Sets up the current device as a transmitting beacon, if not already.
 */
- (void)configureDeviceAsBeacon;

/**
 Starts the whole process of searching for ALL beacons.
 */
- (void)startSearchingForBeacons;

- (void)stopSearchingForBeacons;

@end
