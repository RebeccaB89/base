//
//  GrammarLogic.h
//  base
//
//  Created by rebecca biaz on 9/8/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrammarLogic : NSObject

+ (GrammarLogic *)sharedInstance;

- (NSString *)regexForFeatureInfos:(NSArray *)featureInfos;
- (NSArray *)regexPermissions;
- (NSString *)regexAllPermission;
- (BOOL)wordHavePermission:(NSString *)word;

@end
