//
//  UIWordView.h
//  base
//
//  Created by rebecca biaz on 12/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIDraggableView.h"

@interface UIWordView : UIDraggableView
{
    __weak IBOutlet UIView *_templatesPlaceholder;
    
    OHStackView *_stackView;
    NSMutableArray *_magnetViews;


}

- (IBAction)closeButtonClicked:(UIButton *)sender;
@property (nonatomic, strong) WordInfo *wordInfo;

@end
