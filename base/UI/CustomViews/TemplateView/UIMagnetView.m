//
//  UIMagnetView.m
//  base
//
//  Created by rebecca biaz on 7/22/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIMagnetView.h"
#import "UIZoomableView.h"
#import "UIZoomableDraggableView.h"
#import "UITemplateView.h"

#import "MouthInfo.h"
#import "ThroatInfo.h"
#import "ColorInfo.h"
#import "VowelInfo.h"
#import "SyllableTimeInfo.h"

@implementation UIMagnetView

+ (UIMagnetView *)magnetViewForSuperView:(UIView *)superView removeFromSuperView:(BOOL)removeFromSuperView inPoint:(CGPoint)point
{
    UIMagnetView *magnetView = [UIMagnetView loadFromNib];
    magnetView.origin = point;
    [superView addSubview:magnetView];
    NSMutableArray *viewToRemove = [NSMutableArray array];
    for (UIView *placeholder in superView.subviews)
    {
        UIView *subview = placeholder;
        if ([placeholder.subviews.firstObject isKindOfClass:[UITemplateView class]])
        {
            subview = placeholder.subviews.firstObject;
        }
        
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

            UIDraggableView *draggableView = (UIDraggableView *)subview;
            [draggableView setDraggable:NO];
            UIZoomableView *zoomableView = (UIZoomableView *)subview;
            [zoomableView setZoomable:NO];
            [goodMagnet addSubview:subview];
            [viewToRemove addObject:subview];
        }
    }
    
    for (UIView *subview in magnetView.subviews)
    {
        if (!subview.subviews.count)
        {
            subview.hidden = YES;
        }
    }
    
//    for (UIView *subToRemove in viewToRemove)
//    {
//        //[subToRemove removeFromSuperview];
//    }
    
    return magnetView;
}

+ (void)breakMagnetView:(UIMagnetView *)magnetView
{
    NSMutableArray *viewsToRemove = [NSMutableArray array];
    for (UIView *placeHolder in magnetView.subviews)
    {
        UIView *subview = placeHolder.subviews.firstObject;
        
        UIDraggableView *draggableView = (UIDraggableView *)subview;
        [draggableView setDraggable:YES];
        UIZoomableView *zoomableView = (UIZoomableView *)subview;
        [zoomableView setZoomable:YES];

        if ([zoomableView isKindOfClass:[UIZoomableView class]] || [zoomableView isKindOfClass:[UIZoomableDraggableView class]] )
        {
            CGRect subviewFrame =  [magnetView convertRect:placeHolder.frame toView:magnetView.superview];
            
            subview.frame = subviewFrame;
            if (subview.superview == magnetView.throatView)
            {
                subviewFrame.origin.x += 100;
            }
            if (subview.superview == magnetView.vowelView)
            {
                subviewFrame.origin.x -= 100;
            }

            if (subview.superview == magnetView.colorView)
            {
                subviewFrame.origin.y -= 30;
                subviewFrame.origin.x += 30;
            }
            
            if (subview.superview == magnetView.accesoryView)
            {
                subviewFrame.origin.y -= 30;
                subviewFrame.origin.x -= 30;
            }
            
            if (subview.superview == magnetView.soundView)
            {
                subviewFrame.origin.y += 30;
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                subview.frame = subviewFrame;
            }];
        }
        
        if (subview)
        {
            [viewsToRemove addObject:subview];
        }
    }
    
    for (UIView *v in viewsToRemove)
    {
        [v removeFromSuperview];
        [magnetView.superview addSubview:v];
    }
    
    [magnetView removeFromSuperview];
}

- (id)copy
{
    UIMagnetView *copy = [UIMagnetView loadFromNib];

    NSArray *featureInfos = self.featureInfos;
//    for (FeatureInfo *feature in featureInfos)
//    {
//        [copy addTemplateViewForFeatureInfo:feature];
//    }
    [self addTemplateView:(UITemplateView *)self.mainView.subviews.firstObject inSubview:copy.mainView];
    [self addTemplateView:(UITemplateView *)self.throatView.subviews.firstObject inSubview:copy.throatView];
    [self addTemplateView:(UITemplateView *)self.accesoryView.subviews.firstObject inSubview:copy.accesoryView];
    [self addTemplateView:(UITemplateView *)self.vowelView.subviews.firstObject inSubview:copy.vowelView];
    [self addTemplateView:(UITemplateView *)self.soundView.subviews.firstObject inSubview:copy.soundView];
    [self addTemplateView:(UITemplateView *)self.colorView.subviews.firstObject inSubview:copy.colorView];
    
    return copy;
}

