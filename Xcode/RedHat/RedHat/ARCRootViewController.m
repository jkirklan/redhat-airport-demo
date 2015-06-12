//
//  ViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCRootViewController.h"


@interface ARCRootViewController ()

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
    NSMutableString *pageURL = [NSMutableString stringWithString:[NSString stringWithFormat:@"http://%@", ROOT_URL]];
    
    /**
     Not for production code. Remove property and functionality after demo purposes!
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger urlRefreshNumber = [[defaults objectForKey:@"kvoURLRefreshNumber"] integerValue];
    NSLog(@"urlRefreshNumber == %ld", urlRefreshNumber);
    
    switch (urlRefreshNumber) {
        case 1:
            [pageURL appendString:@"/index.html?flight=delayed"];
            urlRefreshNumber = 0;
            break;
            
        case 0:
        default:
            [pageURL appendString:@"/index.html?flight=ontime"];
            urlRefreshNumber = 1;
            break;
    }
    
    [defaults setObject:[NSString stringWithFormat:@"%ld", urlRefreshNumber]
                 forKey:@"kvoURLRefreshNumber"];
    [defaults synchronize];
    
    [self.rootWebViewController loadWebviewWithURL:pageURL];
    
    //Restart the search for beacons...
    [self.beaconManager startSearchingForBeacons];
}


#pragma mark - ATBeaconManagerDelegate
- (void)didFindiOSBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons lastObject]) {
        [beacons enumerateObjectsUsingBlock:^(CLBeacon *beacon, NSUInteger idx, BOOL *stop) {
            if (beacon.proximity == CLProximityImmediate) {
                [self.beaconManager stopSearchingForBeacons];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Beacon Found!"
                                                                               message:@"Please look at the screen for flight information."
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
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
