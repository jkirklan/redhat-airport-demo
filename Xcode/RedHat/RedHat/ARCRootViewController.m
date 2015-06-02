//
//  ViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCRootViewController.h"

@interface ARCRootViewController ()

@end


@implementation ARCRootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadWebviewWithURL:@"http://apple.com"];
}


- (void)loadWebviewWithURL:(NSString *)urlString
{
    if (urlString == nil) {
        //Bundle resource directories are flat to files must have UNIQUE names!
        NSURL *htmlPath = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:htmlPath];
        [self.webview loadRequest:urlRequest];
    }
    else {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [self.webview loadRequest:urlRequest];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldLoad = NO;
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        shouldLoad = YES;
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
