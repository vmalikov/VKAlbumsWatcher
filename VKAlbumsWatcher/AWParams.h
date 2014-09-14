//
//  AWParams.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const ACCESS_TOKEN = @"ACCESS_TOKEN";
static NSString * const CURRENT_USER_ID = @"CURRENT_USER_ID";
static NSString * const FRIEND_ID = @"FRIEND_ID";
static NSString * const ALBUM_ID = @"ALBUM_ID";
static NSString * const PHOTO_URL = @"PHOTO_URL";

@interface AWParams : NSObject

- (void) addParam:(id)key withValue:(id <NSCopying>)value;
- (NSString *) paramsAsString;

@end
