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

@interface FeaturesManager : NSObject
{
    NSMutableArray *_features;
    NSMutableArray *_mouths;
}

+ (FeaturesManager *)sharedInstance;

- (void)applicationLaunched;

- (NSArray *)features;
- (NSArray *)mouths;

@end
