//
//  UIMagnetView.h
//  base
//
//  Created by rebecca biaz on 7/22/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIDraggableView.h"

@interface UIMagnetView : UIDraggableView
{
    __weak IBOutlet UIView *_mainView;
    
    __weak IBOutlet UIView *_accesoryView;
    
    __weak IBOutlet UIView *_colorView;
    
    __weak IBOutlet UIView *_soundView;
}

+ (UIMagnetView *)magnetViewForSuperView:(UIView *)superView removeFromSuperView:(BOOL)removeFromSuperView inPoint:(CGPoint)point;
+ (CGFloat)percentOfIntersectionWithRect:(CGRect)rect1 withRect2:(CGRect)rect2;

@end