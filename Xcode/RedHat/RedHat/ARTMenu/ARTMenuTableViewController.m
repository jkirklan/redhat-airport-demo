//
//  ARTMenuTableViewController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTMenuTableViewController.h"

@implementation ARTMenuTableViewController


- (id)initWithDelegate:(id <ARTMenuTableViewControllerDelegate>)delegate
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

@end
