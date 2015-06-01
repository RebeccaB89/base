//
//  UIFeatureTableViewCell.h
//  base
//
//  Created by Rebecca Biaz on 5/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureInfo.h"

@interface UIFeatureTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UIImageView *_image;
    
    __weak IBOutlet UIImageView *_arrowImageView;
}

@property (nonatomic, strong) FeatureInfo *featureInfo;

@end
