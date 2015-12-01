//
//  StudentInfo.m
//  base
//
//  Created by rebecca biaz on 11/20/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "StudentInfo.h"

@implementation StudentInfo


- (BOOL)isEqual:(id)object
{
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    
    StudentInfo *other = object;
    if (other == self || ([other.name isEqualToString:self.name]))
    {
        return YES;
    }
    
    return NO;
}

@end
