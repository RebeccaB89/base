//
//  FeatureInfo.m
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeatureInfo.h"

@implementation FeatureInfo

+ (FeatureInfo *)featureWithTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    FeatureInfo *featureInfo = [[FeatureInfo alloc] init];
    featureInfo.title = title;
    featureInfo.imagePath = imagePath;
    featureInfo.factorRegex = 0;

    return featureInfo;
}

+ (NSString *)regex
{
    return [[[[self class] alloc] init] regex];
}

- (NSString *)regex
{
    return @"";
}

@end
