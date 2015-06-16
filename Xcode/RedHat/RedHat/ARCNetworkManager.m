//
//  ARCNetworkManager.m
//  RedHat
//
//  Created by Mike Post on 2015-06-15.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCNetworkManager.h"

NSString *const ROOT_URL = @"redhatairportdemo-fguanlao.rhcloud.com";


@implementation ARCNetworkManager


- (id)init
{
    self = [super init];
    
    if (self) {
    }
    return self;
}


- (void)postBeaconFoundWithCompletion:(ARCNetworkCompletion)completion
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",
                                       ROOT_URL,
                                       @"rest/digitalSignage/updateSign"]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                               completion(response, data, connectionError);
                           }];
}


@end
