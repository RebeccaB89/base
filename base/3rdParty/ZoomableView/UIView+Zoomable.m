//
//  UIView+Zoomable.m
//  base
//
//  Created by Rebecca Biaz on 5/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIView+Zoomable.h"
#import <objc/runtime.h>

@implementation UIView (Zoomable)

- (void)initializeZoomableView
{
    if (!self.tapGestureRecognizer)
    {
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
        self.tapGestureRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:self.tapGestureRecognizer];
        
        self.defaultSize = self.size;
    }
}

- (void)setTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    objc_setAssociatedObject(self, @selector(onDoubleTap:), tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)cagingArea
{
    NSValue *cagingAreaValue = objc_getAssociatedObject(self, @selector(cagingArea));
    return [cagingAreaValue CGRectValue];
}

- (void)setDefaultSize:(CGSize)defaultSize
{
    NSValue *defaultSizeValue = [NSValue valueWithCGSize:defaultSize];
    objc_setAssociatedObject(self, @selector(defaultSize), defaultSizeValue, OBJC_ASSOCIATION_RETAIN);
}

- (CGSize)defaultSize
{
    NSValue *defaultSizeValue = objc_getAssociatedObject(self, @selector(defaultSize));
    return [defaultSizeValue CGSizeValue];
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    return objc_getAssociatedObject(self, @selector(onDoubleTap:));
}

- (CGSize)smallSize
{
    return CGSizeMake(self.defaultSize.width/2, self.defaultSize.height/2);
}

- (CGSize)bigSize
{
    return self.defaultSize;
}

- (BOOL)isSmall
{
    if (self.height == [self smallSize].height)
    {
        return YES;
    }
    return NO;
}

- (void)setZoomable:(BOOL)zoomable
{
    [self.tapGestureRecognizer setEnabled:zoomable];
}

- (void)onDoubleTap:(UITapGestureRecognizer *)sender
{
    CGSize newSize;
    CGPoint centerPoint = self.center;
    if ([self isSmall])
    {
        newSize = [self bigSize];
    }
    else
    {
        newSize = [self smallSize];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.size = newSize;
        self.center = centerPoint;
    }];
}

@end
