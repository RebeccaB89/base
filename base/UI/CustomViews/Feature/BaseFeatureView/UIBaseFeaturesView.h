//
//  UIColorFeatureView.h
//  base
//
//  Created by Rebecca Biaz on 5/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFeatureView.h"

@class UIBaseFeaturesView;

@protocol UIBaseFeaturesViewDelegate <NSObject>

- (void)baseFeaturesView:(UIBaseFeaturesView *)baseFeaturesView didSelectFeatureInfo:(FeatureInfo *)featureInfo;

@end


@interface UIBaseFeaturesView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *_colorsCollectionView;    
}

+ (CGSize)sizeForNumOfItems:(int)items withWidth:(CGFloat)widths;

@property (nonatomic, strong) NSArray *featureInfos;
@property (nonatomic, weak) id<UIBaseFeaturesViewDelegate> delegate;

@end
