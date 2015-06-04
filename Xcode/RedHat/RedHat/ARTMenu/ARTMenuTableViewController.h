//
//  ARTMenuTableViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ARTMenuTableViewControllerDelegate <NSObject>

- (void)menuDidSelectMenuItem:(NSUInteger)menuItem;

@end


@interface ARTMenuTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <ARTMenuTableViewControllerDelegate> delegate;

@property (nonatomic, strong) UITableViewController *tableViewController;

/**
 Convenience initialiser.
 */
- (id)initWithDelegate:(id <ARTMenuTableViewControllerDelegate>)delegate;

@end
