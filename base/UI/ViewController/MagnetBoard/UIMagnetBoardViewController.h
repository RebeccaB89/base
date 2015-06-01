//
//  UIMagnetBoardViewController.h
//  base
//
//  Created by Rebecca Biaz on 5/13/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITopMenuView.h"

@interface UIMagnetBoardViewController : UIViewController <UITopMenuViewDelegate>
{
    __weak IBOutlet UIView *_topMenuPlaceHolder;
    
    __weak IBOutlet NSLayoutConstraint *_topMenuConstraint;
    
    UITopMenuView *_topMenuView;
    UITapGestureRecognizer *_tapGesture;
}

@end
