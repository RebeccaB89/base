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
    ColorInfo *info = [ColorInfo colorInfoTitle:[ColorInfo titleForColorFeatureType:colorFeatureType] andImagePath:[ColorInfo imagePathForColorFeatureType:colorFeatureType]];
    info.featureInfoType = colorFeatureType;
    return info;
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

- (NSInteger)factorOrderView
{
    return 5;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
}


@end