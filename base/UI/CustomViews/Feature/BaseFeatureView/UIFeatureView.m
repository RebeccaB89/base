//
//  UIColorView.m
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIFeatureView.h"

@interface UIFeatureView()

@end

@implementation UIFeatureView

+ (CGSize)sizeForNib
{
    return CGSizeMake(95, 95);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _nameLabel.text = NLS(@"Description");
}

-(void)setFeatureInfo:(FeatureInfo *)featureInfo
{
    _featureInfo = featureInfo;
    [self layoutData];
}

- (void)layoutData
{
    if (_featureInfo)
    {
        _nameLabel.text = _featureInfo.title;
        _imageView.image = IMAGE(_featureInfo.imagePath);
    }
    else
    {
        _nameLabel.text = nil;
        _imageView.image = nil;
    }
}

@end
