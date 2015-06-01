//
//  UIFeatureTableViewCell.m
//  base
//
//  Created by Rebecca Biaz on 5/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIFeatureTableViewCell.h"

@implementation UIFeatureTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected)
    {
        _arrowImageView.image = IMAGE(@"arrow-up-icon");
    }
    else
    {
        _arrowImageView.image = IMAGE(@"arrow-down-icon");
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.featureInfo = nil;
}

- (void)setFeatureInfo:(FeatureInfo *)featureInfo
{
    _featureInfo = featureInfo;
    
    [self layoutData];
}

- (void)layoutData
{
    if (_featureInfo)
    {
        _titleLabel.text = _featureInfo.title;
        _image.image = IMAGE(_featureInfo.imagePath);
    }
    else
    {
        _titleLabel.text = nil;
        _image.image = nil;
    }
}

@end
