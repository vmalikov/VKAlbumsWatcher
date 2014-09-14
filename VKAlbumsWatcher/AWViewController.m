//
//  AWViewController.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "VKPermissions.h"
#import "VKSdk.h"
#import "AWViewController.h"
#import "AWParams.h"
#import "AWFriendsController.h"


static NSString *const TOKEN_KEY = @"my_application_access_token";
static NSArray  * SCOPE = nil;

@interface AWViewController ()

@end

@implementation AWViewController

- (void)viewDidLoad
{
    SCOPE = @[VK_PER_FRIENDS, VK_PER_PHOTOS];
	[super viewDidLoad];
    
	[VKSdk initializeWithDelegate: self andAppId:@"4541621"];
    
    if ([VKSdk wakeUpSession]) {
        [self openFriendsController];
    }

}

- (IBAction)login:(id)sender {
    [VKSdk authorize:SCOPE revokeAccess:YES];
}

- (void)openFriendsController {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AWFriendsController *controller = (AWFriendsController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"friendsListController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
	VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
	[vc presentIn:self];
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
	[self login:nil];
}

- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken {
    [[NSUserDefaults standardUserDefaults] setObject:[newToken accessToken] forKey:ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:[newToken userId] forKey:CURRENT_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self openFriendsController];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
	[self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkAcceptedUserToken:(VKAccessToken *)token {
    [self openFriendsController];
}
- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
	[[[UIAlertView alloc] initWithTitle:nil message:@"Access denied" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

@end
