//
//  ARTMenuDisplayTableTableViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-04.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTMenuDisplayTableViewController.h"

@interface ARTMenuDisplayTableViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@property (nonatomic, strong) NSArray *menuIcons;

@end


@implementation ARTMenuDisplayTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuItems = @[@"Dashboard"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}



#pragma mark - Table view data source

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    
    NSString *menuName = [self.menuItems objectAtIndex:indexPath.row];
    [[cell textLabel] setText:menuName];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableViewDidSelectIndex:)]) {
        [self.delegate tableViewDidSelectIndex:indexPath];
    }
}

@end
