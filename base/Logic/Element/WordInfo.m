//
//  WordInfo.m
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "WordInfo.h"

@implementation WordInfo

+ (WordInfo *)wordWithTitle:(NSString *)title andImagePath:(NSString *)imagePath
{
    WordInfo *wordInfo = [[WordInfo alloc] init];
    wordInfo.title = title;
    wordInfo.imagePath = imagePath;
    
    return wordInfo;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.imagePath = [aDecoder decodeObjectForKey:@"imagePath"];
        self.featureInfos = [aDecoder decodeObjectForKey:@"featureInfos"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_imagePath forKey:@"imagePath"];
    [aCoder encodeObject:_featureInfos forKey:@"featureInfos"];
}

@end
