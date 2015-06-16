//
//  ARCNetworkManager.h
//  RedHat
//
//  Created by Mike Post on 2015-06-15.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <NetworkExtension/NetworkExtension.h>

extern NSString *const ROOT_URL;
extern NSString *const HTTP_METHOD_GET;
extern NSString *const HTTP_METHOD_POST;


typedef void(^ARCNetworkCompletion)(NSURLResponse *response, NSData *data, NSError *connectionError);


@interface ARCNetworkManager : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *urlSession;

/**
 @param httpMethod is either HTTP_METHOD_GET or HTTP_METHOD_POST
 */
- (void)postBeaconFoundWithMethod:(NSString *)httpMethod completion:(ARCNetworkCompletion)completion;

/**
 @param httpMethod is either HTTP_METHOD_GET or HTTP_METHOD_POST
 */
- (void)postBeaconExitedWithMethod:(NSString *)httpMethod completion:(ARCNetworkCompletion)completion;

@end
