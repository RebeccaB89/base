//
//  UIMagnetView.m
//  base
//
//  Created by rebecca biaz on 7/22/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIMagnetView.h"

@implementation UIMagnetView

+ (UIMagnetView *)magnetViewForSuperView:(UIView *)superView removeFromSuperView:(BOOL)removeFromSuperView inPoint:(CGPoint)point
{
    UIMagnetView *magnetView = [UIMagnetView loadFromNib];
    magnetView.origin = point;
    [superView addSubview:magnetView];
    NSMutableArray *viewToRemove = [NSMutableArray array];
    for (UIView *subview in superView.subviews)
    {
        if ([subview isKindOfClass:[UIMagnetView class]])
        {
            continue;
        }
        
        CGFloat bigPercent = 0;
        UIView *goodMagnet = nil;
        for (UIView *placeholder in magnetView.subviews)
        {
            CGRect magnetFrame = [superView convertRect:placeholder.frame fromView:magnetView];
            CGFloat percent = [UIMagnetView percentOfIntersectionWithRect:magnetFrame withRect2:subview.frame];
            //percent = percent/magnetViews.tag; //factor
            if (percent > bigPercent && placeholder.subviews.count == 0)
            {
                bigPercent = percent;
                goodMagnet = placeholder;
            }
        }
        if (goodMagnet)
        {
            CGRect subviewFrame = [superView convertRect:subview.frame toView:goodMagnet];
            subview.frame = subviewFrame;
            [UIView animateWithDuration:0.3 animations:^{
                subview.frame = goodMagnet.bounds;
            }];
//            subview.frame = goodMagnet.bounds;

            UIDraggableView *draggableView = (UIDraggableView *)subview;
            [draggableView setDraggable:NO];
            [goodMagnet addSubview:subview];
            [viewToRemove addObject:subview];
        }
    }
    
//    for (UIView *subToRemove in viewToRemove)
//    {
//        //[subToRemove removeFromSuperview];
//    }
    
    return magnetView;
}

- (BOOL)view:(UIView *)view isInsidePlaceHolder:(UIView *)placeHolder
{
    CGRect intersection = CGRectIntersection(view.frame, placeHolder.frame);
    
    if (!CGRectIsNull(intersection))
    {
        return YES;
    }
    return NO;
}

//Width and Height of both rects may be different
+ (CGFloat)percentOfIntersectionWithRect:(CGRect)rect1 withRect2:(CGRect)rect2
{
    if (CGRectIntersectsRect(rect1, rect2))
    {
        CGRect interRect = CGRectIntersection(rect1, rect2);

        return ((interRect.size.width * interRect.size.height) / (((rect1.size.width * rect1.size.height) + (rect2.size.width * rect2.size.height))/2.0) * 100.0);
    }
    return 0;
}

@end
