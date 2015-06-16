//
//  ARCNetworkManager.m
//  RedHat
//
//  Created by Mike Post on 2015-06-15.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCNetworkManager.h"

NSString *const ROOT_URL            = @"redhatairportdemo-fguanlao.rhcloud.com";
NSString *const HTTP_METHOD_GET     = @"GET";
NSString *const HTTP_METHOD_POST    = @"POST";


@interface ARCNetworkManager()

- (NSURLSession *)backgroundSession;

- (void)sendGETRequest:(NSURLRequest *)urlRequest withCompletion:(ARCNetworkCompletion)completion;

- (void)sendPOSTRequest:(NSMutableURLRequest *)urlRequest withCompletion:(ARCNetworkCompletion)completion;

@end


@implementation ARCNetworkManager


- (id)init
{
    self = [super init];
    
    if (self) {
        self.urlSession = [self backgroundSession];
    }
    return self;
}


- (NSURLSession *)backgroundSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSString *identifier = [NSString stringWithFormat:@"%@.BackgroundSession", [[NSBundle mainBundle] bundleIdentifier]];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifier];

        session = [NSURLSession sessionWithConfiguration:configuration
                                                delegate:self
                                           delegateQueue:nil];
    });
    return session;
}


- (void)postBeaconFoundWithMethod:(NSString *)httpMethod completion:(ARCNetworkCompletion)completion
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *statusNum = [userDefaults objectForKey:@"NOTIFICATION_TYPE"];
    
    if (statusNum == nil) {
        statusNum = @2;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",
                                       ROOT_URL,
                                       [NSString stringWithFormat:@"rest/digitalSignage/%@", statusNum]]];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:15.0];

    if ([httpMethod isEqualToString:HTTP_METHOD_GET]) {
        [self sendGETRequest:urlRequest
              withCompletion:completion];
    }
    else if ([httpMethod isEqualToString:HTTP_METHOD_POST]) {
        [self sendPOSTRequest:(NSMutableURLRequest *)urlRequest
               withCompletion:completion];
    }
}


- (void)sendGETRequest:(NSURLRequest *)urlRequest withCompletion:(ARCNetworkCompletion)completion
{
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                               completion(response, data, connectionError);
                           }];
}


- (void)sendPOSTRequest:(NSMutableURLRequest *)urlRequest withCompletion:(ARCNetworkCompletion)completion
{
    [urlRequest setHTTPMethod:@"POST"];
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"showDetails",
                             nil];
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [urlRequest setHTTPBody:postData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *postSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [postSession dataTaskWithRequest:urlRequest
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                            if (error) {
                                                                NSLog(@"POST error: %@", [error description]);
                                                            }
                                                        }];
    
    [postDataTask resume];
}


#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"NSURLSessionDataDelegate didReceiveResponse");
}


#pragma mark - NSURLSessionDelegate
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"All tasks are finished");
}


#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error == nil) {
        NSLog(@"Task: %@ completed successfully", task);
    }
    else {
        NSLog(@"Task: %@ completed with error: %@", task, [error localizedDescription]);
    }
}


@end
