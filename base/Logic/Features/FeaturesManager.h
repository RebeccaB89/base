//
//  FeaturesManager.h
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeatureInfo.h"
#import "MouthInfo.h"
#import "ColorInfo.h"
#import "VowelInfo.h"
#import "SyllableTimeInfo.h"
#import "ThroatInfo.h"

@interface FeaturesManager : NSObject
{
    NSMutableArray *_features;
    NSMutableArray *_mouths;
    NSMutableArray *_colors;
    NSMutableArray *_vowels;
    NSMutableArray *_syllables;
    NSMutableArray *_throat;
}

+ (FeaturesManager *)sharedInstance;

- (void)applicationLaunched;

- (NSArray *)features;
- (NSArray *)mouths;
- (NSArray *)colors;
- (NSArray *)vowels;
- (NSArray *)syllables;
- (NSArray *)throat;

@end
