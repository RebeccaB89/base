//
//  UIRegisterViewController.h
//  base
//
//  Created by rebecca biaz on 11/26/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIRegisterViewController : UIViewController
{
    __weak IBOutlet UILabel *_titleLabel;
    
    
    __weak IBOutlet UITextField *_usernameTextField;
    
    __weak IBOutlet UITextField *_passwordTextfield;
    
    
    __weak IBOutlet UITextField *_repeatPassTextField;
    
    
    __weak IBOutlet UIButton *_addButton;
    
    
    __weak IBOutlet UIButton *_cancelButton;
}

- (IBAction)addButtonClicked:(UIButton *)sender;
- (IBAction)cancelClicked:(UIButton *)sender;

@end
