//
//  SyllableTimeInfo.m
//  base
//
//  Created by rebecca biaz on 9/8/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "SyllableTimeInfo.h"

@implementation SyllableTimeInfo

+ (SyllableTimeInfo *)syllableTimeInfoWithSyllableFeatureType:(SyllableTimeFeatureType)syllableTimeFeatureType
{
    return [SyllableTimeInfo syllableTimeInfoTitle:[SyllableTimeInfo titleForSyllableFeatureType:syllableTimeFeatureType] andImagePath:[SyllableTimeInfo imagePathForSyllableFeatureType:syllableTimeFeatureType]];
}

+ (SyllableTimeInfo *)syllableTimeInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    SyllableTimeInfo *syllableTimeInfo = [[SyllableTimeInfo alloc] init];
    syllableTimeInfo.title = title;
    syllableTimeInfo.imagePath = imagePath;
    syllableTimeInfo.factorRegex = 5;

    return syllableTimeInfo;
}

+ (NSString *)titleForSyllableFeatureType:(SyllableTimeFeatureType)syllableTimeFeatureType
{
    switch (syllableTimeFeatureType)
    {
        case syllableTimeFeatureTypeLong:
            return NLS(@"Long");
            
        case syllableTimeFeatureTypeShort:
            return NLS(@"Short");
            
        default:
            return NLS(@"");
    }
}

+ (NSString *)imagePathForSyllableFeatureType:(SyllableTimeFeatureType)syllableTimeFeatureType
{
    switch (syllableTimeFeatureType)
    {
        case syllableTimeFeatureTypeLong:
            return @"Sparkle";
            
        case syllableTimeFeatureTypeShort:
            return @"Snake";
            
        default:
            return @"";
    }
}

- (NSString *)regex
{
    return @"TimeSyllable";
}

@end
