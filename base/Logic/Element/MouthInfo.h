//
//  MouthInfo.h
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeatureInfo.h"

@interface MouthInfo : FeatureInfo

+ (MouthInfo *)mouthInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;

@end
