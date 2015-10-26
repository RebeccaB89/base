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
    ThroatInfo *info = [ThroatInfo throatInfoTitle:[ThroatInfo titleForThroatFeatureType:throatFeatureType] andImagePath:[ThroatInfo imagePathForThroatFeatureType:throatFeatureType]];

    info.featureInfoType = throatFeatureType;
    return info;
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


- (NSString *)regex
{
    return @"Throat";
}

- (NSInteger)factorOrderView
{
    return 4;
}

@end
