//
//  viewLogic.m
//  base
//
//  Created by Rebecca Biaz on 5/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "viewLogic.h"

@implementation viewLogic

static viewLogic *sharedInstance = nil;

+ (viewLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
        return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logedIn:) name:TEACHER_STATUS_NOTIFICATION object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(studentChoosed:) name:STUDENT_STATUS_NOTIFICATION object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationLaunched
{
    //[self presentMainViewController];
    [self presentViewAccordingToUserStatus];
    return;
}

- (void)presentViewAccordingToUserStatus
{
    if ([[UserManager sharedInstance] teacherLogedIn])
    {
        if ([[UserManager sharedInstance] studentLogedIn])
        {
            [self presentMainViewController];
        }
        else
        {
            [self presentStudentChooserViewController];
        }
    }
    else
    {
        [self presentLoginViewController];
    }
}

- (void)presentMainViewController
{
    _magnetBoardViewController = [UIMagnetBoardViewController loadFromNib];
    [self presentViewController:_magnetBoardViewController animated:NO onWindow:YES completion:nil];
}

- (void)presentLoginViewController
{
    UILoginViewController *loginVC = [UILoginViewController loadFromNib];
    
    [self presentViewController:loginVC animated:NO onWindow:YES completion:nil];
}

- (void)presentRegisterModalViewController
{
    UIRegisterViewController *loginVC = [UIRegisterViewController loadFromNib];
    loginVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [[self currentViewController] presentViewController:loginVC animated:YES completion:nil];
}

- (void)presentNewStudentModalViewController
{
    UINewStudentViewController *loginVC = [UINewStudentViewController loadFromNib];
    loginVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [[self currentViewController] presentViewController:loginVC animated:YES completion:nil];
}

- (void)presentStudentChooserViewController
{
    UIStudentChooserViewController *studentChooserVC = [UIStudentChooserViewController loadFromNib];
    studentChooserVC.students = [[[UserManager sharedInstance] currentTeacher] students];
    
    [self presentViewController:studentChooserVC animated:NO onWindow:YES completion:nil];
}

- (void)presentModalViewController:(UIViewController *)viewController
{
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:viewController animated:YES onWindow:NO completion:nil];
}

- (UIViewController *)currentViewController
{
    if ([[Shared appDelegate].window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        UIViewController *currentController = [((UINavigationController *)[Shared appDelegate].window.rootViewController) topViewController];
        return currentController;
    }
    return [Shared appDelegate].window.rootViewController;
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated onWindow:(BOOL)onWindow completion:(void (^)(void))completion
{
    if (onWindow)
        [Shared appDelegate].window.rootViewController = viewController;
    else
        [[self currentViewController] presentViewController:viewController animated:animated completion:completion];
}

- (UIMagnetBoardViewController *)magnetBoardViewController
{
    return _magnetBoardViewController;
}

- (void)logedIn:(NSNotification *)notification
{
    [self presentViewAccordingToUserStatus];
}

- (void)logedOut:(NSNotification *)notification
{
    [self presentViewAccordingToUserStatus];
}

- (void)studentChoosed:(NSNotification *)notification
{
    [self presentViewAccordingToUserStatus];
}

@end
