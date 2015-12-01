//
//  FeaturesManager.m
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeaturesManager.h"

@implementation FeaturesManager

static FeaturesManager *sharedInstance = nil;

+ (FeaturesManager *)sharedInstance
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

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationLaunched
{
    [self loadFeatures];
    [self loadMouths];
    [self loadColors];
    [self loadSyllables];
    [self loadVowels];
    [self loadThroat];
}

- (void)loadFeatures
{
    _features = [NSMutableArray arrayWithObjects:[FeatureInfo featureWithTitle:NLS(@"Mouths") andImagePath:@"Mouth-01"], [FeatureInfo featureWithTitle:NLS(@"Colors") andImagePath:@"Colors-01"], [FeatureInfo featureWithTitle:NLS(@"Continuation") andImagePath:@"Snake"], [FeatureInfo featureWithTitle:NLS(@"Vawel") andImagePath:@"Shapes-02"], [FeatureInfo featureWithTitle:NLS(@"Voice") andImagePath:@"Throat"], nil];
}

- (NSArray *)features
{
    return _features;
}

- (void)loadMouths
{
    NSMutableArray *mouths = [NSMutableArray array];
    for (MouthFeatureType i = mouthFeatureTypeStart; i < mouthFeatureTypeStop; i++)
    {
        [mouths addObject:[MouthInfo mouthInfoWithMouthFeatureType:i]];
    }

    _mouths = mouths;
}

- (void)loadColors
{
    NSMutableArray *colors = [NSMutableArray array];
    for (ColorFeatureType i = colorFeatureTypeStart; i < colorFeatureTypeStop; i++)
    {
        [colors addObject:[ColorInfo colorInfoWithColorFeatureType:i]];
    }
    
    _colors = colors;
}

- (void)loadVowels
{
    NSMutableArray *vowels = [NSMutableArray array];
    for (VowelFeatureType i = vowelFeatureTypeStart; i < vowelFeatureTypeStop; i++)
    {
        [vowels addObject:[VowelInfo vowelInfoWithVowelFeatureType:i]];
    }
    
    _vowels = vowels;
}

- (void)loadSyllables
{
    NSMutableArray *syllables = [NSMutableArray array];
    for (SyllableTimeFeatureType i = syllableTimeFeatureTypeStart; i < syllableTimeFeatureTypeStop; i++)
    {
        [syllables addObject:[SyllableTimeInfo syllableTimeInfoWithSyllableFeatureType:i]];
    }
    
    _syllables = syllables;
}

- (void)loadThroat
{
    NSMutableArray *throat = [NSMutableArray array];
    for (ThroatFeatureType i = throatFeatureTypeStart; i < throatFeatureTypeStop; i++)
    {
        [throat addObject:[ThroatInfo throatInfoWithThroatFeatureType:i]];
    }
    
    _throat = throat;
}

- (NSArray *)mouths
{
    return _mouths;
}

- (NSArray *)colors
{
    return _colors;
}

- (NSArray *)vowels
{
    return _vowels;
}

- (NSArray *)syllables
{
    return _syllables;
}

- (NSArray *)throat
{
    return _throat;
}

@end
