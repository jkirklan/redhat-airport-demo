//
//  ARTMenuTableViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTMenuDisplayController.h"

@interface ARTMenuDisplayController()

@end


@implementation ARTMenuDisplayController


- (id)initWithDelegate:(id <ARTMenuDisplayDelegate>)delegate
{
    self = [super init];
    
    if (self) {
        [self setDelegate:delegate];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MenuDisplayTableSegue"]) {
        self.tableViewController = (ARTMenuDisplayTableViewController *)[segue destinationViewController];
        [self.tableViewController setDelegate:self];
    }
}


#pragma mark - ARTMenuDisplayTableDelegate
- (void)tableViewDidSelectIndex:(NSIndexPath *)index
{
    if ([self.delegate respondsToSelector:@selector(menuDidSelectMenuItem:)]) {
        [self.delegate menuDidSelectMenuItem:index.row];
    }
}

@end
