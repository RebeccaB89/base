//
//  DictionnaryManager.m
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "DictionnaryManager.h"

@implementation DictionnaryManager

static DictionnaryManager *sharedInstance = nil;

+ (DictionnaryManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [DictionnaryManager load];
            if (sharedInstance == nil)
            {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        [self initialize:nil];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_words forKey:@"words"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _words = [aDecoder decodeObjectForKey:@"words"];
        
        [self initialize:aDecoder];
    }
    return self;
}

- (void)initialize:(NSCoder *)aDecoder
{
}

- (NSArray *)words
{
    return _words;
}

- (BOOL)addFeatureInfosToWords:(NSArray *)featureInfos
{
    return NO;
}

@end
