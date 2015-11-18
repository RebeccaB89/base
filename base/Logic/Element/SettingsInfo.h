//
//  SettingsInfoe.h
//  base
//
//  Created by rebecca biaz on 11/9/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsManager.h"

@interface SettingsInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, unsafe_unretained) SettingsType settingsType;

@end
