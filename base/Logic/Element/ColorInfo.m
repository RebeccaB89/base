//
//  ColorInfo.m
//  base
//
//  Created by rebecca biaz on 7/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ColorInfo.h"

@implementation ColorInfo

+ (ColorInfo *)colorInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    ColorInfo *colorInfo = [[ColorInfo alloc] init];
    colorInfo.title = title;
    colorInfo.imagePath = imagePath;
    
    return colorInfo;
}

@end
