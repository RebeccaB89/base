//
//  UIWordView.m
//  base
//
//  Created by rebecca biaz on 12/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIWordView.h"

@implementation UIWordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setWordInfo:(WordInfo *)wordInfo
{
    _wordInfo = wordInfo;
    
    [self reloadData];
    [self setNeedsLayout];
}

- (void)reloadData
{
    _magnetViews = [NSMutableArray array];
    for (NSArray *features in _wordInfo.featureInfos)
    {
        UIMagnetView *magnetView = [UIMagnetView loadFromNib];
        [magnetView setFeatureInfos:features];
        magnetView.userInteractionEnabled = NO;
        magnetView.selectionDisplay = NO;
        [_magnetViews addObject:magnetView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self initStackView:_magnetViews];
}

- (void)initStackView:(NSArray *)subviews
{
    if (!_stackView && subviews.count > 0)
    {
        _stackView = [[OHStackView alloc] init];
        _stackView.frame = _templatesPlaceholder.bounds;
        _stackView.spacing = CGSizeMake(5, 0);
        _stackView.horizontalAlignment = OHStackAlignmentStackFirstEdges;
        _stackView.verticalAlignment = OHStackAlignmentAlignFirstEdges;
        
        [_templatesPlaceholder addSubview:_stackView];
        
        [_stackView autoPinEdgesToSuperviewEdges];
        [_stackView autoCenterInSuperview];
        
        [_stackView autoPinEdgesToSuperviewEdges];
        [_stackView autoCenterInSuperview];
    }
    
    [_stackView removeAllSubviews];
    
    int divide = subviews.count > 0 ? subviews.count : 1;
    CGFloat widthItem = (_stackView.width / divide) - (_stackView.spacing.width * (subviews.count - 1));
    
    for (UIView *subview in subviews)
    {
        if (widthItem < subview.width )
        {
            subview.width = widthItem;
        }
        subview.height = _stackView.height;
        [_stackView addSubview:subview];
    }
}

- (IBAction)closeButtonClicked:(UIButton *)sender
{
    [self removeFromSuperview];
}

@end
