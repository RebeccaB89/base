//
//  UIDictionnaryViewController.m
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIDictionnaryViewController.h"
#import "UIDictionnaryTableViewCell.h"
#import "viewLogic.h"

@interface UIDictionnaryViewController ()

@end

@implementation UIDictionnaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"UIDictionnaryTableViewCell" bundle:nil] forCellReuseIdentifier:@"UIDictionnaryTableViewCell"];
    
    [_addNewWordButton setTitle:NLS(@"Add new word") forState:UIControlStateNormal];
    
    [self reloadData];
    [self layoutData];
}

- (void)reloadData
{
    _words = [[DictionnaryManager sharedInstance] words];
}

- (void)layoutData
{
    [_tableView reloadData];
}

- (void)notifyWordSelected:(WordInfo *)word
{
    if ([self.delegate respondsToSelector:@selector(dictionnaryViewController:didSelectWord:)])
    {
        [_delegate dictionnaryViewController:self
                               didSelectWord:word];
    }
}

/* UITableView Delegates */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIDictionnaryTableViewCell * dictionaryCell = [tableView dequeueReusableCellWithIdentifier:@"UIDictionnaryTableViewCell"];
    
    dictionaryCell.wordInfo = [_words objectAtIndex:indexPath.row];
    
    return dictionaryCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIDictionnaryTableViewCell *dictionaryCell = (UIDictionnaryTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [self notifyWordSelected:dictionaryCell.wordInfo];
}

/* End UITableView Delegates */

@end
