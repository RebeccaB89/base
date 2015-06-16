//
//  UIMouthFeatureView.h
//  base
//
//  Created by Rebecca Biaz on 5/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMouthView.h"

@interface UIMouthFeatureView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UIMouthViewDelegate>
{
    __weak IBOutlet UICollectionView *_mouthsCollectionView;
    
    NSArray *_mouths;
}

@end
