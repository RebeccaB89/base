//
//  UIZoomableDraggableView.m
//  base
//
//  Created by Rebecca Biaz on 5/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIZoomableDraggableView.h"


@implementation UIZoomableDraggableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize
{
    [self enableDragging];
    self.cagingArea = [self areaCanDrag];
    
    [self initializeZoomableView];
    
    self.draggableEnabled = YES;
    self.zoomableEnabled = YES;
}

- (void)setZoomableEnabled:(BOOL)zoomableEnabled
{
    _zoomableEnabled = zoomableEnabled;
    
    [self setZoomable:_zoomableEnabled];
}

- (void)setDraggableEnabled:(BOOL)draggableEnabled
{
    _draggableEnabled = draggableEnabled;
    
    [self setDraggable:_draggableEnabled];
}

- (CGRect)areaCanDrag
{
    return [Shared appDelegate].window.bounds;
}

@end
