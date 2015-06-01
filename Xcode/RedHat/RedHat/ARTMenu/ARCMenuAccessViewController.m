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
    
    UIStoryboard *menuStoryboard = [UIStoryboard storyboardWithName:@"ARTMenu" bundle:nil];
    self.menuTableViewController = (ARTMenuTableViewController *)[menuStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self.menuTableViewController setDelegate:self];
}


- (void)showMenu {
}


#pragma mark - ARTMenuTableViewControllerDelegate
- (void)menuDidSelectViewController:(UIViewController *)viewController
{
    
}


@end
