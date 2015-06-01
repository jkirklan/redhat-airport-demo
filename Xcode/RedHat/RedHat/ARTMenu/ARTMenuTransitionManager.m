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

@property (nonatomic, assign) NSTimeInterval duration;

@end


@implementation ARTMenuTransitionManager

- (id)init
{
    self = [super init];
    
    if (self) {
        self.presenting = NO;
        //Default...
        self.duration = 0.5;
    }
    return self;
}


- (id)initWithDuration:(NSTimeInterval)duration
{
    self = [self init];
    
    if (self) {
        self.duration = duration;
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
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];
    UIView *dimmingView = [[container subviews] firstObject];
    
    UIView *fromView = [[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] view];
    UIView *toView = [[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] view];
    
    CGAffineTransform offScreenRight = CGAffineTransformMakeTranslation((container.bounds.size.width * 0.8), 0);
    CGAffineTransform offScreenLeft = CGAffineTransformMakeTranslation(-container.bounds.size.width, 0);
    
    if (self.presenting == YES) {
        toView.transform = offScreenLeft;
    }

    [container addSubview:fromView];
#warning - BUG: dimming view dissapears during a custom animation
    [container addSubview:dimmingView];
    [container addSubview:toView];
    
    //Perform animation...
    [UIView animateWithDuration:self.duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         if ([self isPresenting]) {
                             fromView.transform = offScreenRight;
                             toView.transform = CGAffineTransformIdentity;
                         }
                         else {
                             fromView.transform = offScreenLeft;
                             toView.transform = CGAffineTransformIdentity;
                         }
                     }
                     completion:^(BOOL finished) {
                         //Tell our transitionContext object that we've finished animating...
                         [transitionContext completeTransition:YES];
                         
                         #warning - BUG: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                         [[[UIApplication sharedApplication] keyWindow] addSubview:toView];
                     }];
}



@end

