//
//  ARTMenuTransitionManager.m
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTMenuTransitionManager.h"

@interface ARTMenuTransitionManager()

@property (nonatomic, assign, getter=isPresenting) BOOL presenting;

@end


@implementation ARTMenuTransitionManager

- (id)init
{
    self = [super init];
    
    if (self) {
        self.presenting = NO;
    }
    return self;
}


#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.presenting = YES;
    return self;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presenting = NO;
    return self;
}


- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source
{
    ARTMenuPresentationController *presentationController = [[ARTMenuPresentationController alloc] initWithPresentedViewController:presented
                                                                                                          presentingViewController:presenting];
    return presentationController;
}


#pragma mark - UIViewControllerAnimatedTransitioning



@end
