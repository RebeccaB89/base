//
//  viewLogic.m
//  base
//
//  Created by Rebecca Biaz on 5/11/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "viewLogic.h"

@implementation viewLogic

static viewLogic *sharedInstance = nil;

+ (viewLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
        return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationLaunched
{
    [self presentMainViewController];
    return;
}

- (void)presentMainViewController
{
    if (!_magnetBoardViewController)
    {
        _magnetBoardViewController = [UIMagnetBoardViewController loadFromNib];
    }
    [self presentViewController:_magnetBoardViewController animated:NO onWindow:YES completion:nil];
}

- (UIViewController *)currentViewController
{
    if ([[Shared appDelegate].window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        UIViewController *currentController = [((UINavigationController *)[Shared appDelegate].window.rootViewController) topViewController];
        return currentController;
    }
    return [Shared appDelegate].window.rootViewController;
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated onWindow:(BOOL)onWindow completion:(void (^)(void))completion
{
    if (onWindow)
        [Shared appDelegate].window.rootViewController = viewController;
    else
        [[self currentViewController] presentViewController:viewController animated:animated completion:completion];
}

@end
