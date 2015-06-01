//
//  UIFeatureViewController.h
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureInfo.h"

@interface UIFeatureViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_featureArray;
    UIView *_subMenuView;
    NSIndexPath *_subMenuIndexPath;
}

@end
