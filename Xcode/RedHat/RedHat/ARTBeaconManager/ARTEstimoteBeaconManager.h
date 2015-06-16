//
//  ARTEsimoteBeaconViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-06-15.
//  Copyright (c) 2015 Architech. All rights reserved.
//

/**
 @class A class to encapsulate the ESTBeaconManager, and simplify the delegate callbacks to the view controller.
 */

#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>


@protocol ARTEstimoteBeaconDelegate <NSObject>

- (void)didFindEstimoteBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region;

- (void)didFailFindingEstimoteBeaconsForRegion:(CLBeaconRegion *)region withError:(NSError *)error;

@end


@interface ARTEstimoteBeaconManager : NSObject <ESTBeaconManagerDelegate, ESTUtilityManagerDelegate>

@property (assign, nonatomic) id <ARTEstimoteBeaconDelegate> delegate;

/**
 */
@property (strong, nonatomic) ESTBeaconManager *beaconManager;

/**
 */
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;


- (void)startSearchingForBeacons;

- (void)stopSearchingForBeacons;

@end
