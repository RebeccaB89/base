//
//  ThroatInfo.h
//  base
//
//  Created by rebecca biaz on 9/8/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FeatureInfo.h"

typedef enum : NSUInteger
{
    throatFeatureTypeStart,
    throatFeatureTypeTrembling = throatFeatureTypeStart,
    throatFeatureTypeStop
} ThroatFeatureType;

@interface ThroatInfo : FeatureInfo

+ (ThroatInfo *)throatInfoWithThroatFeatureType:(ThroatFeatureType)throatFeatureType;


@end
