//
//  WordInfo.h
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Element.h"
#import "FeatureInfo.h"

@interface WordInfo : Element

+ (WordInfo *)wordWithTitle:(NSString *)title andImagePath:(NSString *)imagePath;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSArray *featureInfos;

@end
