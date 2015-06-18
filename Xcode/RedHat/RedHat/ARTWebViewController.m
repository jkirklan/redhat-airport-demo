//
//  ARTWebViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-03.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTWebViewController.h"
#import "NSURL+Ext.h"


//NSString *const ROOT_URL = @"apple.com";


@interface ARTWebViewController ()

@end


@implementation ARTWebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set cache...
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0
                                                            diskCapacity:0
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    
    //Load default page if it exists...
    if (self.urlToLoad == nil) {
        NSString *urlString = [NSString stringWithFormat:@"http://%@/", ROOT_URL];
        [self loadWebviewWithURL:urlString];
        self.urlToLoad = [NSURL URLWithString:urlString];
    }
    else {
        [self loadWebviewWithURL:[self.urlToLoad absoluteString]];
    }    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadWebviewWithURL:(NSString *)urlString
{
    NSURLRequest *urlRequest = nil;
    [self setUrlToLoad:[NSURL URLWithString:urlString]];
    [self.webView stopLoading];
    
    if (urlString == nil) {
        //Bundle resource directories are flat to files must have UNIQUE names!
        NSURL *htmlPath = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
        
        urlRequest = [NSURLRequest requestWithURL:htmlPath
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                  timeoutInterval:15];
        
        [self.webView loadRequest:urlRequest];
    }
    else {
        urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                  timeoutInterval:15];
        
        [self.webView loadRequest:urlRequest];
    }
}


- (void)deleteCacheWithJSMethod:(NSString *)methodName
{
    //Call the javascript function to empty the cache...
    if (methodName != nil) {
        [self.webView stringByEvaluatingJavaScriptFromString:methodName];
    }
    
    //Delete local cache (doesn't really work)...
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
    {
        if([[cookie domain] isEqualToString:ROOT_URL]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    
    //Reload webview...
    [self.webView reload];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldLoad = NO;
    NSURL *rootURL = [NSURL URLWithString:ROOT_URL];
    
    NSString *cleanHost = [[request.URL host] stringByReplacingOccurrencesOfString:@"www." withString:@""];
    NSURL *hostURL = [NSURL URLWithString:cleanHost];
    
    if ([rootURL isEqual:hostURL]) {
        shouldLoad = YES;
        
        //Notify delegate...
        if ( ([[request.URL path] length] > 1) &&
             (navigationType == UIWebViewNavigationTypeLinkClicked) )
        {
            if ([self.delegate respondsToSelector:@selector(webViewIsLoading:forPageRequest:)]) {
                [self.delegate webViewIsLoading:webView
                                 forPageRequest:request];
            }
        }
    }
    
    if ([request.URL isEqualToURL:self.urlToLoad] == NO) {
        shouldLoad = NO;
    }
    NSLog(@"shouldStartLoadWithRequest? %@", (shouldLoad==YES) ? @"YES" : @"NO");
    return shouldLoad;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad: %@", webView.request.URL);
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
#warning TODO: if time permits, test the performance time of this method and try to optimise.
    NSError *error;
    NSString *htmlBody = [NSString stringWithContentsOfURL:[webView.request URL]
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
    
    //Set the title...
    NSArray *componentOne = [htmlBody componentsSeparatedByString:@"<title>"];
    
    if ([componentOne count] >= 2)
    {
        NSArray *componentTwo = [[componentOne objectAtIndex:1] componentsSeparatedByString:@"</title>"];
        if ([componentTwo lastObject]) {
            NSString *title = [componentTwo firstObject];
            [self setTitle:[title capitalizedString]];
            
            //Notify delegate of title...
            if ([self.delegate respondsToSelector:@selector(webViewDidFindTitle:)]) {
                [self.delegate webViewDidFindTitle:title];
            }
        }
    }
    NSLog(@"webViewDidFinishLoad: %@", webView.request.URL);
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"UIWebView failed to load. Error: %@", error.description);
    
    //Try to reload. Dangerous: it'll trigger an infinite loop of reloading!
//    [webView reload];
}


@end
