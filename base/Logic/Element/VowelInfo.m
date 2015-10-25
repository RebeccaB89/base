//
//  VowelInfo.m
//  base
//
//  Created by rebecca biaz on 9/8/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "VowelInfo.h"

@implementation VowelInfo

+ (VowelInfo *)vowelInfoWithVowelFeatureType:(VowelFeatureType)vowelFeatureType
{
    VowelInfo *info = [VowelInfo vowelInfoTitle:[VowelInfo titleForVowelFeatureType:vowelFeatureType] andImagePath:[VowelInfo imagePathForVowelFeatureType:vowelFeatureType]];

    info.featureInfoType = vowelFeatureType;
    return info;
}

+ (VowelInfo *)vowelInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    VowelInfo *vowelInfo = [[VowelInfo alloc] init];
    vowelInfo.title = title;
    vowelInfo.imagePath = imagePath;
    vowelInfo.factorRegex = 3;

    return vowelInfo;
}

+ (NSString *)titleForVowelFeatureType:(VowelFeatureType)vowelFeatureType
{
    switch (vowelFeatureType)
    {
        case vowelFeatureTypeVA:
            return NLS(@"VA");
            
        case vowelFeatureTypeVE:
            return NLS(@"VE");
            
        case vowelFeatureTypeVI:
            return NLS(@"VI");
            
        case vowelFeatureTypeVO:
            return NLS(@"VO");
            
        case vowelFeatureTypeVOU:
            return NLS(@"VOU");
            
        default:
            return NLS(@"");
    }
}

+ (NSString *)imagePathForVowelFeatureType:(VowelFeatureType)vowelFeatureType
{
    switch (vowelFeatureType)
    {
        case vowelFeatureTypeVA:
            return @"Shapes-01";
            
        case vowelFeatureTypeVE:
            return @"Shapes-06";
            
        case vowelFeatureTypeVI:
            return @"Shapes-04";
            
        case vowelFeatureTypeVO:
            return @"Shapes-03";
            
        case vowelFeatureTypeVOU:
            return @"Shapes-02";
            
        default:
            return @"";
    }
}

- (NSString *)regex
{
    return @"Vowel";
}

- (NSInteger)factorOrderView
{
    return 3;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
}


@end
