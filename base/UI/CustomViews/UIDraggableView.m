//
//  UIDraggableView.m
//  base
//
//  Created by Rebecca Biaz on 5/13/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIDraggableView.h"


@implementation UIDraggableView

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
    [self setDraggable:YES];
    self.cagingArea = [self areaCanDrag];
}

- (CGRect)areaCanDrag
{
    return [Shared appDelegate].window.bounds;
}

@end
