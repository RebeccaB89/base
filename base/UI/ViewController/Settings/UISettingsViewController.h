//
//  UISettingsViewController.h
//  base
//
//  Created by rebecca biaz on 11/4/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UISettingTableViewCell.h"


@interface UISettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    
    NSMutableArray *_settings;
}

@end
