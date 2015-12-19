//
//  UISettingsViewController.m
//  base
//
//  Created by rebecca biaz on 11/4/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UISettingsViewController.h"
#import "SettingsManager.h"

@interface UISettingsViewController ()

@end

@implementation UISettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"UISettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"UISettingTableViewCell"];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self reloadData];
    [self layoutData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(directionChanged) name:SETTINGS_DIRECTION_CHANGE object:nil];
}

- (void)reloadData
{
    _settings = [NSMutableArray array];
    
    SettingsInfo *directionSettingInfo = [[SettingsInfo alloc] init];
    
    directionSettingInfo.title = [SettingsManager directionTypeString:[SettingsManager sharedInstance].directionReadType];
    directionSettingInfo.settingsType = directionSettingsType;
    
    [_settings addObject:directionSettingInfo];
    
    SettingsInfo *studentLogoutSettingInfo = [[SettingsInfo alloc] init];
    
    studentLogoutSettingInfo.title = [NSString stringWithFormat:NLS(@"Logout student - %@"),     [[UserManager sharedInstance] currentStudent].name];
    studentLogoutSettingInfo.settingsType = studentLogoutSettingsType;
    
    [_settings addObject:studentLogoutSettingInfo];
    
    SettingsInfo *teacherLogoutSettingInfo = [[SettingsInfo alloc] init];
    
    teacherLogoutSettingInfo.title = [NSString stringWithFormat:NLS(@"Logout teacher - %@"),     [[UserManager sharedInstance] currentTeacher].name];
    teacherLogoutSettingInfo.settingsType = teacherLogoutSettingsType;
    
    [_settings addObject:teacherLogoutSettingInfo];
    
    SettingsInfo *presentTutorialSettingInfo = [[SettingsInfo alloc] init];
    
    presentTutorialSettingInfo.title = [NSString stringWithFormat:NLS(@"Present Tutorial")];
    presentTutorialSettingInfo.settingsType = presentTutorialSettingsType;
    
    [_settings addObject:presentTutorialSettingInfo];
}

- (void)layoutData
{
    [_tableView reloadData];
}

- (void)directionChanged
{
    [self reloadData];
    [self layoutData];
}

/* UITableView Delegates */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UISettingTableViewCell *settingCell = [tableView dequeueReusableCellWithIdentifier:@"UISettingTableViewCell"];
    
    SettingsInfo *settingInfo = [_settings objectAtIndex:indexPath.row];
    settingCell.settingInfo = settingInfo;
    
    return settingCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_settings count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UISettingTableViewCell *settingsCell = (UISettingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    switch (settingsCell.settingInfo.settingsType)
    {
        case directionSettingsType:
            [SettingsManager sharedInstance].directionReadType ++;
            break;
        case studentLogoutSettingsType:
            [[UserManager sharedInstance] logoutStudent];
            break;
        case teacherLogoutSettingsType:
            [[UserManager sharedInstance] logoutTeacher];
            break;
        case presentTutorialSettingsType:
        {
            [[viewLogic sharedInstance] presentTutorialView];
            [self dismissViewControllerAnimated:NO completion:nil ];
            break;
        }
            
        default:
            break;
    }
}

/* End UITableView Delegates */

@end
