//
//  TeacherInfo.h
//  base
//
//  Created by rebecca biaz on 11/20/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UserInfo.h"
#import "StudentInfo.h"

@interface TeacherInfo : UserInfo

@property (nonatomic, strong) NSMutableArray *students;

- (void)addStudent:(StudentInfo *)student;

@end
