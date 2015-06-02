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

- (void)dismissMenu:(UITapGestureRecognizer *)sender;

@end


@implementation ARTMenuPresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    
    if (self) {
        //Init code
    }
    return self;
}


- (UIView *)dimmingView
{
    if (_dimmingView == nil)
    {
        _dimmingView = [[UIView alloc] initWithFrame:self.containerView.frame];
        [_dimmingView setBackgroundColor:[UIColor colorWithWhite:255.0/255.0 alpha:0.75]];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(dismissMenu:)];
        [_dimmingView addGestureRecognizer:tapRecognizer];
    }
    return _dimmingView;
}


- (void)dismissMenu:(UITapGestureRecognizer *)sender {
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
