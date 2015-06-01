//
//  ARTMenuPresentationController.m
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTMenuPresentationController.h"

@interface ARTMenuPresentationController()

@property (nonatomic, strong) UIView *dimmingView;

- (void)dismissMenu;

@end


@implementation ARTMenuPresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    
    if (self) {
        [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:0.0/255.0 alpha:0.75]];
    }
    return self;
}


- (void)dismissMenu {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Overrides
- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect frame = self.containerView.bounds;
    frame.size.width = self.containerView.bounds.size.width * 0.8;
    return frame;
}


- (void)containerViewWillLayoutSubviews
{
    self.dimmingView.frame = self.containerView.bounds;
    [[self presentedView] setFrame:[self frameOfPresentedViewInContainerView]];
}


- (void)presentationTransitionWillBegin
{
    self.dimmingView.frame = self.containerView.bounds;
    self.dimmingView.alpha = 0.0;
    
    [self.containerView insertSubview:self.dimmingView
                              atIndex:0];
    
    [[self.presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1.0;
    }
                                                                          completion:NULL];
}


- (void)dismissalTransitionWillBegin
{
    [[self.presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.0;
    }
                                                                          completion:NULL];
}


@end
