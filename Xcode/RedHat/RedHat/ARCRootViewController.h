//
//  ViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCMenuAccessViewController.h"

@interface ARCRootViewController : ARCMenuAccessViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webview;

- (void)loadWebviewWithURL:(NSString *)urlString;

@end

