//
//  UIView+Zoomable.h
//  base
//
//  Created by Rebecca Biaz on 5/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Zoomable)

- (void)initializeZoomableView;
- (CGSize)smallSize;
- (CGSize)bigSize;
- (BOOL)isSmall;
- (void)onDoubleTap:(UITapGestureRecognizer *)sender;
- (void)setZoomable:(BOOL)zoomable;

@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) CGSize defaultSize;

@end
