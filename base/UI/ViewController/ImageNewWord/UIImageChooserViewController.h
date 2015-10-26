//
//  UIImageChooserViewController.h
//  base
//
//  Created by rebecca biaz on 10/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIImageChooserViewController;

@protocol UIImageChooserViewControllerDelegate <NSObject>

- (void)imageChooserViewController:(UIImageChooserViewController *)imageChooserViewController didSelectedImage:(NSString *)imagePath;

@end

@interface UIImageChooserViewController : UIViewController < UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UIButton *_libraryButton;
    
    __weak IBOutlet UIButton *_cameraButton;
    
    __weak IBOutlet UICollectionView *_collectionView;
    
    NSMutableArray *_imagePaths;
}

- (IBAction)libraryButtonClicked:(UIButton *)sender;
- (IBAction)cameraButtonClicked:(UIButton *)sender;

@property (nonatomic, weak) id <UIImageChooserViewControllerDelegate> delegate;

@end
