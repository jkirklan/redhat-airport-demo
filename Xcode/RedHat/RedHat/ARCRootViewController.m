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
    [self.navigationController setDelegate:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"WebViewSegue"]) {
        self.rootWebViewController = (ARTWebViewController *)[segue destinationViewController];
        [self.rootWebViewController setDelegate:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - ARTWebViewDelegate
- (void)webViewIsLoading:(UIWebView *)webView forPageRequest:(NSURLRequest *)request
{
    //Create a new view controller and pop onto the navigation...
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ARTWebViewController *nextWebViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    [nextWebViewController setUrlOnLoad:[request.URL absoluteURL]];
    
    [self.navigationController pushViewController:nextWebViewController
                                         animated:YES];
}


- (void)webViewDidFindTitle:(NSString *)title {
    [self setTitle:[title capitalizedString]];
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    //This prevents the root VC from loading the next page...
    if ([[navigationController topViewController] isEqual:viewController]) {
        [self.rootWebViewController.webView goBack];
    }
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([[viewController class] isSubclassOfClass:[ARTWebViewController class]]) {
        [[viewController view] setFrame:self.containerView.frame];
    }
}


@end
