//
//  UIStudentChooserViewController.h
//  base
//
//  Created by rebecca biaz on 11/22/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStudentChooserViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    __weak IBOutlet UIPickerView *_pickerView;
    
    __weak IBOutlet UIButton *_chooserButton;
    
    
    __weak IBOutlet UIButton *_addButton;
}

@property (nonatomic, strong) NSArray *students;

- (IBAction)chooserButtonClicked:(UIButton *)sender;
- (IBAction)addStudentButton:(UIButton *)sender;

@end
