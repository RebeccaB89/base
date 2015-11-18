//
//  SettingsManager.h
//  base
//
//  Created by rebecca biaz on 10/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    noFrame,
    noDirectionViewType,
    leftDirectionViewType,
    rightDirectionViewType,
} DirectionReadType;

typedef enum : NSUInteger
{
    directionSettingsType,
} SettingsType;

#define SETTINGS_DIRECTION_CHANGE   @"SETTINGS_DIRECTION_CHANGE"

@interface SettingsManager : NSObject

+ (SettingsManager *)sharedInstance;

@property (nonatomic, unsafe_unretained) DirectionReadType directionReadType;

+ (NSString *)directionTypeString:(DirectionReadType)directionViewType;

@end
