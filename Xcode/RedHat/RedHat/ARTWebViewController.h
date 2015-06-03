//
//  ARTWebViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-06-03.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARTWebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;

/**
 Sets an NSURL using the string. If `urlString` is nil, the default HTML files embedded into the app are loaded.
 */
- (void)loadWebviewWithURL:(NSString *)urlString;

@end
