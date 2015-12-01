//
//  UserManager.h
//  base
//
//  Created by rebecca biaz on 11/20/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "BaseSerializeData.h"
#import "StudentInfo.h"
#import "TeacherInfo.h"

#define TEACHER_STATUS_NOTIFICATION          @"TEACHER_STATUS_NOTIFICATION"
#define STUDENT_STATUS_NOTIFICATION          @"STUDENT_STATUS_NOTIFICATION"
#define STUDENTS_CHANDED_NOTIFICATION        @"STUDENTS_CHANDED_NOTIFICATION"

@interface UserManager : BaseSerializeData
{
    TeacherInfo *_currentTeacher;
    StudentInfo *_currentStudent;
    NSMutableArray *_users;
}

+ (UserManager *)sharedInstance;

- (NSArray *)users;
- (BOOL)checkUsername:(NSString *)username andPAssword:(NSString *)password;
- (BOOL)checkStudent:(NSString *)username;
- (void)addStudentToCurrentTeacher:(StudentInfo *)student;
- (void)addUser:(TeacherInfo *)userInfo;
- (TeacherInfo *)currentTeacher;
- (StudentInfo *)currentStudent;

- (NSString *)filePathForCurrentStudent;
- (BOOL)teacherLogedIn;
- (BOOL)studentLogedIn;
- (void)logoutStudent;
- (void)logoutTeacher;



@end
