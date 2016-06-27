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
    SyllableTimeInfo *info = [SyllableTimeInfo syllableTimeInfoTitle:[SyllableTimeInfo titleForSyllableFeatureType:syllableTimeFeatureType] andImagePath:[SyllableTimeInfo imagePathForSyllableFeatureType:syllableTimeFeatureType]];
    
    info.featureInfoType = syllableTimeFeatureType;
    return info;
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
            return @"Snake";
            
        case syllableTimeFeatureTypeShort:
            return @"Sparkle";
            
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
    return @"TimeSyllable";
}

- (NSInteger)factorOrderView
{
    return 1;
}

@end
