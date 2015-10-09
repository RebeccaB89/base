//
//  MouthInfo.h
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeatureInfo.h"

typedef enum : NSUInteger
{
    mouthFeatureTypeStart,
    mouthFeatureTypeMB = mouthFeatureTypeStart,
    mouthFeatureTypeMN,
    mouthFeatureTypeML,
    mouthFeatureTypeMNS,
    mouthFeatureTypeMCH,
    mouthFeatureTypeMTH,
    mouthFeatureTypeMV,
    mouthFeatureTypeMS,
    mouthFeatureTypeMK,
    mouthFeatureTypeMT,
    mouthFeatureTypeMTN,
    mouthFeatureTypeMY,
    mouthFeatureTypeStop
} MouthFeatureType;

@interface MouthInfo : FeatureInfo

+ (MouthInfo *)mouthInfoWithMouthFeatureType:(MouthFeatureType)mouthFeatureType;
+ (MouthInfo *)mouthInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath;
+ (NSString *)titleForMouthFeatureType:(MouthFeatureType)mouthFeatureType;
+ (NSString *)imagePathForMouthFeatureType:(MouthFeatureType)mouthFeatureType;

@end
