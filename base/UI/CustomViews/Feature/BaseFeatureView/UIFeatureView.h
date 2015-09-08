//
//  UIColorView.h
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureInfo.h"

@class UIFeatureView;

@interface UIFeatureView : UIView
{
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UIImageView *_imageView;
}

+ (CGSize)sizeForNib;

@property (nonatomic, strong) FeatureInfo *featureInfo;

@end
