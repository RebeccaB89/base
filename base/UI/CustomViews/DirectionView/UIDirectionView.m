//
//  UIDirectionView.m
//  base
//
//  Created by rebecca biaz on 10/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIDirectionView.h"

@implementation UIDirectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _point = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 15, 15)];
    _point.backgroundColor = [UIColor blackColor];
    _point.layer.borderWidth = 3.0;
    _point.layer.borderColor = [UIColor blackColor].CGColor;
    _point.layer.cornerRadius = 10.0;
    [self addSubview:_point];
    
    _directionViewType = rightDirectionViewType;
    _directionEnabled = YES;
    
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.cornerRadius = 20.0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutData];
}

- (void)setDirectionViewType:(DirectionReadType)directionViewType
{
    _directionViewType = directionViewType;
    
    [self setNeedsLayout];
}

- (void)setDirectionEnabled:(BOOL)directionEnabled
{
    _directionEnabled = directionEnabled;
    
    [self setNeedsLayout];
}

- (void)layoutData
{
    if (_directionViewType == leftDirectionViewType || _directionViewType == noDirectionViewType)
    {
        _point.origin = CGPointMake(20, _point.origin.y);
    }
    if (_directionViewType == rightDirectionViewType )
    {
        _point.origin = CGPointMake(self.width - 20 - _point.width, _point.origin.y);
    }

    _point.hidden = !_directionEnabled;
}

@end
