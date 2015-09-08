//
//  ColorInfo.h
//  base
//
//  Created by rebecca biaz on 7/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeatureInfo.h"

@interface ColorInfo : FeatureInfo

+ (ColorInfo *)colorInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;

@end
