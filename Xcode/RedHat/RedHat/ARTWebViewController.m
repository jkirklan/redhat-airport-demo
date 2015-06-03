//
//  ARTWebViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-03.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTWebViewController.h"

NSString *const ROOT_URL = @"apple.com";


@interface ARTWebViewController ()

@end


@implementation ARTWebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadWebviewWithURL:@"http://apple.com"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadWebviewWithURL:(NSString *)urlString
{
    if (urlString == nil) {
        //Bundle resource directories are flat to files must have UNIQUE names!
        NSURL *htmlPath = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:htmlPath];
        [self.webView loadRequest:urlRequest];
    }
    else {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [self.webView loadRequest:urlRequest];
    }
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldLoad = NO;
    NSURL *rootURL = [NSURL URLWithString:ROOT_URL];
    
    NSString * cleanHost = [[request.URL host] stringByReplacingOccurrencesOfString:@"www." withString:@""];
    NSURL *hostURL = [NSURL URLWithString:cleanHost];
    
    if ( ([rootURL isEqual:hostURL]) ||
        (navigationType == UIWebViewNavigationTypeLinkClicked) ) {
        shouldLoad = YES;
        
//        [self pushNewWebview:webView forPageRequest:request];
    }
    return shouldLoad;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad: %@", webView.request.URL);
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad: %@", webView.request.URL);
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"UIWebView failed to load. Error: %@", error.description);
}


@end
