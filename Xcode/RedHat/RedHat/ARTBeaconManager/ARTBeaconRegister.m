//
//  ARTBeaconRegister.m
//  RedHat
//
//  Created by Mike Post on 2015-06-10.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "ARTBeaconRegister.h"

@implementation ARTBeaconRegister


- (id)initWithUUIDString:(NSString *)uuid {
    self = [super init];
    
    if (self) {
        self.uuid = uuid;
    }
    return self;
}


@end
