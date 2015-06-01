//
//  ARCMenuAccessViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCMenuAccessViewController.h"

@implementation ARCMenuAccessViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transitionManager = [[ARTMenuTransitionManager alloc] initWithDuration:0.5];
    [self setupMenu];
    
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = self.leftBarButtonItem;
}


- (void)setupMenu
{
    UIStoryboard *menuStoryboard = [UIStoryboard storyboardWithName:@"ARTMenu" bundle:nil];
    self.menuTableViewController = (ARTMenuTableViewController *)[menuStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self.menuTableViewController setDelegate:self];
    [self.menuTableViewController setModalPresentationStyle:UIModalPresentationCustom];
    [self.menuTableViewController setTransitioningDelegate:self.transitionManager];
}


- (IBAction)showMenu:(id)sender
{
    if (self.menuTableViewController == nil) {
        [self setupMenu];
    }
    
    [self presentViewController:self.menuTableViewController
                       animated:YES
                     completion:^{
                         [self.leftBarButtonItem setEnabled:NO];
                     }];
}


#pragma mark - ARTMenuTableViewControllerDelegate
- (void)menuDidSelectViewController:(UIViewController *)viewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                    [self.navigationController setViewControllers:@[viewController]];
                                     [self.leftBarButtonItem setEnabled:YES];
                                 }];
    });
}


@end
