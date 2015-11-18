//
//  SettingsManager.m
//  base
//
//  Created by rebecca biaz on 10/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "SettingsManager.h"

@implementation SettingsManager

static SettingsManager *sharedInstance = nil;

+ (SettingsManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            if (sharedInstance == nil)
            {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}

+ (NSString *)directionTypeString:(DirectionReadType)directionViewType
{
    switch (directionViewType)
    {
        case noDirectionViewType:
            return @"No Direction";
            break;
            
        case rightDirectionViewType:
            return @"Right direction";
            
        case leftDirectionViewType:
            return @"Left direction";
        case noFrame:
            return @"Without frame";
            
        default:
            return @"No Direction";
            break;
    }
}

- (void)setDirectionReadType:(DirectionReadType)directionReadType
{
    _directionReadType = (directionReadType % 4);
    [self notifyDirectionViewTypeChanged];
}

- (void)notifyDirectionViewTypeChanged
{
    [Shared postNotification:SETTINGS_DIRECTION_CHANGE];
}

@end
