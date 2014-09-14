//
//  AWPhotosController.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/8/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWPhotosController.h"
#import "AWParams.h"
#import "AWRequest.h"
#import "AWApi.h"
#import "AWPhotoCell.h"
#import "AWPhoto.h"
#import "AWFullScreenViewController.h"

@interface AWPhotosController ()
@property (strong, nonatomic) NSMutableArray* photos;
@property (strong, nonatomic) UIImageView *temptumb;
@property (strong, nonatomic) UIImageView *fullview;
@end

@implementation AWPhotosController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _photos = [[NSMutableArray alloc] init];
    [self getAlbumPhotos];
}

- (void) usersGetCallback:(NSMutableArray*)photos
{
    _photos = photos;
    [self.collectionView reloadData];
}

-(void)getAlbumPhotos
{
    AWParams *params = [[AWParams alloc] init];
    [params addParam:@"owner_id" withValue:_friendId];
    [params addParam:@"album_id" withValue:_albumId];
    [params addParam:@"photo_sizes" withValue:@"1"];
    
    AWRequest *request = [[AWRequest alloc] initWithHTTPMethod:@"POST" methodName:PHOTOS_GET params:params isHttps:NO];
    [AWApi execute:request usingBlock:^(NSMutableArray *photos)
     {
         [self usersGetCallback:photos];
     }];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [_photos count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"photoCell";
    
    AWPhotoCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSURL *imageUrl = [[_photos objectAtIndex:[indexPath row]] thumbUrl];
    [cell.photoImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AWPhoto *photo = [_photos objectAtIndex:[indexPath row]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AWFullScreenViewController *controller = (AWFullScreenViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"fullscreencontroller"];
    
    controller.friendId = [[NSUserDefaults standardUserDefaults] objectForKey:FRIEND_ID];
    controller.photoUrl = [NSString stringWithFormat:@"%@", [photo fullImageUrl]];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
