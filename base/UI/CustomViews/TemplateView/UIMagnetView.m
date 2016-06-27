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
    magnetView.origin = CGPointMake(point.x - magnetView.mainView.origin.x, point.y - magnetView.mainView.origin.y);
    [superView addSubview:magnetView];
    NSMutableArray *viewToRemove = [NSMutableArray array];
    for (UIView *placeholder in superView.subviews)
    {
        UIView *subview = placeholder;
        if ([placeholder.subviews.firstObject isKindOfClass:[UITemplateView class]])
        {
            subview = placeholder.subviews.firstObject;
        }
        
        if ([subview isKindOfClass:[UIMagnetView class]] || ![subview isKindOfClass:[UITemplateView class]])
        {
            continue;
        }
        
        CGFloat bigPercent = 0;
        UIView *goodMagnet = nil;
        for (UIView *placeholder in magnetView.subviews)
        {
            if (placeholder.tag >= 100)
            {
                continue;
            }
            
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
            UITemplateView *templateView = (UITemplateView *)subview;
            templateView.deletable = NO;
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

        UITemplateView *templateView = (UITemplateView *)subview;
        templateView.deletable = YES;
        
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

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.selectionDisplay = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *placeholder in self.subviews)
    {
        placeholder.backgroundColor = [UIColor clearColor];

        if (placeholder.subviews.count > 0 && (placeholder.tag == 3 || placeholder.tag == 5 || placeholder.tag == 4))
        {
            placeholder.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)setSelectionDisplay:(BOOL)selectionDisplay
{
    _selectionDisplay = selectionDisplay;
    
    [self layoutData];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(50, 50);
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

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
}
- (id)copyWithZone:(NSZone *)zone
{
    return [self copy];
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
    tempTemplateView.deletable = NO;
    
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
        templateView.deletable = NO;

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
        templateView.deletable = NO;
        
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
        templateView.deletable = NO;

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
        templateView.deletable = NO;
        
        [_soundView addSubview:templateView];
    }
}

- (NSInteger)indexForView:(UIView *)subview
{
    return subview.tag;
}

- (UIView *)subviewForIndex:(NSInteger)index
{
    UIView *subview = [self viewWithTag:index];
    
    return subview;
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
    if (_selectionDisplay)
    {
        _mainView.layer.borderWidth = 3.0;
        _mainView.layer.borderColor = [UIColor blackColor].CGColor;
        
        _throatView.layer.borderWidth = 3.0;
        _throatView.layer.borderColor = [UIColor blackColor].CGColor;
        
        _vowelView.layer.borderWidth = 3.0;
        _vowelView.layer.borderColor = [UIColor blackColor].CGColor;
        
        _accesoryView.layer.borderWidth = 3.0;
        _accesoryView.layer.borderColor = [UIColor blackColor].CGColor;
        
        _colorView.layer.borderWidth = 3.0;
        _colorView.layer.borderColor = [UIColor blackColor].CGColor;
        
        _soundView.layer.borderWidth = 3.0;
        _soundView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else
    {
        _mainView.layer.borderWidth = 0.0;
        _mainView.layer.borderColor = [UIColor clearColor].CGColor;
        _mainView.layer.cornerRadius = 00.0;
        
        _throatView.layer.borderWidth = 0.0;
        _throatView.layer.borderColor = [UIColor clearColor].CGColor;
        _vowelView.layer.cornerRadius = 00.0;
        
        _vowelView.layer.borderWidth = 0.0;
        _vowelView.layer.borderColor = [UIColor clearColor].CGColor;
        _vowelView.layer.cornerRadius = 00.0;
        
        _accesoryView.layer.borderWidth = 0.0;
        _accesoryView.layer.borderColor = [UIColor clearColor].CGColor;
        _accesoryView.layer.cornerRadius = 00.0;
        
        _colorView.layer.borderWidth = 0.0;
        _colorView.layer.borderColor = [UIColor clearColor].CGColor;
        _colorView.layer.cornerRadius = 00.0;
        
        _soundView.layer.borderWidth = 0.0;
        _soundView.layer.borderColor = [UIColor clearColor].CGColor;
        _soundView.layer.cornerRadius = 00.0;
    }
    
    if (_isSelected)
    {
        _mainView.layer.borderColor = [UIColor blueColor].CGColor;
        _throatView.layer.borderColor = [UIColor blueColor].CGColor;
        _vowelView.layer.borderColor = [UIColor blueColor].CGColor;
        _accesoryView.layer.borderColor = [UIColor blueColor].CGColor;
        _colorView.layer.borderColor = [UIColor blueColor].CGColor;
        _soundView.layer.borderColor = [UIColor blueColor].CGColor;
    }
    else
    {
        _mainView.layer.borderColor = [UIColor blackColor].CGColor;
        _vowelView.layer.borderColor = [UIColor blackColor].CGColor;
        _accesoryView.layer.borderColor = [UIColor blackColor].CGColor;
        _colorView.layer.borderColor = [UIColor blackColor].CGColor;
        _soundView.layer.borderColor = [UIColor blackColor].CGColor;
    }
}

- (NSArray *)featureInfos
{
    NSMutableArray *feautureInfos = [NSMutableArray array];
    
    //insert empty feature
    for (NSInteger i = 0; i < self.subviews.count; ++i)
    {
        [feautureInfos addObject:[NSNull null]];
    }
    
    for (UIView *placeholder in self.subviews)
    {
        UIView *subview = placeholder.subviews.firstObject;
        
        if ([subview isKindOfClass:[UITemplateView class]])
        {
            UITemplateView *templateView = (UITemplateView *)subview;
            if (templateView.featureInfo)
            {
                [feautureInfos setObject:templateView.featureInfo atIndexedSubscript:placeholder.tag];
            }
        }
    }
    
    return feautureInfos;
}

- (void)setFeatureInfos:(NSArray *)featureInfos
{
    if (self.mainView.subviews.firstObject != nil)
    {
       // return;
    }
    for (int i = 0; i < featureInfos.count; i++)
    {
        FeatureInfo *feature = [featureInfos objectAtIndex:i];
        if ([feature isKindOfClass:[NSNull class]])
        {
            continue;
        }
        UIView *subview = [self subviewForIndex:i];
        [subview removeAllSubviews];
        UITemplateView *templateView = [UITemplateView loadFromNib];
        templateView.frame = subview.bounds;
        templateView.featureInfo = feature;
        templateView.deletable = NO;
        [subview addSubview:templateView];
    }
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
