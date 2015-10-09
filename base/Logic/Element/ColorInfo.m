//
//  ColorInfo.m
//  base
//
//  Created by rebecca biaz on 7/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ColorInfo.h"

@implementation ColorInfo

+ (ColorInfo *)colorInfoWithColorFeatureType:(ColorFeatureType)colorFeatureType
{
    return [ColorInfo colorInfoTitle:[ColorInfo titleForColorFeatureType:colorFeatureType] andImagePath:[ColorInfo imagePathForColorFeatureType:colorFeatureType]];
}

+ (ColorInfo *)colorInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    ColorInfo *colorInfo = [[ColorInfo alloc] init];
    colorInfo.title = title;
    colorInfo.imagePath = imagePath;
    colorInfo.factorRegex = 2;

    return colorInfo;
}

+ (NSString *)titleForColorFeatureType:(ColorFeatureType)colorFeatureType
{
    switch (colorFeatureType)
    {
        case colorFeatureTypeBlue:
            return NLS(@"Blue");
            
        case colorFeatureTypeGreen:
            return NLS(@"Green");
            
        case colorFeatureTypeLightGreen:
            return NLS(@"Light Green");
            
        case colorFeatureTypeOrange:
            return NLS(@"Orange");
            
        case colorFeatureTypePink:
            return NLS(@"Pink");
            
        case colorFeatureTypePurple:
            return NLS(@"Purple");
            
        case colorFeatureTypeRed:
            return NLS(@"Red");
            
        case colorFeatureTypeYellow:
            return NLS(@"Yellow");
            
        default:
            return NLS(@"");
    }
}

+ (NSString *)imagePathForColorFeatureType:(ColorFeatureType)colorFeatureType
{
    switch (colorFeatureType)
    {
        case colorFeatureTypeBlue:
            return NLS(@"Colors-03");
            
        case colorFeatureTypeGreen:
            return NLS(@"Colors-02");
            
        case colorFeatureTypeLightGreen:
            return NLS(@"Colors-06");
            
        case colorFeatureTypeOrange:
            return NLS(@"Colors-04");
            
        case colorFeatureTypePink:
            return NLS(@"Colors-05");
            
        case colorFeatureTypePurple:
            return NLS(@"Colors-08");
            
        case colorFeatureTypeRed:
            return NLS(@"Colors-01");
            
        case colorFeatureTypeYellow:
            return NLS(@"Colors-07");
            
        default:
            return NLS(@"");
    }
}

- (NSString *)regex
{
    return @"Color";
}

@end