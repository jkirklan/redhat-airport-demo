//
//  ViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCMenuAccessViewController.h"
#import "ARTWebViewController.h"
#import "ARTNativeBeaconManager.h"
#import "ARTEstimoteBeaconManager.h"
#import "ARCNetworkManager.h"

extern NSString *const ARCApplicationDidReceiveRemoteNotification;

typedef enum ARCFlightStatus {
    ARCFlightStatusOnTime       = 1,
    ARCFlightStatusDelayed      = 2,
    ARCFlightStatusLate         = 3
} ARCFlightStatus;


@interface ARCRootViewController : ARCMenuAccessViewController <UINavigationControllerDelegate, ARTWebViewDelegate,
                                                                ARTEstimoteBeaconDelegate> //,ARTNativeBeaconDelegate>

@property (nonatomic, strong) IBOutlet UIView *containerView;

@property (nonatomic, strong) ARTNativeBeaconManager *beaconManager;

@property (nonatomic, strong) ARTEstimoteBeaconManager *estimoteBeaconManager;

@property (nonatomic, strong) ARCNetworkManager *networkManager;

@property (nonatomic, strong) ARTWebViewController *rootWebViewController;

- (NSString *)paramaterForFlightStatus:(ARCFlightStatus)flightStatus;

@end

