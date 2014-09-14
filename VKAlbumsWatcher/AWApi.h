//
//  AWApi.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWRequest.h"

@interface AWApi : NSObject

+ (void) execute:(AWRequest *)request usingBlock: (void (^)(NSMutableArray*))callback;

@end
