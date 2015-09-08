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
#import "UITemplateView.h"
#import "UIMagnetView.h"

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        CGPoint center = senderView.center;
        UIMagnetView *magnetView = [UIMagnetView magnetViewForSuperView:self.view removeFromSuperView:YES inPoint:sender.view.origin];
    }
//    UIView *senderView = sender.view;
//    int i = 0;
//    i++;
//    UIMagnetView *magnetView = [UIMagnetView magnetViewForSuperView:self.view removeFromSuperView:YES inPoint:sender.view.center];
 //   [self updateTapGesture];
}

- (void)openShapesFromItem:(UIBarButtonItem *)item
{
    UIFeatureViewController *featureController = [UIFeatureViewController loadFromNib];
    featureController.delegate = self;
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:featureController];
    _popover.delegate = self;
    [_popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidLongClicked:)];
    [_chosenTemplateView addGestureRecognizer:longGesture];
    
    [self.view addSubview:_chosenTemplateView];
    [self.view sendSubviewToBack:_chosenTemplateView];
    [self updateTapGesture];
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
