//
//  UITemplateView.m
//  base
//
//  Created by Rebecca Biaz on 6/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UITemplateView.h"

@implementation UITemplateView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 2.0f;
}

- (void)setFeatureInfo:(FeatureInfo *)featureInfo
{
    _featureInfo = featureInfo;
    [self layoutData];
}

- (void)layoutData
{
    if (self.featureInfo)
    {
        _imageView.image = IMAGE(_featureInfo.imagePath);
    }
    else
    {
        _imageView.image = nil;
    }
}

@end
