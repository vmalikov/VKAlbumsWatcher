//
//  AWFriend.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWFriend.h"

@implementation AWFriend
- (AWFriend*)initWithName:(NSString *)name friendId:(NSString *)friendId imageUrl:(NSString *)imageUrl
{
    self = [super init];
    
    _name = name;
    _friendId = friendId;
    _imageUrlString = imageUrl;
    
    return self;
}
- (NSURL*)imageUrl
{
    return [NSURL URLWithString:_imageUrlString];
}
@end
