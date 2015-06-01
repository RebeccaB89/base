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
    
}

- (void)loadFeatures
{
    _features = [NSMutableArray arrayWithObjects:[FeatureInfo featureWithTitle:NLS(@"Features") andImagePath:@"Colors-01"], [FeatureInfo featureWithTitle:NLS(@"Colors") andImagePath:@"Colors-02"], [FeatureInfo featureWithTitle:NLS(@"Mouth") andImagePath:@"Colors-03"], [FeatureInfo featureWithTitle:NLS(@"Vawel") andImagePath:@"Colors-04"], nil];
}

- (NSArray *)features
{
    return _features;
}

- (void)loadMouths
{
    _mouths = [NSMutableArray arrayWithObjects:[MouthInfo mouthInfoTitle:NLS(@"Sagour") andImagePath:@"Colors-01"], [MouthInfo mouthInfoTitle:NLS(@"Patouah") andImagePath:@"Colors-02"], [MouthInfo mouthInfoTitle:NLS(@"Lachon") andImagePath:@"Colors-03"], [MouthInfo mouthInfoTitle:NLS(@"PPP") andImagePath:@"Colors-04"], [MouthInfo mouthInfoTitle:NLS(@"MMM") andImagePath:@"Colors-04"], [MouthInfo mouthInfoTitle:NLS(@"OOO") andImagePath:@"Colors-04"], [MouthInfo mouthInfoTitle:NLS(@"III") andImagePath:@"Colors-04"], [MouthInfo mouthInfoTitle:NLS(@"VVV") andImagePath:@"Colors-04"], [MouthInfo mouthInfoTitle:NLS(@"KKK") andImagePath:@"Colors-04"], nil];
}

- (NSArray *)mouths
{
    return _mouths;
}

@end
