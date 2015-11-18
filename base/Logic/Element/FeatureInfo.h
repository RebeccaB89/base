//
//  FeatureInfo.h
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Element.h"
#define numOFFeatureInfo 5          //update the num of feature 
@interface FeatureInfo : Element

+ (FeatureInfo *)featureWithTitle:(NSString *)title andImagePath:(NSString *)imagePath;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, unsafe_unretained) NSInteger factorRegex;
@property (nonatomic, unsafe_unretained) NSInteger featureInfoType;

+ (NSString *)regex;
- (NSString *)regex;
- (NSInteger)factorOrderView;

@end
