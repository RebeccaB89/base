//
//  UIMouthFeatureView.m
//  base
//
//  Created by Rebecca Biaz on 5/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIMouthFeatureView.h"
#import "FeaturesManager.h"

@implementation UIMouthFeatureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [_mouthsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"mouthCell"];

    _mouthsCollectionView.delegate = self;
    _mouthsCollectionView.dataSource = self;
    
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

/* UICollectionView Delegates */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_mouths count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mouthCell" forIndexPath:indexPath];
    UIMouthView *mouthView = (UIMouthView *)[cell viewWithTag:2653];
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    if (!mouthView)
    {
        mouthView = [UIMouthView loadFromNib];
        mouthView.tag = 2653;
        mouthView.delegate = self;
        [cell.contentView addSubview:mouthView];
        
    }
    
    mouthView.mouthInfo = [_mouths objectAtIndex:indexPath.row];
    
    return cell;
}

/* End UICollectionView Delegates */

/* UIMouthView Delegates */

- (void)mouthView:(UIMouthView *)mouthView mouthInfoClicked:(MouthInfo *)mouthInfo
{
    
}

/* End UIMouthView Delegates */

@end
