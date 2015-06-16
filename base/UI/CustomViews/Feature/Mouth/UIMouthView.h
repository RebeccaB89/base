//
//  UIMouthView.h
//  base
//
//  Created by Rebecca Biaz on 5/31/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MouthInfo.h"

@class UIMouthView;

@protocol UIMouthViewDelegate <NSObject>

- (void)mouthView:(UIMouthView *)mouthView mouthInfoClicked:(MouthInfo *)mouthInfo;

@end

@interface UIMouthView : UIView
{
    __weak IBOutlet UILabel *_nameLabel;
    
    __weak IBOutlet UIImageView *_imageView;
}

@property (nonatomic, strong) MouthInfo *mouthInfo;

@property (nonatomic, weak) id<UIMouthViewDelegate> delegate;

- (IBAction)mouthClicked:(UIButton *)sender;

@end
