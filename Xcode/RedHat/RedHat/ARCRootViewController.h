//
//  ViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCMenuAccessViewController.h"
#import "ARTWebViewController.h"
#import "ATBeaconManager.h"

@interface ARCRootViewController : ARCMenuAccessViewController <UINavigationControllerDelegate, ARTWebViewDelegate, ATBeaconManagerDelegate>

@property (nonatomic, strong) IBOutlet UIView *containerView;

@property (nonatomic, strong) ATBeaconManager *beaconManager;

//@property (nonatomic, strong) ARTBeaconRegister *beaconRegister;

@property (nonatomic, strong) ARTWebViewController *rootWebViewController;

@end

