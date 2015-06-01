//
//  FeatureInfo.h
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Element.h"

@interface FeatureInfo : Element

+ (FeatureInfo *)featureWithTitle:(NSString *)title andImagePath:(NSString *)imagePath;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;

@end
