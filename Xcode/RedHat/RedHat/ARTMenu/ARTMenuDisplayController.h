//
//  ARTMenuTableViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTMenuDisplayTableViewController.h"


@protocol ARTMenuDisplayDelegate <NSObject>

- (void)menuDidSelectMenuItem:(NSUInteger)menuItem;

@end


@interface ARTMenuDisplayController : UIViewController <ARTMenuDisplayTableDelegate>

@property (nonatomic, assign) id <ARTMenuDisplayDelegate> delegate;

@property (nonatomic, strong) ARTMenuDisplayTableViewController *tableViewController;

/**
 Convenience initialiser.
 */
- (id)initWithDelegate:(id <ARTMenuDisplayDelegate>)delegate;

@end
