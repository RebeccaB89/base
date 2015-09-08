//
//  UIFeatureViewController.h
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureInfo.h"
#import "UIBaseFeaturesView.h"

@class UIFeatureViewController;

@protocol UIFeatureViewControllerDelegate <NSObject>

- (void)featureViewControlelr:(UIFeatureViewController *)featureViewController didSelectFeatureInfo:(FeatureInfo *)featureInfo;
@end

@interface UIFeatureViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIBaseFeaturesViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_featureArray;
    UIView *_subMenuView;
    NSIndexPath *_subMenuIndexPath;
}

@property (nonatomic, weak) id<UIFeatureViewControllerDelegate> delegate;

@end
