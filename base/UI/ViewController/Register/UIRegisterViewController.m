//
//  UIRegisterViewController.m
//  base
//
//  Created by rebecca biaz on 11/26/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIRegisterViewController.h"

@interface UIRegisterViewController ()

@end

@implementation UIRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _titleLabel.text = NLS(@"Please fill fields to add teacher:");
    
    _usernameTextField.placeholder = NLS(@"Username");
    _passwordTextfield.placeholder = NLS(@"Password");
    _repeatPassTextField.placeholder = NLS(@"Repeat Password");
    
    [_addButton setTitle:NLS(@"Add Teacher") forState:UIControlStateNormal];
    _addButton.layer.cornerRadius = 10.0f;
    
    [_cancelButton setTitle:NLS(@"Cancel") forState:UIControlStateNormal];
    _cancelButton.layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)checkInput
{
    BOOL goodInput = YES;
    
    if (_usernameTextField.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:NLS(@"Username error") message:NLS(@"Please enter right username") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        goodInput = NO;
        return goodInput;
    }
    
    if (_passwordTextfield.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:NLS(@"Password error") message:NLS(@"Please enter right password") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        goodInput = NO;
        return goodInput;
    }
    
    if (_repeatPassTextField.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:NLS(@"Repeat password error") message:NLS(@"Please repeat the password") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        goodInput = NO;
        return goodInput;
    }
    if (![_repeatPassTextField.text isEqualToString:_passwordTextfield.text])
    {
        [[[UIAlertView alloc] initWithTitle:NLS(@"Repeat password error") message:NLS(@"the password and repeat password fields are not the same") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        goodInput = NO;
        return goodInput;
    }
    
    return goodInput;
}

- (IBAction)addButtonClicked:(UIButton *)sender
{
    if ([self checkInput])
    {
        TeacherInfo *teacherInfo = [[TeacherInfo alloc] init];
        teacherInfo.name = _usernameTextField.text;
        teacherInfo.password = _passwordTextfield.text;
        
        [[UserManager sharedInstance] addUser:teacherInfo];
        
         [[[UIAlertView alloc] initWithTitle:NLS(@"Teacher added") message:NLS(@"the teacher added with success, now you can login!") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
