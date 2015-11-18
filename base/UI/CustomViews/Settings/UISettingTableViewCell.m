//
//  UISettingTableViewCell.m
//  base
//
//  Created by rebecca biaz on 11/9/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UISettingTableViewCell.h"

@implementation UISettingTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSettingInfo:(SettingsInfo *)settingInfo
{
    _settingInfo = settingInfo;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _title.text = _settingInfo.title;
}

@end
