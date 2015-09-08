//
//  UIColorFeatureView.m
//  base
//
//  Created by Rebecca Biaz on 5/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIBaseFeaturesView.h"
#import "FeaturesManager.h"

@interface UIBaseFeaturesView()

- (void)notifyFeatureInfoSelected:(FeatureInfo *)featureInfo;

@end

@implementation UIBaseFeaturesView

+ (CGSize)sizeForNumOfItems:(int)items withWidth:(CGFloat)width
{
    CGSize sizeOfMouthView = [UIFeatureView sizeForNib];
    CGFloat numOfItemsPerLine = floor(width / sizeOfMouthView.width);
    CGFloat numOfLinesForItems = ceil(items/numOfItemsPerLine);
    
    return CGSizeMake(width, numOfLinesForItems * sizeOfMouthView.height + 10);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [_colorsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"colorCell"];

    _colorsCollectionView.delegate = self;
    _colorsCollectionView.dataSource = self;
    
    _colorsCollectionView.exclusiveTouch = YES;
    
    [self layoutData];
}

- (void)setFeatureInfos:(NSArray *)featureInfos
{
    _featureInfos = featureInfos;
    [self layoutData];
}

- (void)layoutData
{
    [_colorsCollectionView reloadData];
}

- (void)notifyFeatureInfoSelected:(FeatureInfo *)featureInfo
{
    if ([self.delegate respondsToSelector:@selector(baseFeaturesView:didSelectFeatureInfo:)])
    {
        [_delegate baseFeaturesView:self didSelectFeatureInfo:featureInfo];
    }
}

/* UICollectionView Delegates */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_featureInfos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];
    UIFeatureView *colorView = (UIFeatureView *)[cell viewWithTag:2654];
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    if (!colorView)
    {
        colorView = [UIFeatureView loadFromNib];
        colorView.tag = 2654;
        [cell.contentView addSubview:colorView];
        
    }
    
    colorView.featureInfo = [_featureInfos objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIFeatureView *featureView = (UIFeatureView *)[cell viewWithTag:2654];
    
    [self notifyFeatureInfoSelected:featureView.featureInfo];
}

/* End UICollectionView Delegates */


@end
