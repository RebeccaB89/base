//
//  viewLogic.h
//  base
//
//  Created by Rebecca Biaz on 5/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIMagnetBoardViewController.h"


@interface viewLogic : NSObject
{
    UIMagnetBoardViewController *_magnetBoardViewController;
}

+ (viewLogic *)sharedInstance;

- (void)applicationLaunched; // call this on application launch
- (void)presentMainViewController;
- (UIMagnetBoardViewController *)magnetBoardViewController;
- (void)presentModalViewController:(UIViewController *)viewController;

@end
