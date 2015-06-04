//
//  ARTMenuTableViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTMenuTableViewController.h"

@interface ARTMenuTableViewController()

@property (nonatomic, strong) NSArray *menuItems;

@property (nonatomic, strong) NSArray *menuIcons;

@end


@implementation ARTMenuTableViewController


- (id)initWithDelegate:(id <ARTMenuTableViewControllerDelegate>)delegate
{
    self = [super init];
    
    if (self) {
        [self setDelegate:delegate];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuItems = @[@"Dashboard"];
}


#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(menuDidSelectMenuItem:)]) {
        [self.delegate menuDidSelectMenuItem:indexPath.row];
    }
}


@end
