//
//  UIMouthView.m
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIMouthView.h"

@implementation UIMouthView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _nameLabel.text = NLS(@"Description");
}

- (void)setMouthInfo:(MouthInfo *)mouthInfo
{
    _mouthInfo = mouthInfo;
    [self layoutData];
}

- (void)layoutData
{
    if (_mouthInfo)
    {
        _nameLabel.text = _mouthInfo.title;
        _imageView.image = IMAGE(_mouthInfo.imagePath);
    }
    else
    {
        _nameLabel.text = nil;
        _imageView.image = nil;
    }
}

@end
