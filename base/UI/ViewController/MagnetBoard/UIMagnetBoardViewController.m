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

@interface UIMagnetBoardViewController ()

@end

@implementation UIMagnetBoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIZoomableView *zoomableView = [[UIZoomableView alloc] initWithFrame:CGRectMake(self.view.centerX, self.view.centerY, 200, 200)];
    zoomableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:zoomableView];
    
    UIDraggableView *draggableView = [[UIDraggableView alloc] initWithFrame:CGRectMake(self.view.centerY, self.view.centerX, 200, 200)];
    draggableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:draggableView];
    
    UIZoomableDraggableView *zoomableDraggableView = [[UIZoomableDraggableView alloc] initWithFrame:CGRectMake(100, 150, 200, 200)];
    zoomableDraggableView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:zoomableDraggableView];
    
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

- (void)openShapesFromItem:(UIBarButtonItem *)item
{
    UIFeatureViewController *featureController = [UIFeatureViewController loadFromNib];
    
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:featureController];
    
    [popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

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
@end
