//
//  NSURL+Ext.m
//  RedHat
//
//  Created by Mike Post on 2015-06-17.
//  Copyright (c) 2015 Architech. All rights reserved.
//

#import "NSURL+Ext.h"

@implementation NSURL (Ext)

- (BOOL)isEqualToURL:(NSURL *)url
{
    NSMutableString *pathString1 = [NSMutableString stringWithFormat:@"%@", [self absoluteString]];
    
    if ([[self path] isEqualToString:@"/"]) {
        [pathString1 deleteCharactersInRange:NSMakeRange((pathString1.length - 1), 1)];
    }
    
    NSMutableString *pathString2 = [NSMutableString stringWithFormat:@"%@", [url absoluteString]];
    NSString *lastChar = [pathString2 substringFromIndex:(pathString2.length - 1)];
    
    if ([lastChar isEqualToString:@"/"]) {
        [pathString2 deleteCharactersInRange:NSMakeRange((pathString2.length - 1), 1)];
    }
    
    BOOL isEqual = [pathString1 isEqualToString:pathString2];
    return isEqual;
}

@end
