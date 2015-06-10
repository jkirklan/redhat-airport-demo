//
//  AppDelegate.m
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "AppDelegate.h"
#import "AeroGearPush.h"


@interface AppDelegate ()

- (void)registerPushNotifications;

- (void)configureDeviceAsBeacon;

- (void)monitorForBeacons;

@end


@implementation AppDelegate 


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self registerPushNotifications];
    
    //NOTE: only uncomment if you want to set up device as a beacon.
//    [self configureDeviceAsBeacon];
    
    //Set up beacon monitoring...
    [self monitorForBeacons];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)configureDeviceAsBeacon
{
    self.beaconRegister = [[ARTBeaconRegister alloc] initWithUUIDString:@"E48AB15D-7608-4051-956E-AB4351CD3B7F"];

    [self.beaconRegister registerBeaconWithCompletion:^{
        NSLog(@"Device is transmitting as a beacon");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Registered"
                                                                       message:@"Device is transmitting as a beacon!"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
                                           error:^(NSError *error) {
                                               NSLog(@"Device is unable to transmit as a beacon: %@", error.description);
                                           }];
}


- (void)monitorForBeacons
{
    self.beaconManager = [[ARTBeaconManager alloc] initWithUUIDString:@"E48AB15D-7608-4051-956E-AB4351CD3B7F"];
    [self.beaconManager setDelegate:self];
    [self.beaconManager monitorBeaconRegionWithIdentifier:[[NSBundle mainBundle] bundleIdentifier]];
}


#pragma mark - Push Notifications
- (void)registerPushNotifications
{
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge |
                                                                                         UIUserNotificationTypeSound |
                                                                                         UIUserNotificationTypeAlert)
                                                                             categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Notifications app token: %@", deviceToken);
    AGDeviceRegistration *registration = [[AGDeviceRegistration alloc] initWithServerURL:
                                          [NSURL URLWithString:@"https://aerogear-fguanlao.rhcloud.com/ag-push/"]];
    
    [registration registerWithClientInfo:^(id<AGClientDeviceInformation> clientInfo) {
        [clientInfo setDeviceToken:deviceToken];
        
        [clientInfo setVariantID:@"fe960d53-0e88-474c-bbee-7072af27d665"];
        [clientInfo setVariantSecret:@"5c6a99a8-6291-4a37-b314-c80bf35b385e"];
        
        //Device info...
        UIDevice *currentDevice = [UIDevice currentDevice];
        [clientInfo setOperatingSystem:[currentDevice systemName]];
        [clientInfo setOsVersion:[currentDevice systemVersion]];
        [clientInfo setDeviceType: [currentDevice model]];
    } success:^{
        NSLog(@"UPS registration worked");
    } failure:^(NSError *error) {
        NSLog(@"UPS registration Error: %@", error);
    }];
}


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get token. Error: %@", error);
}


@end
