//
//  UIDirectionView.h
//  base
//
//  Created by rebecca biaz on 10/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsManager.h"

@interface UIDirectionView : UIView
{
    UIView *_point;
}

@property (nonatomic, unsafe_unretained) BOOL directionEnabled;
@property (nonatomic, unsafe_unretained) DirectionReadType directionViewType;

@end
