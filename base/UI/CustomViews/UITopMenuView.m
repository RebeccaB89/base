//
//  UITopMenuView.m
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UITopMenuView.h"

@implementation UITopMenuView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [_menuToolbar setBackgroundImage:[UIImage new]
                  forToolbarPosition:UIBarPositionAny
                          barMetrics:UIBarMetricsDefault];
    
    [_menuToolbar setShadowImage:[UIImage new]
              forToolbarPosition:UIToolbarPositionAny];
    
    _shapeItem.tag = topMenuTypeShapes;
    _shapeItem.title = NLS(@"SHAPES");
    
    _newWordItem.tag = topMenuTypeNewWord;
    _newWordItem.title = NLS(@"ADD NEW WORD");
    
    _dictionnaryItem.tag = topMenuTypeDictionnary;
    _dictionnaryItem.title = NLS(@"DICTIONNARY");
    
    _settingsItem.tag = topMenuTypeSettings;
    _settingsItem.title = NLS(@"SETTINGS");
}

- (void)notifyMenuItem:(UIBarButtonItem *)item
{
    if ([self.delegate respondsToSelector:@selector(topMenuView:didSelectMenuItem:forMenuItem:)])
    {
        [_delegate topMenuView:self didSelectMenuItem:item.tag forMenuItem:item];
    }
}

- (IBAction)menuItemClicked:(UIBarButtonItem *)sender
{
    [self notifyMenuItem:sender];
}

@end
