//
//  UIDictionnaryTableViewCell.h
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "UIMagnetView.h"
#include "WordInfo.h"

@interface UIDictionnaryTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UIView *_magnetPlaceholder;
    
    __weak IBOutlet UIImageView *_imageView;
    
    UIMagnetView *_magnetView;
    TZStackView *_stackView;
    NSMutableArray *_magnetViews;
}

@property (nonatomic, strong) WordInfo *wordInfo;

@end
