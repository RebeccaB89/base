//
//  UIDictionnaryTableViewCell.m
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIDictionnaryTableViewCell.h"

@implementation UIDictionnaryTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)initStackView:(NSArray *)subviews
{
    UIMagnetView *mag = subviews.firstObject;
    
    if (!_stackView && subviews.count > 0)
    {
        _stackView = [[OHStackView alloc] init];
        _stackView.frame = _magnetPlaceholder.bounds;
        _stackView.spacing = CGSizeMake(5, 0);
        _stackView.horizontalAlignment = OHStackAlignmentStackFirstEdges;
        _stackView.verticalAlignment = OHStackAlignmentAlignFirstEdges;
        
        [_magnetPlaceholder addSubview:_stackView];
        
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
        //subview.frame = _stackView.bounds;
        if (widthItem < subview.width )
        {
            subview.width = widthItem;
        }
        subview.height = _stackView.height;
        [_stackView addSubview:subview];
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLabel.text = nil;
    _imageView.image = nil;
    
    [_stackView removeFromSuperview];
    _stackView = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

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
    
    _titleLabel.text = _wordInfo.title;
    NSString *s = _wordInfo.imagePath;
    _imageView.image = _wordInfo.image;// [UIImage imageWithContentsOfFile:_wordInfo.imagePath];
    [self initStackView:_magnetViews];
}

@end
