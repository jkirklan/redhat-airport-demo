//
//  AppDelegate.h
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTBeaconManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, ARTBeaconManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ARTBeaconManager *beaconManager;

@property (strong, nonatomic) ARTBeaconRegister *beaconRegister;

@end

