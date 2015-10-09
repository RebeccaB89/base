//
//  ThroatInfo.m
//  base
//
//  Created by rebecca biaz on 9/8/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ThroatInfo.h"

@implementation ThroatInfo

+ (ThroatInfo *)throatInfoWithThroatFeatureType:(ThroatFeatureType)throatFeatureType
{
    return [ThroatInfo throatInfoTitle:[ThroatInfo titleForThroatFeatureType:throatFeatureType] andImagePath:[ThroatInfo imagePathForThroatFeatureType:throatFeatureType]];
}

+ (ThroatInfo *)throatInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    ThroatInfo *throatInfo = [[ThroatInfo alloc] init];
    throatInfo.title = title;
    throatInfo.imagePath = imagePath;
    throatInfo.factorRegex = 4;

    return throatInfo;
}

+ (NSString *)titleForThroatFeatureType:(ThroatFeatureType)throatFeatureType
{
    switch (throatFeatureType)
    {
        case throatFeatureTypeTrembling:
            return NLS(@"Trembling");
            
        default:
            return NLS(@"");
    }
}

+ (NSString *)imagePathForThroatFeatureType:(ThroatFeatureType)throatFeatureType
{
    switch (throatFeatureType)
    {
        case throatFeatureTypeTrembling:
            return @"Throat";
            
        default:
            return @"";
    }
}

- (NSString *)regex
{
    return @"Throat";
}

@end
