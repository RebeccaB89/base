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
#import "UIDirectionView.h"
#import "UISettingsViewController.h"
#import "SettingsManager.h"
#import "GrammarLogic.h"

#define Direction_view_tag 65631

@interface UIMagnetBoardViewController ()

@end

@implementation UIMagnetBoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self layoutTopMenu];
    [self addTapGesture];
    [self layoutDirectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutDirectionView) name:SETTINGS_DIRECTION_CHANGE object:nil];
}

- (void)layoutDirectionView
{
    UIDirectionView *directionView = (UIDirectionView *)[self.view viewWithTag:Direction_view_tag];
    if (!directionView)
    {
        directionView = [[UIDirectionView alloc] init];
        directionView.tag = Direction_view_tag;
        [self.view addSubview:directionView];
        
        directionView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *directionViewBottomConstraint = [NSLayoutConstraint constraintWithItem:directionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-100];
        
        NSLayoutConstraint *directionViewTopConstraint = [NSLayoutConstraint constraintWithItem:directionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:300];
        
        NSDictionary *views = @{@"directionView" : directionView};
        
        NSArray *directionViewHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[directionView]-100-|" options:0 metrics:nil views:views];
        
        [self.view addConstraint:directionViewBottomConstraint];
        [self.view addConstraint:directionViewTopConstraint];
        [self.view addConstraints:directionViewHorizontalConstraint];
    }
    
    directionView.directionViewType = [SettingsManager sharedInstance].directionReadType;
    if ([SettingsManager sharedInstance].directionReadType == noDirectionViewType)
    {
        directionView.directionEnabled = NO;
    }
    else
    {
        directionView.directionEnabled = YES;
    }
    
    if ([SettingsManager sharedInstance].directionReadType == noFrame)
    {
        directionView.hidden = YES;
    }
    else
    {
        directionView.hidden = NO;
    }
    
    [self updateViewArchitecture];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //Because your app is only landscape, your view controller for the view in your
    // popover needs to support only landscape
    return UIInterfaceOrientationMaskLandscape;
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
        
        NSString *magnetViewRegex = [[GrammarLogic sharedInstance] regexForFeatureInfos:magnetView.featureInfos];
        BOOL isPermission = [[GrammarLogic sharedInstance] wordHavePermission:magnetViewRegex];
        
        if (!isPermission)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NLS(@"No permission") message:NLS(@"Sorry, this template is not good") delegate:nil cancelButtonTitle:NLS(@"OK") otherButtonTitles: nil];
            [alert show];
            
            [UIMagnetView breakMagnetView:(UIMagnetView *)magnetView];
            [self updateViewArchitecture];
        }
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapClicked:)];
        tapGesture.numberOfTapsRequired = 2;
        [magnetView addGestureRecognizer:tapGesture];
        
        [self updateTapGesture];
    }
}

- (void)viewDidTapClicked:(UITapGestureRecognizer *)sender
{
    UIView *senderView = sender.view;
    
//    for (UIView *subview in self.view.subviews)
//    {
//        if ([subview isKindOfClass:[UIMagnetView class]] && subview != senderView)
//        {
//            UIMagnetView *magnetView = (UIMagnetView *)subview;
//            magnetView.isSelected = NO;
//        }
//    }
//    
    if ([senderView isKindOfClass:[UIMagnetView class]])
    {
        UIMagnetView *magnetView = (UIMagnetView *)senderView;
        magnetView.isSelected = !magnetView.isSelected;
    }
}

- (NSArray *)magnetsSelected
{
    NSMutableArray *magnetsSelected = [NSMutableArray array];
    for (UIView *subview in self.view.subviews)
    {
        if ([subview isKindOfClass:[UIMagnetView class]] && [(UIMagnetView *)subview isSelected])
        {
            [magnetsSelected addObject:subview];
        }
    }
    
    return magnetsSelected;
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
    
    dictionnaryController.delegate = self;
    _popover = [[UIPopoverController alloc] initWithContentViewController:dictionnaryController];
    _popover.delegate = self;
    [_popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)openSettingsFromItem:(UIBarButtonItem *)item
{
    UISettingsViewController *settingsController = [UISettingsViewController loadFromNib];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:settingsController];
    _popover.delegate = self;
    [_popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)addNewWordClicked:(UIBarButtonItem *)item
{
    NSArray *magnetsSelected  = [self magnetsSelected];
    if (!magnetsSelected.count)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NLS(@"No word selected") message:NLS(@"Please double click on word to select and add it") delegate:nil cancelButtonTitle:NLS(@"OK") otherButtonTitles:nil];
        
        [alert show];
        
        return;
    }
    
    NSMutableArray *copys = [NSMutableArray array];
    
    for (UIMagnetView *magnetView in magnetsSelected)
    {
        [copys addObject:[magnetView copy]];
    }
    
//    NSArray *copys = [[NSArray alloc] initWithArray:magnetsSelected copyItems:YES];
    
    UINewWordViewController *newWordViewController = [UINewWordViewController loadFromNib];
    
    newWordViewController.magnetViews = magnetsSelected;
    newWordViewController.delegate = self;
    [[viewLogic sharedInstance] presentModalViewController:newWordViewController];
    
    //[[DictionnaryManager sharedInstance] addFeatureInfosToWords:featuresInfo];
}

- (void)saveWordInfo:(WordInfo *)wordInfo
{
    [[DictionnaryManager sharedInstance] addWordInfo:wordInfo];
}

/* UINewWordViewController Delegates */

-(void)newWordViewController:(UINewWordViewController *)newWordViewController willDismissWithNewWord:(WordInfo *)wordInfo
{
    WordInfo *copy = [wordInfo copy];
    [self saveWordInfo:copy];
}

/* End UINewWordViewController Delegates */

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
        case topMenuTypeSettings:
            [self openSettingsFromItem:item];
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
    _wordChoosenView = nil;
}
/* End UIPopoverController Delegates */

/* UIDictionnaryViewController Delegates */

- (void)dictionnaryViewController:(UIDictionnaryViewController *)dictionnaryViewController didSelectWord:(WordInfo *)word
{
    [_wordChoosenView removeFromSuperview];
    _wordChoosenView = [UIWordView loadFromNib];
    _wordChoosenView.centerX = self.view.centerX;
    _wordChoosenView.centerY = self.view.centerY;
    
    _wordChoosenView.backgroundColor = [UIColor clearColor];
    _wordChoosenView.wordInfo = word;
    
    [self.view addSubview:_wordChoosenView];
    [self.view sendSubviewToBack:_wordChoosenView];
    [self updateViewArchitecture];
}

/* End UIDictionnaryViewController Delegates */


@end
