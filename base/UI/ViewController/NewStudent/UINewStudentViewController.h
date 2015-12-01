//
//  UINewStudentViewController.h
//  base
//
//  Created by rebecca biaz on 11/26/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINewStudentViewController : UIViewController
{
    __weak IBOutlet UITextField *_usernameTextField;
    __weak IBOutlet UIButton *_cancelButton;
    
    __weak IBOutlet UIButton *_addButton;
}

- (IBAction)cancelClicked:(UIButton *)sender;

- (IBAction)addClicked:(UIButton *)sender;

@end
