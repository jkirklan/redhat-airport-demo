//
//  ViewController.h
//  RedHat
//
//  Created by Mike Post on 2015-05-27.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARCMenuAccessViewController.h"
#import "ARTWebViewController.h"


@interface ARCRootViewController : ARCMenuAccessViewController <ARTWebViewDelegate>

@property (nonatomic, strong) ARTWebViewController *rootWebViewController;

@end

