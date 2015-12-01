//
//  UserManager.m
//  base
//
//  Created by rebecca biaz on 11/20/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

static UserManager *sharedInstance = nil;

+ (UserManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [UserManager load];

            if (sharedInstance == nil)
            {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_users forKey:@"users"];
}

- (instancetype)init
{
    self = [super init];
    
    [self initialize:nil];

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _users = [aDecoder decodeObjectForKey:@"users"];
        
        [self initialize:aDecoder];
    }
    return self;
}

- (void)initialize:(NSCoder *)aDecoder
{
    if (!_users)
    {
        _users = [NSMutableArray array];
    }
    
    TeacherInfo *testUser = [[TeacherInfo alloc] init];
    testUser.name = @"test";
    testUser.password = @"123456";
    StudentInfo *student1 = [[StudentInfo alloc] init];
    StudentInfo *student2 = [[StudentInfo alloc] init];

    student1.name = @"student1";
    student2.name = @"student2";
    
    StudentInfo *student3 = [[StudentInfo alloc] init];
    student3.name = @"student3";

    [testUser addStudent:student1];
    [testUser addStudent:student2];
    [testUser addStudent:student3];

    [self addUser:testUser];
}

- (NSArray *)users
{
    return _users;
}

- (BOOL)checkUsername:(NSString *)username andPAssword:(NSString *)password
{
    TeacherInfo *checkTeacher = [[TeacherInfo alloc] init];
    checkTeacher.name = username;
    checkTeacher.password = password;
    NSInteger index = [_users indexOfObject:checkTeacher];
    
    if (index != NSNotFound)
    {
        _currentTeacher = [_users objectAtIndex:index];
        [Shared postNotification:TEACHER_STATUS_NOTIFICATION];
        return YES;
    }
    
    return NO;
}

- (BOOL)checkStudent:(NSString *)username
{
    StudentInfo *checkStudent = [[StudentInfo alloc] init];
    checkStudent.name = username;
    NSInteger index = [[[self currentTeacher] students] indexOfObject:checkStudent];
    
    if (index != NSNotFound)
    {
        _currentStudent = [[[self currentTeacher] students] objectAtIndex:index];
        [Shared postNotification:STUDENT_STATUS_NOTIFICATION];
        return YES;
    }
    
    return NO;
}

- (void)addStudentToCurrentTeacher:(StudentInfo *)student
{
    [[self currentTeacher] addStudent:student];
    
    [Shared postNotification:STUDENTS_CHANDED_NOTIFICATION];
    [self save];
}

- (void)addUser:(TeacherInfo *)userInfo
{
    if (![_users containsObject:userInfo])
    {
        [_users addObject:userInfo];
        [self save];
    }
}

- (TeacherInfo *)currentTeacher
{
    return _currentTeacher;
}

- (StudentInfo *)currentStudent
{
    return _currentStudent;
}

- (NSString *)filePathForCurrentStudent
{
    return nil;
}

- (BOOL)teacherLogedIn
{
    return !(_currentTeacher == nil);
}

- (BOOL)studentLogedIn
{
    return !(_currentStudent == nil);
}

- (void)logoutStudent
{
    _currentStudent = nil;
    [Shared postNotification:STUDENT_STATUS_NOTIFICATION];
}

- (void)logoutTeacher
{
    _currentTeacher = nil;
    _currentStudent = nil;

    [Shared postNotification:TEACHER_STATUS_NOTIFICATION];
}

@end
