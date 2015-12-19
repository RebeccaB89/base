//
//  UIStudentChooserViewController.m
//  base
//
//  Created by rebecca biaz on 11/22/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIStudentChooserViewController.h"
#import "StudentInfo.h"

@interface UIStudentChooserViewController ()

@end

@implementation UIStudentChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _chooserButton.layer.cornerRadius = 10.0f;
    [_chooserButton setTitle:NLS(@"Choose patient") forState:UIControlStateNormal];
    
    _addButton.layer.cornerRadius = 10.0f;
    [_addButton setTitle:NLS(@"Add new patient") forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(studentsChanged:) name:STUDENTS_CHANDED_NOTIFICATION object:nil];
}

- (void)reloadData
{
    self.students = [[[UserManager sharedInstance] currentTeacher] students];
}

- (void)setStudents:(NSArray *)students
{
    _students = students;
    
    [_pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _students.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    StudentInfo *student = [_students objectAtIndex:row];
    return student.name;
}

- (IBAction)chooserButtonClicked:(UIButton *)sender
{
    StudentInfo *student = [_students objectAtIndex:[_pickerView selectedRowInComponent:0]];

    NSString *name = student.name;
    
    [[UserManager sharedInstance] checkStudent:name];
}

- (IBAction)addStudentButton:(UIButton *)sender
{
    [[viewLogic sharedInstance] presentNewStudentModalViewController];
}

- (void)studentsChanged:(NSNotification *)notification
{
    [self reloadData];
}

@end
