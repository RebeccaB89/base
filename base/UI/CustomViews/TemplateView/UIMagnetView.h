//
//  UIMagnetView.h
//  base
//
//  Created by rebecca biaz on 7/22/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIDraggableView.h"

@interface UIMagnetView : UIDraggableView <NSCopying>
{
    __weak IBOutlet UIView *_mainView;
    
    __weak IBOutlet UIView *_throatView;
    
    __weak IBOutlet UIView *_vowelView;
    
    __weak IBOutlet UIView *_accesoryView;
    
    __weak IBOutlet UIView *_colorView;
    
    __weak IBOutlet UIView *_soundView;
}

+ (UIMagnetView *)magnetViewForSuperView:(UIView *)superView removeFromSuperView:(BOOL)removeFromSuperView inPoint:(CGPoint)point;
+ (void)breakMagnetView:(UIMagnetView *)magnetView;
+ (CGFloat)percentOfIntersectionWithRect:(CGRect)rect1 withRect2:(CGRect)rect2;

- (NSArray *)featureInfos;
- (void)setFeatureInfos:(NSArray *)featureInfos;

- (UIView *)mainView;
- (UIView *)throatView;
- (UIView *)vowelView;
- (UIView *)colorView;
- (UIView *)soundView;
- (UIView *)accesoryView;

@property (nonatomic, unsafe_unretained) BOOL selectionDisplay;

@property (nonatomic, unsafe_unretained) BOOL isSelected;

@end
