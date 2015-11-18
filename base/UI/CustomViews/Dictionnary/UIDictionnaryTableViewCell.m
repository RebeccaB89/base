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
        _stackView = [[TZStackView alloc] initWithArrangedSubviews:subviews];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = TZStackViewDistributionFillEqually;
        _stackView.alignment = TZStackViewAlignmentCenter;

        _stackView.spacing = 5;
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_magnetPlaceholder addSubview:_stackView];
        
        CGFloat paddingStrech = subviews.count > 1 ? 0 : 30;
        [_magnetPlaceholder addConstraints:[_stackView stretchToHeightOfSuperView]];
        [_magnetPlaceholder addConstraints:[_stackView stretchToWidthOfSuperView:paddingStrech]];
        [_magnetPlaceholder addConstraints:[_stackView centerHorizontallyTo:_magnetPlaceholder]];
        [_magnetPlaceholder addConstraints:[_stackView centerVerticallyTo:_magnetPlaceholder]];
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
    NSLog(s);
    _imageView.image = [UIImage imageWithContentsOfFile:_wordInfo.imagePath];
    [self initStackView:_magnetViews];
}

@end
