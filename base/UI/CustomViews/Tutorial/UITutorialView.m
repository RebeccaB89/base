//
//  UITutorialView.m
//  base
//
//  Created by rebecca biaz on 12/19/15.
//  Copyright © 2015 rebecca. All rights reserved.
//

#import "UITutorialView.h"

@implementation UITutorialView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)closeButtonClicked:(id)sender
{
    [self removeFromSuperview];
}

@end
