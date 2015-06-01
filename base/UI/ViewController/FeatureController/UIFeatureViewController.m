//
//  UIFeatureViewController.m
//  base
//
//  Created by Rebecca Biaz on 5/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIFeatureViewController.h"
#import "UIFeatureTableViewCell.h"
#import "UIMouthFeatureView.h"
#import "FeaturesManager.h"

@interface UIFeatureViewController ()

@end

@implementation UIFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"UIFeatureTableViewCell" bundle:nil] forCellReuseIdentifier:@"UIFeatureTableViewCell"];
    
    [self reloadData];
    [self layoutData];
}

- (void)reloadData
{
    _featureArray = [[FeaturesManager sharedInstance] features];
}

- (void)layoutData
{
    [_tableView reloadData];
}

- (void)openSubMenu:(NSIndexPath *)indexPath animated:(BOOL)animated
{
    _subMenuView = [UIMouthFeatureView loadFromNib];
    
    [_tableView beginUpdates];
    NSIndexPath* changeRow = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
    _subMenuIndexPath = changeRow;
    
    NSArray* rowsToReload = [NSArray arrayWithObjects:changeRow, nil];
    [_tableView insertRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationTop];
    [_tableView endUpdates];
}

- (void)closeSubMenu:(NSIndexPath *)indexPath
{
    [_tableView beginUpdates];
    NSIndexPath* changeRow = [NSIndexPath indexPathForRow:_subMenuIndexPath.row inSection:0];
    
    [_subMenuView removeFromSuperview];
    _subMenuView = nil;
    
    NSArray* rowsToReload = [NSArray arrayWithObjects:changeRow, nil];
    [_tableView deleteRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationTop];
    [_tableView endUpdates];
}

- (void)cellDidSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    if (_subMenuView && (_subMenuIndexPath.row ) == indexPath.row )
    {
        return;
    }
    else if (_subMenuView && (_subMenuIndexPath.row -1) == indexPath.row )
    {
        [_tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self closeSubMenu:indexPath];
    }
    else
    {
            NSIndexPath *realIndexPath = indexPath;
            if (_subMenuView) //close first submenu to open other.
            {
                if (_subMenuIndexPath.row <= indexPath.row)
                {
                    realIndexPath = [NSIndexPath indexPathForRow:indexPath.row -1 inSection:_subMenuIndexPath.section]; //we close the subMenu so we need remove 1 to index.
                }
                
                [_tableView deselectRowAtIndexPath:_subMenuIndexPath animated:NO];

                [self closeSubMenu:[NSIndexPath indexPathForRow:_subMenuIndexPath.row -1 inSection:_subMenuIndexPath.section]];
            }
            
            UIFeatureTableViewCell *cell = (UIFeatureTableViewCell *)[_tableView cellForRowAtIndexPath:realIndexPath];
            
            cell.selected = YES;
            [self openSubMenu:realIndexPath animated:YES];
    }
}

/* UITableView Delegates */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int subMenuSum = 0;
    if (_subMenuView)
    {
        subMenuSum++;
    }
    int count = (int)[_featureArray count] + subMenuSum;

    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_subMenuView && _subMenuIndexPath.row == indexPath.row)
    {
        return 300;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFeatureTableViewCell *featureCell = [tableView dequeueReusableCellWithIdentifier:@"UIFeatureTableViewCell"];
    NSInteger index = indexPath.row;
    
    if (_subMenuView)
    {
        if (_subMenuIndexPath.row > indexPath.row)
        {
            featureCell.featureInfo = [_featureArray objectAtIndex:index];
        }
        else if (_subMenuIndexPath.row == indexPath.row)
        {
            static NSString *CellIdentifier = @"Cell";
            UITableViewCell *standartCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (standartCell == nil)
            {
                standartCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            standartCell.clipsToBounds = YES;
            standartCell.backgroundColor = [UIColor clearColor];
            
            [_subMenuView removeFromSuperview];
            [standartCell.contentView addSubview:_subMenuView];
            standartCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return standartCell;
        }
        else
        {
            featureCell.featureInfo = [_featureArray objectAtIndex:index - 1];
        }
    }
    else
    {
        featureCell.featureInfo = [_featureArray objectAtIndex:index ];
    }

    return featureCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self cellDidSelectedAtIndexPath:indexPath];
}

/* End UITableView Delegates */

@end
