//
//  ARTWebViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-06-03.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ARTWebViewDelegate <NSObject>

@optional
/**
 Use this if you're implementing a UINavigationController, and would like to push a new webview when it's loading.
 */
- (void)webViewIsLoading:(UIWebView *)webView forPageRequest:(NSURLRequest *)request;

/**
 Notifies the delegate as soon as the text within the HTML <title> tag is found.
 */
- (void)webViewDidFindTitle:(NSString *)title;

@end


extern NSString *const ROOT_URL;


@interface ARTWebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, assign) id <ARTWebViewDelegate> delegate;

@property (nonatomic, strong) NSURL *urlOnLoad;

@property (nonatomic, strong) IBOutlet UIWebView *webView;

/**
 Sets an NSURL using the string. If `urlString` is nil, the default HTML files embedded into the app are loaded.
 */
- (void)loadWebviewWithURL:(NSString *)urlString;

@end
