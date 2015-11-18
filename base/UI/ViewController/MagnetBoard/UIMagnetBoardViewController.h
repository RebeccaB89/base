//
//  UIMagnetBoardViewController.h
//  base
//
//  Created by Rebecca Biaz on 5/13/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITopMenuView.h"
#import "UIFeatureViewController.h"
#import "UITemplateView.h"
#import "UIMagnetView.h"
#import "UINewWordViewController.h"

@interface UIMagnetBoardViewController : UIViewController <UIPopoverControllerDelegate, UITopMenuViewDelegate, UIFeatureViewControllerDelegate, UINewWordViewControllerDelegate>
{
    __weak IBOutlet UIView *_topMenuPlaceHolder;
    
    __weak IBOutlet NSLayoutConstraint *_topMenuConstraint;
    
    UITopMenuView *_topMenuView;
    UITapGestureRecognizer *_tapGesture;
    UIPopoverController *_popover;
    
    UITemplateView *_chosenTemplateView;
}

- (NSArray *)magnetsSelected;

@end
