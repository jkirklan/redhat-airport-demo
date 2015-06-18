//
//  AppDelegate.m
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "AppDelegate.h"
#import "AeroGearPush.h"
#import "ARCRootViewController.h"


@interface AppDelegate ()

- (void)registerPushNotifications;

@end


@implementation AppDelegate 


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Status bar to white...
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self registerPushNotifications];
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


#pragma mark - Push Notifications
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //Called when the user opens the app via the notification...
    static NSString *notificationType = @"NOTIFICATION_TYPE";
    
    if ([userInfo count] > 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        ARCFlightStatus status = [(NSNumber *)[userInfo objectForKey:notificationType] floatValue];
        
        [defaults setObject:@(status)
                     forKey:notificationType];
        [defaults synchronize];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ARCApplicationDidReceiveRemoteNotification
                                                        object:self
                                                      userInfo:userInfo];
    
    completionHandler(UIBackgroundFetchResultNoData);
}


- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
    completionHandler();
}


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
                                          [NSURL URLWithString:@"https://jbossunifiedpush-fguanlao.rhcloud.com/ag-push/"]];
    
    [registration registerWithClientInfo:^(id<AGClientDeviceInformation> clientInfo) {
        [clientInfo setDeviceToken:deviceToken];
        
        //Development:
//        [clientInfo setVariantID:@"4678691c-3aec-4899-8a32-7f5d35e3ef56"];
//        [clientInfo setVariantSecret:@"3ff3722e-ce90-4627-93f1-81c69d6e4209"];
        
        //Production:
        [clientInfo setVariantID:@"5c7387c7-8d85-4ee2-bd4a-74e4f5aebf88"];
        [clientInfo setVariantSecret:@"9e876606-8362-493d-8fc9-9f6a5487eb4c"];
        
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
