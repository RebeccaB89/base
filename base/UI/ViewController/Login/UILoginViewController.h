//
//  UILoginViewController.h
//  base
//
//  Created by rebecca biaz on 11/22/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILoginViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_usernameTextField;
    
    __weak IBOutlet UITextField *_passwordTextField;
    
    __weak IBOutlet UIButton *_loginButton;
    
    __weak IBOutlet UIButton *_registerButton;
    
    __weak IBOutlet NSLayoutConstraint *_loginViewYCenterConstraint;
    
}


- (IBAction)loginClicked:(UIButton *)sender;
- (IBAction)registerCliked:(UIButton *)sender;

@end
