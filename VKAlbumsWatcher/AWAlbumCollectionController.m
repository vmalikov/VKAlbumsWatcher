//
//  AWAlbumCollectionController.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/7/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWAlbumCollectionController.h"
#import "AWAlbumViewCell.h"
#import "AWParams.h"
#import "AWRequest.h"
#import "AWApi.h"
#import "AWAlbum.h"
#import "AWPhotosController.h"

@interface AWAlbumCollectionController ()
@property (strong, nonatomic) NSMutableArray* albums;
@end

@implementation AWAlbumCollectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _albums = [[NSMutableArray alloc] init];
    [self getFriendsAlbums];
}

- (void) usersGetCallback:(NSMutableArray*)albums
{
    _albums = albums;
    [self.collectionView reloadData];
}

-(void)getFriendsAlbums
{
    AWParams *params = [[AWParams alloc] init];

    [params addParam:@"owner_id" withValue:_friendId];
    [params addParam:@"need_covers" withValue:@"1"];
    [params addParam:@"need_system" withValue:@"1"];
    [params addParam:@"photo_sizes" withValue:@"1"];
    
    AWRequest *request = [[AWRequest alloc] initWithHTTPMethod:@"POST" methodName:PHOTOS_GET_ALBUMS params:params isHttps:NO];
    [AWApi execute:request usingBlock:^(NSMutableArray *albums)
     {
         [self usersGetCallback:albums];
     }];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [_albums count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"albumCell";
    
    AWAlbumViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSURL *imageUrl = [[_albums objectAtIndex:[indexPath row]] imageUrl];
    [cell.albumThumbnail setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AWAlbum *album = [_albums objectAtIndex:[indexPath row]];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AWPhotosController *controller = (AWPhotosController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"photosController"];
    controller.friendId = _friendId;
    controller.albumId = [album albumId];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
