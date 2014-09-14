//
//  AWParams.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWParams.h"

static NSString * const VERSION = @"&v=5.24";

@interface AWParams()

@property (strong, nonatomic) NSMutableDictionary *bundle;

@end

@implementation AWParams

- (AWParams*) init
{
    self = [super init];
    self.bundle = [[NSMutableDictionary alloc] init];
    return self;
}

- (void) addParam:(id)key withValue:(id <NSCopying>)value
{
    if(_bundle) {
        [_bundle setObject:value forKey:key];
    }
}

- (NSString *) paramsAsString
{
    NSMutableString *str = [[NSMutableString alloc] init];
    NSEnumerator *keyEnum = [_bundle keyEnumerator];
    
    if(_bundle) {
        NSString *key = (NSString*) [keyEnum nextObject];
        [str appendString:[NSString stringWithFormat:@"%@=%@", key, [_bundle objectForKey:key]]];

        [str appendString:VERSION];
        
        key = (NSString*) [keyEnum nextObject];
        while (key) {
            [str appendString:[NSString stringWithFormat:@"&%@=%@", key, [_bundle objectForKey:key]]];
            key = (NSString*) [keyEnum nextObject];
        }
        
//        NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
//        if(accessToken) {
//            [str appendString:[NSString stringWithFormat:@"&access_token=%@", accessToken]];
//        }
    }
    return str;
}
@end
