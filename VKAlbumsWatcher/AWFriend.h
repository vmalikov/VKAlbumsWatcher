//
//  AWFriend.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWFriend : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *friendId;
@property (strong, nonatomic) NSString *imageUrlString;

- (AWFriend*) initWithName:(NSString*)name friendId:(NSString*)friendId imageUrl:(NSString*)imageUrl;
- (NSURL*)imageUrl;
@end
