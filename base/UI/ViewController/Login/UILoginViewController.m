//
//  UILoginViewController.m
//  base
//
//  Created by rebecca biaz on 11/22/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UILoginViewController.h"

@interface UILoginViewController ()

@end

@implementation UILoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _loginButton.layer.cornerRadius = 10.0f;
    [_loginButton setTitle:NLS(@"Login") forState:UIControlStateNormal];
    
    _registerButton.layer.cornerRadius = 10.0f;
    [_registerButton setTitle:NLS(@"Register") forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    if (_passwordTextField.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:NLS(@"Password error") message:NLS(@"Please enter right password") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        goodInput = NO;
        return goodInput;
    }
    
    return goodInput;
}

- (IBAction)loginClicked:(UIButton *)sender
{
    if ([self checkInput])
    {
        BOOL goodTeacher = [[UserManager sharedInstance] checkUsername:_usernameTextField.text andPAssword:_passwordTextField.text];
        if (!goodTeacher)
        {
            [[[UIAlertView alloc] initWithTitle:NLS(@"Incorrect user") message:NLS(@"Please enter right password") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];

        }
    }
}

- (IBAction)registerCliked:(UIButton *)sender
{
    [[viewLogic sharedInstance] presentRegisterModalViewController];
}

- (void)onKeyboardWillChangeFrameNotification:(NSNotification *)sender
{
    BOOL needAnimateView = NO;
    CGRect keyboardFrame = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [sender.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    float animationTime = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    float keyboardHeight = MIN(keyboardFrame.size.width, keyboardFrame.size.height);
    
    if (USER_INTERFACE_IDIOM_IS_IPHONE)
    {
        needAnimateView = YES;
        
        _loginViewYCenterConstraint.constant = - (keyboardHeight / 2.0);
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        {
            needAnimateView = YES;
            
            _loginViewYCenterConstraint.constant = - (keyboardHeight / 2.0);
        }
    }
    
    if (needAnimateView)
    {
        [UIView animateWithDuration:animationTime
                              delay:0.0
                            options:animationCurve
                         animations:^{
                             
                             [self.view layoutIfNeeded];
                         }
                         completion:nil];
    }
}

- (void)onKeyboardWillHideNotification:(NSNotification *)sender
{
    UIViewAnimationCurve animationCurve = [sender.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    float animationTime = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    _loginViewYCenterConstraint.constant = 0.0f;
    
    [UIView animateWithDuration:animationTime
                          delay:0.0
                        options:animationCurve
                     animations:^{
                         
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}


@end
