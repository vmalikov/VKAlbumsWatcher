//
//  AWResponseParser.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWRequest.h"

@interface AWResponseParser : NSObject

+ (NSMutableArray*) parseData:(NSData*)data withRequest:(AWRequest*)request;

@end
