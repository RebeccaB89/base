//
//  VowelInfo.h
//  base
//
//  Created by rebecca biaz on 9/8/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeatureInfo.h"

typedef enum : NSUInteger
{
    vowelFeatureTypeStart,
    vowelFeatureTypeVOU = vowelFeatureTypeStart,
    vowelFeatureTypeVA,
    vowelFeatureTypeVO,
    vowelFeatureTypeVI,
    vowelFeatureTypeVE,
    vowelFeatureTypeStop
} VowelFeatureType;

@interface VowelInfo : FeatureInfo

+ (VowelInfo *)vowelInfoWithVowelFeatureType:(VowelFeatureType)vowelFeatureType;
+ (VowelInfo *)vowelInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath;
+ (NSString *)titleForVowelFeatureType:(VowelFeatureType)vowelFeatureType;
+ (NSString *)imagePathForVowelFeatureType:(VowelFeatureType)vowelFeatureType;
@end
