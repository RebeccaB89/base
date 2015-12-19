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
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.image = [aDecoder decodeObjectForKey:@"image"];

        self.featureInfos = [aDecoder decodeObjectForKey:@"featureInfos"];
        
        [self updateImagePath];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_imagePath forKey:@"imagePath"];
    [aCoder encodeObject:_image forKey:@"image"];

    [aCoder encodeObject:_imageName forKey:@"imageName"];
    [aCoder encodeObject:_featureInfos forKey:@"featureInfos"];
}

- (void)updateImagePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"DefaultImageChooser"];
    
    NSString* path = [sourcePath stringByAppendingPathComponent:
                      self.imageName];
    
    _imagePath = path;
}

- (id)copyWithZone:(NSZone *)zone
{
    WordInfo *copy = [[WordInfo alloc] init];
    
    copy.title = [self.title copyWithZone:zone];
    copy.imagePath = [self.imagePath copyWithZone:zone];
    copy.imageName = [self.imageName copyWithZone:zone];
    copy.image = [[UIImage alloc] initWithCGImage:self.image.CGImage];

    NSMutableArray *featuresInfo = [NSMutableArray array];
    for (NSArray *features in self.featureInfos)
    {
        NSArray *subFeatures = [[NSArray alloc] initWithArray:features copyItems:YES];
        [featuresInfo addObject:subFeatures];
    }
    
    copy.featureInfos = featuresInfo;
    return copy;
}

@end
