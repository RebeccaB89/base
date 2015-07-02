//
//  UIZoomableDraggableView.h
//  base
//
//  Created by Rebecca Biaz on 5/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Zoomable.h"
#import "UIView+draggable.h"

@interface UIZoomableDraggableView : UIView

@property (nonatomic, unsafe_unretained) BOOL zoomableEnabled;
@property (nonatomic, unsafe_unretained) BOOL draggableEnabled;

@end
