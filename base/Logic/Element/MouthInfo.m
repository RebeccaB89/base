//
//  MouthInfo.m
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "MouthInfo.h"

@implementation MouthInfo

+ (MouthInfo *)mouthInfoWithMouthFeatureType:(MouthFeatureType)mouthFeatureType
{
    MouthInfo *info = [MouthInfo mouthInfoTitle:[MouthInfo titleForMouthFeatureType:mouthFeatureType] andImagePath:[MouthInfo imagePathForMouthFeatureType:mouthFeatureType]];
    info.featureInfoType = mouthFeatureType;
    
    return info;
}

+ (MouthInfo *)mouthInfoTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    MouthInfo *featureInfo = [[MouthInfo alloc] init];
    featureInfo.title = title;
    featureInfo.imagePath = imagePath;
    featureInfo.factorRegex = 1;
    
    return featureInfo;
}

+ (NSString *)titleForMouthFeatureType:(MouthFeatureType)mouthFeatureType
{
    switch (mouthFeatureType)
    {
        case mouthFeatureTypeMB:
            return NLS(@"MB");
            
        case mouthFeatureTypeMCH:
            return NLS(@"MCH");
            
        case mouthFeatureTypeMK:
            return NLS(@"MK");
            
        case mouthFeatureTypeML:
            return NLS(@"ML");
            
        case mouthFeatureTypeMN:
            return NLS(@"MN");
            
        case mouthFeatureTypeMNS:
            return NLS(@"MNS");
            
        case mouthFeatureTypeMS:
            return NLS(@"MS");
            
        case mouthFeatureTypeMT:
            return NLS(@"MT");
            
        case mouthFeatureTypeMTH:
            return NLS(@"MTH");
            
        case mouthFeatureTypeMTN:
            return NLS(@"MTN");
            
        case mouthFeatureTypeMV:
            return NLS(@"MV");
            
        case mouthFeatureTypeMY:
            return NLS(@"MY");
            
        default:
            return NLS(@"");
    }
}

+ (NSString *)imagePathForMouthFeatureType:(MouthFeatureType)mouthFeatureType
{
    switch (mouthFeatureType)
    {
        case mouthFeatureTypeMB:
            return @"Mouth-19";
            
        case mouthFeatureTypeMCH:
            return @"Mouth-20";
            
        case mouthFeatureTypeMK:
            return @"Mouth-01";
            
        case mouthFeatureTypeML:
            return @"Mouth-03";
            
        case mouthFeatureTypeMN:
            return @"Mouth-18";
            
        case mouthFeatureTypeMNS:
            return @"Mouth-02";
            
        case mouthFeatureTypeMS:
            return @"Mouth-06";
            
        case mouthFeatureTypeMT:
            return @"Mouth-04";
            
        case mouthFeatureTypeMTH:
            return @"Mouth-17";
            
        case mouthFeatureTypeMTN:
            return @"Mouth-07";
            
        case mouthFeatureTypeMV:
            return @"Mouth-08";
            
        case mouthFeatureTypeMY:
            return @"Mouth-16";
            
        default:
            return @"";
    }
}

- (NSString *)regex
{
    return @"Mouth";
}

- (NSInteger)factorOrderView
{
    return 2;
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

- (id)copyWithZone:(NSZone *)zone
{
    MouthInfo *copy = (MouthInfo *)[super copyWithZone:zone];
    
    return copy;
}

@end
