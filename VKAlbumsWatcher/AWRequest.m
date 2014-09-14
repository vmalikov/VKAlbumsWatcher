//
//  AWRequest.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWRequest.h"

@implementation AWRequest

- (AWRequest *) initWithHTTPMethod:(NSString *)httpMethodName methodName:(NSString *)methodName params:(AWParams *)params isHttps:(BOOL)isHttps{
    self = [super init];
    
    _httpMethodName = httpMethodName;
    _methodName = methodName;
    _params = params;
    _isHttps = &isHttps;
    
    return self;
}

@end
