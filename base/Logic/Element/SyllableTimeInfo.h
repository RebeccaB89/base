//
//  SyllableTimeInfo.h
//  base
//
//  Created by rebecca biaz on 9/8/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeatureInfo.h"

typedef enum : NSUInteger
{
    syllableTimeFeatureTypeStart,
    syllableTimeFeatureTypeShort = syllableTimeFeatureTypeStart,
    syllableTimeFeatureTypeLong,
    syllableTimeFeatureTypeStop
} SyllableTimeFeatureType;

@interface SyllableTimeInfo : FeatureInfo

+ (SyllableTimeInfo *)syllableTimeInfoWithSyllableFeatureType:(SyllableTimeFeatureType)syllableTimeFeatureType;
+ (SyllableTimeInfo *)syllableTimeInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath;
+ (NSString *)titleForSyllableFeatureType:(SyllableTimeFeatureType)syllableTimeFeatureType;
+ (NSString *)imagePathForSyllableFeatureType:(SyllableTimeFeatureType)syllableTimeFeatureType;
@end
