//
//  AWFriendsController.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWFriendsController.h"
#import "AWRequest.h"
#import "AWParams.h"
#import "AWApi.h"
#import "AWFriendCell.h"
#import "AWFriend.h"
#import "AWAlbumCollectionController.h"
#import "VKSdk.h"

@interface AWFriendsController ()
@property (strong, nonatomic) NSMutableArray* friends;
@end

@implementation AWFriendsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(home:)];
    self.navigationItem.leftBarButtonItem=newBackButton;
    
    self.tableView.delegate = self;
    _friends = [[NSMutableArray alloc] init];
    [self getFriends];
}

-(void)home:(UIBarButtonItem *)sender {
    [VKSdk forceLogout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) usersGetCallback:(NSMutableArray*)friends
{
    _friends = friends;
    [self.tableView reloadData];
}

-(void) getFriends
{
    AWParams *params = [[AWParams alloc] init];
    
    NSString *curUserId = [[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_USER_ID];
    [params addParam:@"user_id" withValue:[NSString stringWithFormat:@"%@", curUserId]];
    [params addParam:@"order" withValue:@"name"];
    [params addParam:@"fields" withValue:@"photo_100"];
    
    AWRequest *request = [[AWRequest alloc] initWithHTTPMethod:@"POST" methodName:FIRENDS_GET params:params isHttps:NO];
    [AWApi execute:request usingBlock:^(NSMutableArray *friends)
     {
         [self usersGetCallback:friends];
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"friendCellIdentifier";
    
    AWFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[AWFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    AWFriend *friend = _friends[[indexPath row]];
    cell.friendNameLabel.text = [friend name];
    [cell.friendImageView setImageWithURL:[friend imageUrl] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AWFriend *friend = [_friends objectAtIndex:[indexPath row]];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AWAlbumCollectionController *controller = (AWAlbumCollectionController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"albumsController"];
    controller.friendId = [friend friendId];
    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
