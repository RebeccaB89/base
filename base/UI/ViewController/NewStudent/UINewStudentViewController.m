//
//  UINewStudentViewController.m
//  base
//
//  Created by rebecca biaz on 11/26/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UINewStudentViewController.h"

@interface UINewStudentViewController ()

@end

@implementation UINewStudentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _usernameTextField.placeholder = NLS(@"Username");
    
    [_addButton setTitle:NLS(@"Add Student") forState:UIControlStateNormal];
    _addButton.layer.cornerRadius = 10.0f;
    
    [_cancelButton setTitle:NLS(@"Cancel") forState:UIControlStateNormal];
    _cancelButton.layer.cornerRadius = 10.0f;
}

- (BOOL)checkInput
{
    BOOL goodInput = YES;
    
    if (_usernameTextField.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:NLS(@"Username error") message:NLS(@"Please enter right username") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        goodInput = NO;
        return goodInput;
    }
    
    return goodInput;
}


- (IBAction)cancelClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addClicked:(UIButton *)sender
{
    if ([self checkInput])
    {
        StudentInfo *studentInfo = [[StudentInfo alloc] init];
        studentInfo.name = _usernameTextField.text;
        [[UserManager sharedInstance] addStudentToCurrentTeacher:studentInfo];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
