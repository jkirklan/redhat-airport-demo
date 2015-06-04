//
//  ARTMenuDisplayTableTableViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-06-04.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ARTMenuDisplayTableDelegate <NSObject>

- (void)tableViewDidSelectIndex:(NSIndexPath *)index;

@end


@interface ARTMenuDisplayTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <ARTMenuDisplayTableDelegate> delegate;

@end
