//
//  UserInfo.m
//  base
//
//  Created by rebecca biaz on 11/20/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_password forKey:@"password"];
}

- (BOOL)isEqual:(id)object
{
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    
    UserInfo *other = object;
    if (other == self || ([other.name isEqualToString:self.name] && [other.password isEqualToString:self.password]))
    {
        return YES;
    }
    
    return NO;
}

@end
