//
//  TeacherInfo.m
//  base
//
//  Created by rebecca biaz on 11/20/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "TeacherInfo.h"

@implementation TeacherInfo

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.students = [aDecoder decodeObjectForKey:@"students"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_students forKey:@"students"];
}

- (void)addStudent:(StudentInfo *)student
{
    if (!_students)
    {
        _students = [NSMutableArray array];
    }
    
    if (![_students containsObject:student])
    {
        [_students addObject:student];
    }
}

@end
