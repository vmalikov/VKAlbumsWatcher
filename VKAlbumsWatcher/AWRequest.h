//
//  AWRequest.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWParams.h"

static NSString * const FIRENDS_GET = @"friends.get";
static NSString * const PHOTOS_GET_ALBUMS = @"photos.getAlbums";
static NSString * const PHOTOS_GET = @"photos.get";

@interface AWRequest : NSObject

@property (weak, nonatomic) NSString *httpMethodName;
@property (weak, nonatomic) NSString *methodName;
@property (strong, nonatomic) AWParams *params;
@property (nonatomic) BOOL *isHttps;

- (AWRequest *) initWithHTTPMethod:(NSString *)httpMethodName methodName:(NSString *)methodName params:(AWParams *)params isHttps:(BOOL)isHttps;
@end
