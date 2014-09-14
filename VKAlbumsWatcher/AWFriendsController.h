//
//  AWFriendsController.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWFriendsController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic)NSString* friendId;
@end
