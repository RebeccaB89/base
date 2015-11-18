//
//  DictionnaryManager.h
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSerializeData.h"
#import "FeatureInfo.h"
#import "WordInfo.h"

@interface DictionnaryManager : BaseSerializeData
{
    NSMutableArray *_words;
}

+ (DictionnaryManager *)sharedInstance;

- (NSArray *)words;
- (BOOL)addWordInfo:(WordInfo *)wordInfo;

@end
