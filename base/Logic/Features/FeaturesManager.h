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

@interface FeaturesManager : NSObject
{
    NSMutableArray *_features;
    NSMutableArray *_mouths;
    NSMutableArray *_colors;
}

+ (FeaturesManager *)sharedInstance;

- (void)applicationLaunched;

- (NSArray *)features;
- (NSArray *)mouths;
- (NSArray *)colors;

@end
