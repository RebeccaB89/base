//
//  ColorInfo.h
//  base
//
//  Created by rebecca biaz on 7/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeatureInfo.h"

typedef enum : NSUInteger
{
    colorFeatureTypeStart,
    colorFeatureTypeRed = colorFeatureTypeStart,
    colorFeatureTypeGreen,
    colorFeatureTypeBlue,
    colorFeatureTypeOrange,
    colorFeatureTypeYellow,
    colorFeatureTypePurple,
    colorFeatureTypePink,
    colorFeatureTypeLightGreen,
    colorFeatureTypeStop
} ColorFeatureType;

@interface ColorInfo : FeatureInfo

+ (ColorInfo *)colorInfoWithColorFeatureType:(ColorFeatureType)colorFeatureType;
+ (ColorInfo *)colorInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath;
+ (NSString *)titleForColorFeatureType:(ColorFeatureType)colorFeatureType;
+ (NSString *)imagePathForColorFeatureType:(ColorFeatureType)colorFeatureType;

@end
