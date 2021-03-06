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
    
    self.transitionManager = [[ARTMenuTransitionManager alloc] initWithDuration:0.4];
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
    self.menuTableViewController = (ARTMenuDisplayController *)[menuStoryboard instantiateViewControllerWithIdentifier:@"MenuDisplayController"];
    
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
                         //[self.leftBarButtonItem setEnabled:NO];
                     }];
}


#pragma mark - ARTMenuDisplayDelegate
- (void)menuDidSelectMenuItem:(NSUInteger)menuItem
{
    //viewControllers = @[[menuStoryboard instantiateViewControllerWithIdentifier:@"RootViewController"]];
    
    NSDictionary *userInfo = @{@"MENU_ITEM_TAPPED": (NSNumber *)@(menuItem)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADMIN_RELOAD_REQUEST"
                                                        object:self
                                                      userInfo:userInfo];
    NSArray *viewControllers = @[[[self.navigationController viewControllers] objectAtIndex:0]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                    [self.navigationController setViewControllers:viewControllers];
                                    //[self.leftBarButtonItem setEnabled:YES];
                                 }];
    });
}


@end
