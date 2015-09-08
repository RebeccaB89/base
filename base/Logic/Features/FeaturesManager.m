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
}

- (void)loadFeatures
{
    _features = [NSMutableArray arrayWithObjects:[FeatureInfo featureWithTitle:NLS(@"Mouths") andImagePath:@"Colors-01"], [FeatureInfo featureWithTitle:NLS(@"Colors") andImagePath:@"Colors-02"], [FeatureInfo featureWithTitle:NLS(@"Feature") andImagePath:@"Colors-03"], [FeatureInfo featureWithTitle:NLS(@"Vawel") andImagePath:@"Colors-04"], nil];
}

- (NSArray *)features
{
    return _features;
}

- (void)loadMouths
{
    _mouths = [NSMutableArray arrayWithObjects:[MouthInfo mouthInfoTitle:NLS(@"Open") andImagePath:@"Mouth-01"], [MouthInfo mouthInfoTitle:NLS(@"Nose") andImagePath:@"Mouth-02"], [MouthInfo mouthInfoTitle:NLS(@"First-Tee") andImagePath:@"Mouth-03"], [MouthInfo mouthInfoTitle:NLS(@"zz") andImagePath:@"Mouth-04"], [MouthInfo mouthInfoTitle:NLS(@"MMM") andImagePath:@"Mouth-06"], [MouthInfo mouthInfoTitle:NLS(@"OOO") andImagePath:@"Mouth-07"], [MouthInfo mouthInfoTitle:NLS(@"III") andImagePath:@"Mouth-08"], [MouthInfo mouthInfoTitle:NLS(@"VVV") andImagePath:@"Mouth-16"], [MouthInfo mouthInfoTitle:NLS(@"KKK") andImagePath:@"Mouth-17"], [MouthInfo mouthInfoTitle:NLS(@"KKK") andImagePath:@"Mouth-18"], [MouthInfo mouthInfoTitle:NLS(@"KKK") andImagePath:@"Mouth-19"], [MouthInfo mouthInfoTitle:NLS(@"KKK") andImagePath:@"Mouth-20"], nil];
}

- (void)loadColors
{
    _colors = [NSMutableArray arrayWithObjects:[ColorInfo colorInfoTitle:NLS(@"Sagour") andImagePath:@"Colors-01"], [ColorInfo colorInfoTitle:NLS(@"Patouah") andImagePath:@"Colors-02"], [ColorInfo colorInfoTitle:NLS(@"Lachon") andImagePath:@"Colors-03"], [ColorInfo colorInfoTitle:NLS(@"PPP") andImagePath:@"Colors-04"], [ColorInfo colorInfoTitle:NLS(@"MMM") andImagePath:@"Colors-04"], [ColorInfo colorInfoTitle:NLS(@"OOO") andImagePath:@"Colors-04"], [ColorInfo colorInfoTitle:NLS(@"III") andImagePath:@"Colors-04"], [ColorInfo colorInfoTitle:NLS(@"VVV") andImagePath:@"Colors-04"], [ColorInfo colorInfoTitle:NLS(@"KKK") andImagePath:@"Colors-04"], nil];
}

- (NSArray *)mouths
{
    return _mouths;
}

- (NSArray *)colors
{
    return _colors;
}

@end
