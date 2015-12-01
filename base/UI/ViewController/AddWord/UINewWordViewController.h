//
//  UINewWordViewController.h
//  base
//
//  Created by rebecca biaz on 10/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordInfo.h"
#import "UIMagnetView.h"
#import "UIImageChooserViewController.h"
#import "OHStackView.h"

@class UINewWordViewController;

@protocol UINewWordViewControllerDelegate <NSObject>

- (void)newWordViewController:(UINewWordViewController *)newWordViewController willDismissWithNewWord:(WordInfo *)wordInfo;

@end

@interface UINewWordViewController : UIViewController <UIPopoverControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIImageChooserViewControllerDelegate>
{
    OHStackView *_stackView;
    
    __weak IBOutlet UIView *_stackPlaceholder;
    
    __weak IBOutlet NSLayoutConstraint *_magnetsViewWidthConstraint;
    __weak IBOutlet UITextField *_titleTextField;
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UIButton *_addImageButton;
    
    UIPopoverController *_popover;
    
    WordInfo *_currentWordInfo;
}

- (IBAction)doneClicked:(UIBarButtonItem *)sender;
- (IBAction)addImageClicked:(UIButton *)sender;

@property (nonatomic, strong) NSArray *magnetViews;

@property (nonatomic, weak) id <UINewWordViewControllerDelegate> delegate;

@end
