//
//  UIMagnetBoardViewController.m
//  base
//
//  Created by Rebecca Biaz on 5/13/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIMagnetBoardViewController.h"
#import "UIZoomableView.h"
#import "UIDraggableView.h"
#import "UIZoomableDraggableView.h"
#import "UIFeatureViewController.h"
#import "UIDictionnaryViewController.h"
#import "UITemplateView.h"
#import "UIMagnetView.h"
#import "UINewWordViewController.h"
#import "viewLogic.h"

@interface UIMagnetBoardViewController ()

@end

@implementation UIMagnetBoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIZoomableView *zoomableView = [[UIZoomableView alloc] initWithFrame:CGRectMake(self.view.centerX, self.view.centerY, 200, 200)];
//    zoomableView.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:zoomableView];
//    
//    UIDraggableView *draggableView = [[UIDraggableView alloc] initWithFrame:CGRectMake(self.view.centerY, self.view.centerX, 200, 200)];
//    draggableView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:draggableView];
//    
//    UIZoomableDraggableView *zoomableDraggableView = [[UIZoomableDraggableView alloc] initWithFrame:CGRectMake(100, 150, 200, 200)];
//    zoomableDraggableView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:zoomableDraggableView];
    
    [self layoutTopMenu];
    [self addTapGesture];
}

- (void)layoutTopMenu
{
    _topMenuView = [UITopMenuView loadFromNib];
    _topMenuView.frame = _topMenuPlaceHolder.bounds;
    _topMenuView.delegate = self;
    [_topMenuPlaceHolder addSubview:_topMenuView];
}

- (void)updateViewArchitecture
{
    NSMutableArray *subviewsSorted = [self.view.subviews mutableCopy];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES];
    [subviewsSorted sortUsingDescriptors:@[sort]];
    
    for (UIView *subView in subviewsSorted)
    {
        [self.view sendSubviewToBack:subView];
    }
}

- (void)addTapGesture
{
    if (!_tapGesture)
    {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHideTopMenu:)];
        _tapGesture.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:_tapGesture];
    }
   
    [self updateTapGesture];
}

- (void)updateTapGesture
{
    for (UIView *subView in self.view.subviews)
    {
        for (UIGestureRecognizer *recognizer in subView.gestureRecognizers)
        {
            if ([recognizer isKindOfClass:[UITapGestureRecognizer class]])
            {
                [_tapGesture requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}

- (void)showHideTopMenu:(id)sender
{
    CGFloat newConstant ;
    if (_topMenuConstraint.constant == 0)
    {
        newConstant = - _topMenuPlaceHolder.height;
    }
    else
    {
        newConstant = 0;
    }
    _topMenuConstraint.constant = newConstant;

    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLongClicked:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        UIView *senderView = sender.view;
        UIView *s = senderView.superview;
        UIView *ss= s.superview;
        if ([ss isKindOfClass:[UIMagnetView class]])
        {
            [UIMagnetView breakMagnetView:(UIMagnetView *)ss];
            [self updateViewArchitecture];
            return;
        }
        UIMagnetView *magnetView = [UIMagnetView magnetViewForSuperView:self.view removeFromSuperView:YES inPoint:sender.view.origin];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapClicked:)];
        tapGesture.numberOfTapsRequired = 2;
        [magnetView addGestureRecognizer:tapGesture];
        
        [self updateTapGesture];
    }
}

- (void)viewDidTapClicked:(UITapGestureRecognizer *)sender
{
    UIView *senderView = sender.view;
    
    for (UIView *subview in self.view.subviews)
    {
        if ([subview isKindOfClass:[UIMagnetView class]] && subview != senderView)
        {
            UIMagnetView *magnetView = (UIMagnetView *)subview;
            magnetView.isSelected = NO;
        }
    }
    
    if ([senderView isKindOfClass:[UIMagnetView class]])
    {
        UIMagnetView *magnetView = (UIMagnetView *)senderView;
        magnetView.isSelected = !magnetView.isSelected;
    }
}

- (UIMagnetView *)magnetSelected
{
    UIMagnetView *magnetView = nil;
    for (UIView *subview in self.view.subviews)
    {
        if ([subview isKindOfClass:[UIMagnetView class]] && [(UIMagnetView *)subview isSelected])
        {
            magnetView = (UIMagnetView *)subview ;
            
            break;
        }
    }
    
    return magnetView;
}

- (void)openShapesFromItem:(UIBarButtonItem *)item
{
    UIFeatureViewController *featureController = [UIFeatureViewController loadFromNib];
    featureController.delegate = self;
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:featureController];
    _popover.delegate = self;
    [_popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)openDictionnaryFromItem:(UIBarButtonItem *)item
{
    UIDictionnaryViewController *dictionnaryController = [UIDictionnaryViewController loadFromNib];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:dictionnaryController];
    _popover.delegate = self;
    [_popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)addNewWordClicked:(UIBarButtonItem *)item
{
    UIMagnetView *magnetViewSelected = [self magnetSelected];
    if (!magnetViewSelected)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NLS(@"No word selected") message:NLS(@"Please double click on word to select and add it") delegate:nil cancelButtonTitle:NLS(@"OK") otherButtonTitles:nil];
        
        [alert show];
        
        return;
    }
    
    UIMagnetView *copy = [magnetViewSelected copy];
//    copy.origin = CGPointMake(100, 100);
//
//    [self.view addSubview:copy];
    
    NSArray *featuresInfo = magnetViewSelected.featureInfos;
    
    UINewWordViewController *newWordViewController = [UINewWordViewController loadFromNib];
    
    newWordViewController.magnetView = copy;
    
    [[viewLogic sharedInstance] presentModalViewController:newWordViewController];
    
    //[[DictionnaryManager sharedInstance] addFeatureInfosToWords:featuresInfo];
}

/* UIFeatureViewController Delegates */

- (void)featureViewControlelr:(UIFeatureViewController *)featureViewController didSelectFeatureInfo:(FeatureInfo *)featureInfo
{
    [_chosenTemplateView removeFromSuperview];
    _chosenTemplateView = [UITemplateView loadFromNib];
    _chosenTemplateView.centerX = self.view.centerX;
    _chosenTemplateView.centerY = self.view.centerY;
    
    _chosenTemplateView.backgroundColor = [UIColor clearColor];
    _chosenTemplateView.featureInfo = featureInfo;
    _chosenTemplateView.tag = featureInfo.factorOrderView;
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidLongClicked:)];
    [_chosenTemplateView addGestureRecognizer:longGesture];
    
    [self.view addSubview:_chosenTemplateView];
    [self.view sendSubviewToBack:_chosenTemplateView];
    [self updateTapGesture];
    [self updateViewArchitecture];
}

/* End UIFeatureViewController Delegates */

/* UITopMenuView Delegates */

- (void)topMenuView:(UITopMenuView *)topMenuView didSelectMenuItem:(TopMenuType)topMenuType forMenuItem:(UIBarButtonItem *)item
{
    switch (topMenuType)
    {
        case topMenuTypeShapes:
            [self openShapesFromItem:item];
            break;
        case topMenuTypeDictionnary:
            [self openDictionnaryFromItem:item];
            break;
        case topMenuTypeNewWord:
            [self addNewWordClicked:item];
            break;

        default:
            break;
    }
}

/* End UITopMenuView Delegates */

/* UIPopoverController Delegates */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    _chosenTemplateView = nil;
}
/* End UIPopoverController Delegates */

@end
