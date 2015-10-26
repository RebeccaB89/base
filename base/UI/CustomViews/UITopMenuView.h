//
//  UITopMenuView.h
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger
{
    topMenuTypeShapes,
    topMenuTypeNewWord,
    topMenuTypeDictionnary,
    topMenuTypeSettings
} TopMenuType;

@class UITopMenuView;

@protocol UITopMenuViewDelegate <NSObject>

- (void)topMenuView:(UITopMenuView *)topMenuView didSelectMenuItem:(TopMenuType)topMenuType forMenuItem:(UIBarButtonItem *)item;

@end

@interface UITopMenuView : UIView
{
    __weak IBOutlet UIToolbar *_menuToolbar;
    
    __weak IBOutlet UIBarButtonItem *_shapeItem;
    
    __weak IBOutlet UIBarButtonItem *_newWordItem;
    __weak IBOutlet UIBarButtonItem *_dictionnaryItem;
    __weak IBOutlet UIBarButtonItem *_settingsItem;
}

- (IBAction)menuItemClicked:(UIBarButtonItem *)sender;

@property (nonatomic, weak) id<UITopMenuViewDelegate> delegate;

@end
