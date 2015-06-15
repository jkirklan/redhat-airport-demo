//
//  ARTEsimoteBeaconViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-06-15.
//  Copyright (c) 2015 Architech. All rights reserved.
//

/**
 @class An abstract class to encapsulate an ESTBeaconManager and an CLBeaconRegion property.
 */

#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>

@interface ARTEsimoteBeaconViewController : UIViewController <ESTBeaconManagerDelegate, ESTUtilityManagerDelegate>

/**
 */
@property (strong, nonatomic) ESTBeaconManager *beaconManager;

/**
 */
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

@end
