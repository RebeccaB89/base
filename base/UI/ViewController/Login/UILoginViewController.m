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
        [[UserManager sharedInstance] checkUsername:_usernameTextField.text andPAssword:_passwordTextField.text];
    }
}

- (IBAction)registerCliked:(UIButton *)sender
{
    [[viewLogic sharedInstance] presentRegisterModalViewController];
}

@end
