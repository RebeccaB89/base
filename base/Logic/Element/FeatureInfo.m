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
    featureInfo.featureInfoType = 0;

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

- (NSInteger)factorOrderView
{
    return 0;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.imagePath = [aDecoder decodeObjectForKey:@"imagePath"];
        self.factorRegex = [aDecoder decodeIntForKey:@"factorRegex"];
        self.featureInfoType = [aDecoder decodeIntForKey:@"featureInfoType"];

    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_imagePath forKey:@"imagePath"];
    [aCoder encodeInt:(int)_factorRegex forKey:@"factorRegex"];
    [aCoder encodeInt:(int)_featureInfoType forKey:@"featureInfoType"];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeatureInfo *copy = [[[self class] allocWithZone:zone] init];

    copy.title = [self.title copyWithZone:zone];
    copy.imagePath = [self.imagePath copyWithZone:zone];
    copy.factorRegex = self.factorRegex;
    copy.featureInfoType = self.featureInfoType;

    return copy;
}

@end
