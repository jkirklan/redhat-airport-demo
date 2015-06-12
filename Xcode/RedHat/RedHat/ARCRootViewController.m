//
//  ViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCRootViewController.h"


@interface ARCRootViewController ()

/**
 Not for production code. Remove property and functionality after demo purposes!
 */
@property (nonatomic, assign) NSUInteger urlRefreshNumber;

- (void)adminNotificationReceived:(NSNotification *)notification;

@end


@implementation ARCRootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adminNotificationReceived:)
                                                 name:@"ADMIN_RELOAD_REQUEST"
                                               object:nil];

    self.beaconManager = [[ATDemoBeaconManager alloc] init];
    [self.beaconManager setDelegate:self];
    
//    [self.beaconManager configureDeviceAsBeacon];

    [self.beaconManager startSearchingForBeacons];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"WebViewSegue"]) {
        self.rootWebViewController = (ARTWebViewController *)[segue destinationViewController];
        [self.rootWebViewController setDelegate:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)adminNotificationReceived:(NSNotification *)notification
{
    //Webview reload...
    NSMutableString *pageURL = [NSMutableString stringWithString:ROOT_URL];
    
    switch (self.urlRefreshNumber) {
        case 1:
            [pageURL appendString:@""];
            break;
            
        case 2:
            [pageURL appendString:@""];
            break;
            
        case 0:
        default:
            [pageURL appendString:@""];
            break;
    }
    
    [self.rootWebViewController loadWebviewWithURL:pageURL];
}


//- (void)configureDeviceAsBeacon
//{
//    //Register as a beacon...
//    NSString *uuid = @"E48AB15D-7608-4051-956E-AB4351CD3B7F";
//    self.beaconRegister = [[ARTBeaconRegister alloc] initWithUUIDString:uuid];
//    
//    [self.beaconRegister registerBeaconWithCompletion:^{
//        NSLog(@"Device is transmitting as a beacon");
//        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Registered"
//                                                                       message:@"Device is transmitting as a beacon!"
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                              handler:^(UIAlertAction * action) {}];
//        
//        [alert addAction:defaultAction];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
//                                                error:^(NSError *error) {
//                                                    NSLog(@"Device is unable to transmit as a beacon: %@", error.description);
//                                                }];
//}
//
//
//- (void)monitorForBeacons
//{
//    self.beaconManager = [[ARTBeaconManager alloc] initWithUUIDString:@"E48AB15D-7608-4051-956E-AB4351CD3B7F"];
//    [self.beaconManager setDelegate:self];
//    [self.beaconManager monitorBeaconRegionWithIdentifier:@"ca.architech.DemoRegion"];
//}


#pragma mark - ATBeaconManagerDelegate
- (void)didFindiOSBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"didFindiOSBeacons");
}

- (void)didFailFindingiOSBeaconsForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"didFailFindingiOSBeaconsForRegion");
}

- (void)didFailEnablingBluetooth {
    NSLog(@"didFailEnablingBluetooth");
}

- (void)didSetupDeviceAsBeacon:(NSDictionary *)beaconInfo {
    NSLog(@"didSetupDeviceAsBeacon");
}


#pragma mark - ARTWebViewDelegate
- (void)webViewIsLoading:(UIWebView *)webView forPageRequest:(NSURLRequest *)request
{
    //Create a new view controller and pop onto the navigation...
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ARTWebViewController *nextWebViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    [nextWebViewController setUrlOnLoad:[request.URL absoluteURL]];
    
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
