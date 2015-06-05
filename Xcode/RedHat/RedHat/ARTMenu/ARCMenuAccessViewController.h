//
//  ARCMenuAccessViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTMenuTransitionManager.h"
#import "ARTMenuDisplayController.h"

@interface ARCMenuAccessViewController : UIViewController <ARTMenuDisplayDelegate>

@property (nonatomic, strong) ARTMenuTransitionManager *transitionManager;

@property (nonatomic, strong) ARTMenuDisplayController *menuTableViewController;

@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;

- (void)setupMenu;

- (IBAction)showMenu:(id)sender;

@end
