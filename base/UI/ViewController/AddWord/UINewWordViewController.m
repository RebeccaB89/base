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
    
    _currentWordInfo = nil;
    
    if (_magnetView)
    {
        _magnetView.frame = _magnetPlaceholder.bounds;
        [_magnetPlaceholder addSubview:_magnetView];
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

- (void)setMagnetView:(UIMagnetView *)magnetView
{
    [_magnetView removeFromSuperview];
    
    _magnetView = magnetView;
    [_magnetView setDraggable:NO];

    _magnetView.frame = _magnetPlaceholder.bounds;
    
    [_magnetPlaceholder addSubview:_magnetView];
}

- (void)layoutData
{
    
}

- (IBAction)doneClicked:(UIBarButtonItem *)sender
{
    [self notifyWillDismissWithNewWord:_currentWordInfo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addImageClicked:(UIButton *)sender
{
    UINewWordViewController *newWordViewController = [UINewWordViewController loadFromNib];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:newWordViewController];
    _popover.delegate = self;
    
    [_popover presentPopoverFromRect:_addImageButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
