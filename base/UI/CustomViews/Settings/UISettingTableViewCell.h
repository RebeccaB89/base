//
//  UISettingTableViewCell.h
//  base
//
//  Created by rebecca biaz on 11/9/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsInfo.h"

@interface UISettingTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel *_title;
}

@property (nonatomic, strong) SettingsInfo *settingInfo;

@end
