//
//  UINewWordViewController.m
//  base
//
//  Created by rebecca biaz on 10/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UINewWordViewController.h"
#import "viewLogic.h"

@interface UINewWordViewController ()

@end

@implementation UINewWordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _currentWordInfo = [[WordInfo alloc] init];
    
    [_addImageButton setTitle:NLS(@"Click to choose image") forState:UIControlStateNormal];
    
    _magnetPlaceholder.spacing = 10;
    _magnetPlaceholder.axis = UILayoutConstraintAxisHorizontal;
    _magnetPlaceholder.distribution = OAStackViewDistributionFillEqually;
    _magnetPlaceholder.alignment = OAStackViewAlignmentFill;
    _magnetPlaceholder.layoutMarginsRelativeArrangement = YES;
    _magnetPlaceholder.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10);
    
    _magnetPlaceholder.layer.borderWidth = 3.0;
    _magnetPlaceholder.layer.borderColor = [UIColor purpleColor].CGColor;
    _magnetPlaceholder.layer.cornerRadius = 30.0;

    TZStackView *stackView = [[TZStackView alloc] initWithArrangedSubviews:_magnetViews];
    
    stackView.translatesAutoresizingMaskIntoConstraints = NO;

    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = TZStackViewDistributionFillEqually;
    stackView.alignment = TZStackViewAlignmentCenter;
    
    [_stackPlaceholder addSubview:stackView];
    
    [_stackPlaceholder addConstraints:[stackView stretchToHeightOfSuperView]];
    [_stackPlaceholder addConstraints:[stackView stretchToWidthOfSuperView]];
    [_stackPlaceholder addConstraints:[stackView centerHorizontallyTo:_stackPlaceholder]];
    [_stackPlaceholder addConstraints:[stackView centerVerticallyTo:_stackPlaceholder]];
    
    if (_magnetViews.count)
    {
        [self addMagnetViewsToPlaceholder:_magnetViews];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)notifyWillDismissWithNewWord:(WordInfo *)wordInfo
{
    if ([self.delegate respondsToSelector:@selector(newWordViewController:willDismissWithNewWord:)])
    {
        [self.delegate newWordViewController:self willDismissWithNewWord:wordInfo];
    }
}

- (void)setMagnetViews:(NSArray *)magnetViews
{
    for (UIView *subview in _magnetViews)
    {
        [subview removeFromSuperview];
    }
    
    _magnetViews = magnetViews;
    
    for (UIMagnetView *subview in magnetViews)
    {
        [subview setDraggable:NO];
    }
    
    [self addMagnetViewsToPlaceholder:_magnetViews];
}

- (void)addMagnetViewsToPlaceholder:(NSArray *)magnetsView
{
//    int count = magnetsView.count;
//    
//    int offset = 15;
//    CGFloat maxWidhtItem = 200;
//    CGFloat widhtItem = (_magnetPlaceholder.width - (offset * (count - 1)))/ count;
//    
//    if (widhtItem > maxWidhtItem)
//    {
//        widhtItem = maxWidhtItem;
//    }
    
    for (UIMagnetView *subview in _magnetViews)
    {
        subview.backgroundColor = [UIColor orangeColor];
        [_magnetPlaceholder addArrangedSubview:subview];
        
 //       NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_magnetPlaceholder attribute:NSLayoutAttributeTop multiplier:1.0 constant:1];
//
//        [_magnetPlaceholder addConstraint:topConstraint];
    }
}

//- (void)setMagnetView:(UIMagnetView *)magnetView
//{
//    
//    [_magnetView removeFromSuperview];
//    
//    _magnetView = magnetView;
//    [_magnetView setDraggable:NO];
//
//    _magnetView.frame = _magnetPlaceholder.bounds;
//    
//    [_magnetPlaceholder addSubview:_magnetView];
//}

- (void)layoutData
{
    
}

- (BOOL)checkInput
{
    BOOL goodInput = YES;
    
    _currentWordInfo.title = _titleTextField.text;
    //_currentWordInfo.featureInfos = _magnetView.featureInfos;
    
    if (_currentWordInfo.title.length == 0)
    {
        _currentWordInfo.title = @"t";
        goodInput = NO;
    }
    
    NSMutableArray *featureInfos = [NSMutableArray array];
    for (UIMagnetView *magnetView in _magnetViews)
    {
        [featureInfos addObject:magnetView.featureInfos];
    }
    
    _currentWordInfo.featureInfos = featureInfos;
    
    if (_currentWordInfo.featureInfos.count < 1)
    {
        goodInput = NO;
    }
    
    return YES;
}

- (IBAction)doneClicked:(UIBarButtonItem *)sender
{
    if (![self checkInput])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NLS(@"Error Input") message:@"Please check your input" delegate:nil cancelButtonTitle:NLS(@"OK") otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self notifyWillDismissWithNewWord:_currentWordInfo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addImageClicked:(UIButton *)sender
{
    UIImageChooserViewController *imageChooserViewController = [UIImageChooserViewController loadFromNib];
    imageChooserViewController.delegate = self;
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:imageChooserViewController];
    _popover.delegate = self;
    
    [_popover presentPopoverFromRect:_addImageButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/* UIImageChooserViewController Delegates */

- (void)imageChooserViewController:(UIImageChooserViewController *)imageChooserViewController didSelectedImage:(NSString *)imagePath withImageName:(NSString *)imageName
{
    _imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    _currentWordInfo.imagePath = imagePath;
    _currentWordInfo.imageName = imageName;
}

/* End UIImageChooserViewController Delegates */

/* UIAlertView Delegates */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

/* End UIAlertView Delegates */


@end
