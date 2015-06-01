//
//  UIZoomableView.m
//  base
//
//  Created by Rebecca Biaz on 5/13/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIZoomableView.h"
#import "UIView+Zoomable.h"

@interface UIZoomableView()
{
}
@end

@implementation UIZoomableView

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
    [self initializeZoomableView];
}
@end
