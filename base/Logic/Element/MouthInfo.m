//
//  MouthInfo.m
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "MouthInfo.h"

@implementation MouthInfo

+ (MouthInfo *)mouthInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    MouthInfo *featureInfo = [[MouthInfo alloc] init];
    featureInfo.title = title;
    featureInfo.imagePath = imagePath;
    
    return featureInfo;
}

@end
