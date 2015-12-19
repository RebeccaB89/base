//
//  UIDictionnaryViewController.h
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionnaryManager.h"

@class UIDictionnaryViewController;

@protocol UIDictionnaryViewControllerDelegate <NSObject>

- (void)dictionnaryViewController:(UIDictionnaryViewController *)dictionnaryViewController didSelectWord:(WordInfo *)word;

@end

@interface UIDictionnaryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UISearchBar *_searchBar;
    
    __weak IBOutlet UIButton *_addNewWordButton;
    
    NSArray *_words;
}

@property (nonatomic, weak) id<UIDictionnaryViewControllerDelegate> delegate;

@end
