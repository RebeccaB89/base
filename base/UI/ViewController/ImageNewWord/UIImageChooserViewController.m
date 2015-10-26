//
//  UIImageChooserViewController.m
//  base
//
//  Created by rebecca biaz on 10/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIImageChooserViewController.h"

@interface UIImageChooserViewController ()

- (void)notifyImageSelected:(NSString *)imagePath;

@end

@implementation UIImageChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_libraryButton setTitle:NLS(@"Library") forState:UIControlStateNormal];
    
    [_cameraButton setTitle:NLS(@"Library") forState:UIControlStateNormal];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"wordImage"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self layoutData];
}

- (void)layoutData
{
    [_collectionView reloadData];
}

- (void)notifyImageSelected:(NSString *)imagePath
{
    if ([self.delegate respondsToSelector:@selector(imageChooserViewController:didSelectedImage:)])
    {
        [self.delegate imageChooserViewController:self didSelectedImage:imagePath];
    }
}

- (IBAction)libraryButtonClicked:(UIButton *)sender
{
}

- (IBAction)cameraButtonClicked:(UIButton *)sender
{
}

/* UICollectionView Delegates */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_imagePaths count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wordImage" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:36475];
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imageView.tag = 36475;
        [cell.contentView addSubview:imageView];
    }
    
    imageView.image = IMAGE([_imagePaths objectAtIndex:indexPath.row]);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self notifyImageSelected:[_imagePaths objectAtIndex:indexPath.row]];
}

/* End UICollectionView Delegates */

@end