- (void)addTemplateView:(UITemplateView *)templateView inSubview:(UIView *)subview
{
    if (!templateView)
    {
        return;
    }
    UITemplateView *tempTemplateView = [UITemplateView loadFromNib];
    tempTemplateView.frame = templateView.frame;
    tempTemplateView.featureInfo = templateView.featureInfo;

    UIDraggableView *draggableView = (UIDraggableView *)tempTemplateView;
    [draggableView setDraggable:NO];
    UIZoomableView *zoomableView = (UIZoomableView *)tempTemplateView;
    [zoomableView setZoomable:NO];
    
    [subview addSubview:tempTemplateView];
}

- (void)addTemplateViewForFeatureInfo:(FeatureInfo *)featureInfo
{
    if ([featureInfo isKindOfClass:[MouthInfo class]])
    {
        UITemplateView *templateView = [UITemplateView loadFromNib];
        
        templateView.featureInfo = featureInfo;
        templateView.frame = _throatView.bounds;
        
        UIDraggableView *draggableView = (UIDraggableView *)templateView;
        [draggableView setDraggable:NO];
        UIZoomableView *zoomableView = (UIZoomableView *)templateView;
        [zoomableView setZoomable:NO];

        [_throatView addSubview:templateView];
    }
    
    if ([featureInfo isKindOfClass:[ColorInfo class]])
    {
        UITemplateView *templateView = [UITemplateView loadFromNib];

        templateView.featureInfo = featureInfo;
        templateView.frame = _mainView.bounds;
        
        UIDraggableView *draggableView = (UIDraggableView *)templateView;
        [draggableView setDraggable:NO];
        UIZoomableView *zoomableView = (UIZoomableView *)templateView;
        [zoomableView setZoomable:NO];

        
        [_mainView addSubview:templateView];
    }
    
    if ([featureInfo isKindOfClass:[ThroatInfo class]])
    {
        UITemplateView *templateView = [UITemplateView loadFromNib];

        templateView.featureInfo = featureInfo;
        templateView.frame = _vowelView.bounds;
        
        UIDraggableView *draggableView = (UIDraggableView *)templateView;
        [draggableView setDraggable:NO];
        UIZoomableView *zoomableView = (UIZoomableView *)templateView;
        [zoomableView setZoomable:NO];

        [_vowelView addSubview:templateView];
    }
    
    if ([featureInfo isKindOfClass:[SyllableTimeInfo class]])
    {
        UITemplateView *templateView = [UITemplateView loadFromNib];
        
        templateView.featureInfo = featureInfo;
        templateView.frame = _soundView.bounds;
        
        UIDraggableView *draggableView = (UIDraggableView *)templateView;
        [draggableView setDraggable:NO];
        UIZoomableView *zoomableView = (UIZoomableView *)templateView;
        [zoomableView setZoomable:NO];
        
        [_soundView addSubview:templateView];
    }
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

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    [self layoutData];
}

- (void)layoutData
{
    if (_isSelected)
    {
        self.layer.borderWidth = 3.0;
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.cornerRadius = 30.0;

    }
    else
    {
        self.layer.borderWidth = 0.0;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.cornerRadius = 00.0;
    }
}

- (NSArray *)featureInfos
{
    NSMutableArray *feautureInfos = [NSMutableArray array];
    
    for (UIView *placeholder in self.subviews)
    {
        UIView *subview = placeholder.subviews.firstObject;
        
        if ([subview isKindOfClass:[UITemplateView class]])
        {
            UITemplateView *templateView = (UITemplateView *)subview;
            if (templateView.featureInfo)
            {
                [feautureInfos addObject:templateView.featureInfo];
            }
        }
    }
    
    return feautureInfos;
}

- (UIView *)mainView
{
    return _mainView;
}

- (UIView *)throatView
{
    return _throatView;
}

- (UIView *)vowelView
{
    return _vowelView;
}

- (UIView *)colorView
{
    return _colorView;
}

- (UIView *)soundView
{
    return _soundView;
}

- (UIView *)accesoryView
{
    return _accesoryView;
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
