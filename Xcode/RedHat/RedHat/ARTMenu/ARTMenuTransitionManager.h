//
//  ARTMenuTransitionManager.h
//  RedHat
//
//  Created by Mike Post on 2015-06-01.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARTMenuPresentationController.h"

@interface ARTMenuTransitionManager : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

/**
 Convenience initialiser.
 */
- (id)initWithDuration:(NSTimeInterval)duration;

@end
