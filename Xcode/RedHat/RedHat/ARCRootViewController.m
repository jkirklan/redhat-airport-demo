//
//  ViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCRootViewController.h"

NSString *const ARCApplicationDidReceiveRemoteNotification = @"ARTApplicationDidReceiveRemoteNotification";


@interface ARCRootViewController ()

- (void)adminNotificationReceived:(NSNotification *)notification;

- (void)viewControllerDidReceiveRemoteNotification:(NSNotification *)notification;

- (void)alertBeaconFound:(CLBeacon *)beacon;

@end


@implementation ARCRootViewController


- (void)viewDidLoad
{
    //Load order 2.
    [super viewDidLoad];
    [self.navigationController setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adminNotificationReceived:)
                                                 name:@"ADMIN_RELOAD_REQUEST"
                                               object:nil];

    //Set up beacons...
    self.estimoteBeaconManager = [[ARTEstimoteBeaconManager alloc] init];
    [self.estimoteBeaconManager setDelegate:self];
    
    [self.estimoteBeaconManager startSearchingForBeacons];
    
/*
    self.beaconManager = [[ARTNativeBeaconManager alloc] init];
    [self.beaconManager setDelegate:self];

    //Only uncomment ONE of these, depending on if you want the device to be a transmitter beacon or not:
    //[self.beaconManager configureDeviceAsBeacon];
    [self.beaconManager startSearchingForBeacons];
*/
    
    //Listen for Remote notifications...
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewControllerDidReceiveRemoteNotification:)
                                                 name:ARCApplicationDidReceiveRemoteNotification
                                               object:nil];
}


- (void)viewDidAppear:(BOOL)animated {
    //Load order 3.
    [super viewDidAppear:animated];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Load order 1.
    if ([[segue identifier] isEqualToString:@"WebViewSegue"]) {
        self.rootWebViewController = (ARTWebViewController *)[segue destinationViewController];
        [self.rootWebViewController setDelegate:self];
    }
}


#pragma mark - Getters
- (ARCNetworkManager *)networkManager
{
    if (_networkManager == nil) {
        _networkManager = [[ARCNetworkManager alloc] init];
    }
    return _networkManager;
}


- (NSString *)paramaterForFlightStatus:(ARCFlightStatus)flightStatus
{
    NSString *parameter;
    
    switch (flightStatus) {
        case ARCFlightStatusDelayed:
            parameter = @"delayed";
            break;
            
        case ARCFlightStatusLate:
            //No change in display content as of yet!
            parameter = @"ontime";
            break;
            
        case ARCFlightStatusOnTime:
        default:
            parameter = @"ontime";
            break;
    }
    return parameter;
}


#pragma mark - NSNotifications
- (void)viewControllerDidReceiveRemoteNotification:(NSNotification *)notification
{
    if ([notification userInfo]) {
        ARCFlightStatus status = [(NSNumber *)[[notification userInfo] objectForKey:@"NOTIFICATION_TYPE"] floatValue];
        
        NSMutableString *webURL = [NSMutableString stringWithString:[NSString stringWithFormat:@"http://%@/index.html?flight=", ROOT_URL]];
        [webURL appendString:[self paramaterForFlightStatus:status]];

        [self.rootWebViewController loadWebviewWithURL:webURL];
    }
}


- (void)adminNotificationReceived:(NSNotification *)notification
{
    //Webview reload...
    NSMutableString *pageURL = [NSMutableString stringWithString:[NSString stringWithFormat:@"http://%@", ROOT_URL]];
        
    NSNumber *menuItemTapped = [[notification userInfo] objectForKey:@"MENU_ITEM_TAPPED"];
    
    switch ([menuItemTapped integerValue]) {
        case 1:
            [pageURL appendString:@"/coupon-list.html"];
            break;
            
        case 2: {
            //Reset the cache...
            [self.rootWebViewController deleteCacheWithJSMethod:@"home.clearLocalStorage()"];
            
            //Reset defaults:
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            ARCFlightStatus statusInt = ARCFlightStatusOnTime;
            [userDefaults setObject:[NSNumber numberWithInt:statusInt]
                         forKey:@"NOTIFICATION_TYPE"];
            [userDefaults synchronize];
            
            //Notify the server...
            [self.networkManager postBeaconExitedWithMethod:HTTP_METHOD_GET
                                                completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                                    NSLog(@"networkManager completed! Response: %@", response);
                                                }];
                        
            //Re-monitor beacons...
            [self.estimoteBeaconManager startSearchingForBeacons];
        }
            break;
            
        case 0:
        default: {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            ARCFlightStatus statusInt = [(NSNumber *)[userDefaults objectForKey:@"NOTIFICATION_TYPE"] floatValue];
            
            NSString *status = [self paramaterForFlightStatus:statusInt];
            [pageURL appendFormat:@"/index.html?flight=%@", status];
        }
            break;
    }
    
    [self.rootWebViewController loadWebviewWithURL:pageURL];
}


#pragma mark - Beacon handling
- (void)alertBeaconFound:(CLBeacon *)beacon
{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Beacon Found!"
                                                                       message:@"Please look at the screen for flight information."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - ARTEstimoteBeaconDelegate
- (void)didFindEstimoteBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons lastObject])
    {
        [beacons enumerateObjectsUsingBlock:^(CLBeacon *beacon, NSUInteger idx, BOOL *stop)
        {
            if (beacon.proximity == CLProximityImmediate) {
                [self.estimoteBeaconManager stopSearchingForBeacons];
                
                [self.networkManager postBeaconFoundWithMethod:HTTP_METHOD_GET
                                                    completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    NSLog(@"networkManager completed! Response: %@", response);
                    
                    if (connectionError) {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Failure"
                                                                                       message:@"Please enable Wifi or check your network connection."
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                              handler:^(UIAlertAction * action) {}];
                        
                        [alert addAction:defaultAction];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    else {
                        [self alertBeaconFound:beacon];
                    }
                }];
            }
        }];
    }
}


- (void)didFailFindingEstimoteBeaconsForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"didFailFindingEstimoteBeaconsForRegion: %@", [error description]);
}


#pragma mark - ARTNativeBeaconDelegate
/*
- (void)didFindiOSBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons lastObject]) {
        [self alertBeaconsFound:beacons];
    }
}

- (void)didFailFindingiOSBeaconsForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"didFailFindingiOSBeaconsForRegion");
}


- (void)didFailEnablingBluetooth {
    NSLog(@"didFailEnablingBluetooth");
}


- (void)didSetupDeviceAsBeacon:(NSDictionary *)beaconInfo
{
    NSLog(@"didSetupDeviceAsBeacon");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Registered"
                                                                   message:@"Device is transmitting as a beacon!"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
 */


#pragma mark - ARTWebViewDelegate
- (void)webViewIsLoading:(UIWebView *)webView forPageRequest:(NSURLRequest *)request
{
    //Create a new view controller and pop onto the navigation...
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ARTWebViewController *nextWebViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    [nextWebViewController setUrlToLoad:[request.URL absoluteURL]];
    
    [self.navigationController pushViewController:nextWebViewController
                                         animated:YES];
}


- (void)webViewDidFindTitle:(NSString *)title {
    [self setTitle:[title capitalizedString]];
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    //This prevents the root VC from loading the next page...
    if ([[navigationController topViewController] isEqual:viewController]) {
        [self.rootWebViewController.webView goBack];
    }
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([[viewController class] isSubclassOfClass:[ARTWebViewController class]]) {
        [[viewController view] setFrame:self.containerView.frame];
    }
}


@end
