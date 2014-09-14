//
//  AWFullScreenViewController.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/9/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "AWParams.h"

@interface AWFullScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) NSString* friendId;
@property (weak, nonatomic) NSString* photoUrl;

@end
