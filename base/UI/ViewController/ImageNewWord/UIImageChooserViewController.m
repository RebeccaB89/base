//
//  UIImageChooserViewController.m
//  base
//
//  Created by rebecca biaz on 10/25/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIImageChooserViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImageChooserViewController ()

- (void)notifyImageSelected:(NSString *)imagePath withImageName:(NSString *)imageName;

@end

@implementation UIImageChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_libraryButton setTitle:NLS(@"Library") forState:UIControlStateNormal];
    
    [_cameraButton setTitle:NLS(@"Camera") forState:UIControlStateNormal];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"wordImage"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _imagePaths = [NSMutableArray array];
    
    [self addFromDefaultImagesFolder];
    [self addFromImagesSaved];
    
    [self layoutData];
}

- (void)addFromDefaultImagesFolder
{
    NSArray *defaultImageChooserPaths = [[NSBundle mainBundle] pathsForResourcesOfType:@".png" inDirectory:@"DefaultImageChooser/."];
    
    for (NSString *defaultImage in defaultImageChooserPaths)
    {
        [_imagePaths addObject:defaultImage];
    }
}

- (void)addFromImagesSaved
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *added = [fm contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    for (NSString *defaultImage in added)
    {
        NSString *lowerPath = [defaultImage lowercaseString];
        if (!([lowerPath containsString:@"png"] || [lowerPath containsString:@"jpg"] || [lowerPath containsString:@"jpeg"]))
        {
            continue;
        }
        
        [_imagePaths addObject:[NSString stringWithFormat:@"%@/%@", documentsDirectory , defaultImage]];
    }
}

- (void)layoutData
{
    [_collectionView reloadData];
}

- (void)notifyImageSelected:(NSString *)imagePath withImageName:(NSString *)imageName
{
    if ([self.delegate respondsToSelector:@selector(imageChooserViewController:didSelectedImage:withImageName:)])
    {
        [self.delegate imageChooserViewController:self didSelectedImage:imagePath withImageName:imageName];
    }
}

- (BOOL)startCameraController
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    cameraUI.delegate = self;
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    
    //[self presentModalViewController:cameraUI animated:YES];
    return YES;
}

- (BOOL)startLibraryController
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    cameraUI.delegate = self;
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //        cameraUI.mediaTypes =
        //        [UIImagePickerController availableMediaTypesForSourceType:
        //         UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;
    
  //  [self presentModalViewController:cameraUI animated:YES];
    [self presentViewController:cameraUI animated:YES completion:nil];

    return YES;
}

- (IBAction)libraryButtonClicked:(UIButton *)sender
{
    [self startLibraryController];
}

- (IBAction)cameraButtonClicked:(UIButton *)sender
{
    [self startCameraController];
}

- (NSString *)imageNameFromImagePath:(NSString *)imagePath
{
    NSString *imageName = nil;

    NSArray *folders = [imagePath componentsSeparatedByString:@"/"];
    imageName = folders.lastObject;
    
    return imageName;
}

/* UICollectionView Delegates */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_imagePaths count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wordImage" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:36475];
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imageView.tag = 36475;
        [cell.contentView addSubview:imageView];
    }
    
//    imageView.image = IMAGE([_imagePaths objectAtIndex:indexPath.row]);
    imageView.image = [UIImage imageWithContentsOfFile:[_imagePaths objectAtIndex:indexPath.row ]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self notifyImageSelected:[_imagePaths objectAtIndex:indexPath.row] withImageName:[self imageNameFromImagePath:[_imagePaths objectAtIndex:indexPath.row]]];
}

/* End UICollectionView Delegates */

/* UIImagePickerController Delegates */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];

    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSString *fileName = [imageRep filename];
        if (!fileName)
        {
            fileName = @"currentImage";
        }
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];

        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"DefaultImageChooser"];
        
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          fileName ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        
        if (![_imagePaths containsObject:path])
        {
            [_imagePaths addObject:path];
        }
        
        [self notifyImageSelected:path withImageName:[self imageNameFromImagePath:path]];
        [self layoutData];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
}

/* End UIImagePickerController Delegates */

@end
