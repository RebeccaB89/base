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
    
    _stackView = [[OHStackView alloc] init];
    _stackView.frame = _stackPlaceholder.bounds;
    _stackView.spacing = CGSizeMake(10, 0);
    _stackView.horizontalAlignment = OHStackAlignmentStackFirstEdges;
    _stackView.verticalAlignment = OHStackAlignmentAlignFirstEdges;

    _stackView.layer.borderWidth = 3.0;
    _stackView.layer.borderColor = [UIColor purpleColor].CGColor;
    _stackView.layer.cornerRadius = 30.0;
    
    [_stackPlaceholder addSubview:_stackView];
    
    [_stackView autoPinEdgesToSuperviewEdges];
    [_stackView autoCenterInSuperview];
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    if (!_stackView)
    {
        return;
    }
    int divide = magnetsView.count > 0 ? magnetsView.count : 1;
    CGFloat widthItem = (_stackView.width / divide) - (_stackView.spacing.width * (magnetsView.count - 1));
    
    for (UIMagnetView *subview in _magnetViews)
    {
        if (widthItem < subview.width )
        {
            subview.width = widthItem;
        }
        subview.backgroundColor = [UIColor clearColor];
        [_stackView addSubview:subview];
    }
}

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
    _currentWordInfo.image = [UIImage imageWithContentsOfFile:imagePath];
    _currentWordInfo.imageName = imageName;
}

/* End UIImageChooserViewController Delegates */

/* UIAlertView Delegates */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

/* End UIAlertView Delegates */


@end
