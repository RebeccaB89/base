//
//  UITemplateView.h
//  base
//
//  Created by Rebecca Biaz on 6/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIZoomableDraggableView.h"
#import "FeatureInfo.h"

@interface UITemplateView : UIZoomableDraggableView
{
    __weak IBOutlet UIImageView *_imageView;
}

@property (nonatomic, strong) FeatureInfo *featureInfo;

@end
