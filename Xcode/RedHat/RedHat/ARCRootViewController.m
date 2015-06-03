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


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"WebViewSegue"]) {
        self.rootWebViewController = (ARTWebViewController *)[segue destinationViewController];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)pushNewWebview:(UIWebView *)webView forPageRequest:(NSURLRequest *)request
{
    if ([[request.URL path] length] > 1)
    {
        //Create a new view controller and pop onto the navigation...
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ARTWebViewController *nextWebViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        
//        [[nextWebViewController view] setFrame:self.view.bounds];
//        [[nextWebViewController view] setBackgroundColor:[UIColor purpleColor]];
//        [[nextWebViewController view] addSubview:self.webview];
        
//        [self.webview loadRequest:request];
        
//        [self.navigationController pushViewController:nextWebViewController
//                                             animated:YES];
    }
}


@end
