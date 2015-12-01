//
//  viewLogic.h
//  base
//
//  Created by Rebecca Biaz on 5/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIMagnetBoardViewController.h"
#import "UILoginViewController.h"
#import "UIStudentChooserViewController.h"
#import "UIRegisterViewController.h"
#import "UINewStudentViewController.h"

@interface viewLogic : NSObject
{
    UIMagnetBoardViewController *_magnetBoardViewController;
}

+ (viewLogic *)sharedInstance;

- (void)applicationLaunched; // call this on application launch
- (void)presentLoginViewController;
- (void)presentRegisterModalViewController;
- (void)presentNewStudentModalViewController;
- (void)presentMainViewController;
- (UIMagnetBoardViewController *)magnetBoardViewController;
- (void)presentModalViewController:(UIViewController *)viewController;

@end
