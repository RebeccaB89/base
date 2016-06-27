//
//  GrammarLogic.m
//  base
//
//  Created by rebecca biaz on 9/8/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "GrammarLogic.h"
#import "MouthInfo.h"
#import "ColorInfo.h"
#import "VowelInfo.h"
#import "SyllableTimeInfo.h"
#import "ThroatInfo.h"

@implementation GrammarLogic

static GrammarLogic *sharedInstance = nil;

+ (GrammarLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (NSArray *)regexPermissions
{
    NSMutableArray *regexPermissions = [NSMutableArray array];
    
    MouthInfo *mouthRegex = [MouthInfo mouthInfoWithMouthFeatureType:mouthFeatureTypeMB];
    ColorInfo *colorRegex = [ColorInfo colorInfoWithColorFeatureType:colorFeatureTypeBlue];
    VowelInfo *vowelRegex = [VowelInfo vowelInfoWithVowelFeatureType:vowelFeatureTypeVOU];
    SyllableTimeInfo *syllableTimeRegex = [SyllableTimeInfo syllableTimeInfoWithSyllableFeatureType:syllableTimeFeatureTypeLong];
    ThroatInfo *throatRegex = [ThroatInfo throatInfoWithThroatFeatureType:throatFeatureTypeTrembling];
    
    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, mouthRegex] withOptionalFeatures:nil]];
    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, mouthRegex, syllableTimeRegex] withOptionalFeatures:@[syllableTimeRegex]]];
    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, mouthRegex, throatRegex] withOptionalFeatures:@[throatRegex]]];
    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, mouthRegex, vowelRegex] withOptionalFeatures:@[vowelRegex]]];
    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, mouthRegex, throatRegex,vowelRegex] withOptionalFeatures:@[throatRegex]]];
    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, mouthRegex, throatRegex,vowelRegex,syllableTimeRegex ] withOptionalFeatures:@[throatRegex]]];
    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, mouthRegex, throatRegex,syllableTimeRegex ] withOptionalFeatures:@[throatRegex]]];

    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, mouthRegex, vowelRegex,syllableTimeRegex ] withOptionalFeatures:nil]];

    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, vowelRegex,syllableTimeRegex ] withOptionalFeatures:nil]];

    [regexPermissions addObject:[self regexForFeatureInfos:@[colorRegex, vowelRegex,syllableTimeRegex, throatRegex ] withOptionalFeatures:@[throatRegex]]];

    NSString *syllableRegex = [regexPermissions firstObject];
    NSString *wordRegex = [NSString stringWithFormat:@"[%@]*", syllableRegex];
    
    return regexPermissions;
}

- (NSString *)regexForFeatureInfos:(NSArray *)featureInfos withOptionalFeatures:(NSArray *)optionalFeatures
{
        NSArray *featuresSorted = [featureInfos sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"factorRegex" ascending:YES]]];
    NSMutableString *regex = [NSMutableString string];
    for (FeatureInfo *featureInfo in featuresSorted)
    {
        if ([optionalFeatures containsObject:featureInfo])
        {
            [regex appendString:[NSString stringWithFormat:@"%@?", [featureInfo regex]]];
        }
        else
            [regex appendString:[featureInfo regex]];
    }
    
    return regex;
}

- (NSString *)regexAllPermission
{
    NSArray *regexPermissions = [self regexPermissions];
    NSString *regexAllPermission = [[regexPermissions valueForKey:@"description"] componentsJoinedByString:@"|"];
    return regexAllPermission;
}

- (NSString *)regexForFeatureInfos:(NSArray *)featureInfos
{
    NSArray *featuresSorted = [featureInfos sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"factorRegex" ascending:YES]]];
    
    NSMutableString *regex = [NSMutableString string];
    
    for (FeatureInfo *featureInfo in featuresSorted)
    {
        if (![featureInfo isKindOfClass:[FeatureInfo class]])
        {
            continue;
        }
        [regex appendString:[featureInfo regex]];
    }
    
    return regex;
}

- (BOOL)wordHavePermission:(NSString *)word
{
    NSString *stringRegExp = [self regexAllPermission];
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegExp];

    if ([myTest evaluateWithObject:word])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
