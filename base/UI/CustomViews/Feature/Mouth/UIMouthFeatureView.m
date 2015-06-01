//
//  UIMouthFeatureView.m
//  base
//
//  Created by Rebecca Biaz on 5/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIMouthFeatureView.h"
#import "FeaturesManager.h"
#import "UIMouthView.h"

@implementation UIMouthFeatureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.exclusiveTouch = YES;
    
    [self reloadData];
    [self layoutData];
}

- (void)reloadData
{
    _mouths = [[FeaturesManager sharedInstance] mouths];
}

- (void)layoutData
{
    [_mouthsCollectionView reloadData];
}

@end
