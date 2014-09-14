//
//  AWApi.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWApi.h"
#import "AWFriend.h"
#import "AWResponseParser.h"

static NSString * const BASE_URL = @"https//api.vk.com/method/";
static NSString * const BASE_URL_S = @"https://api.vk.com/method/";
static NSString * const QUESTION_SIGN = @"?";

@interface AWApi()

@end

@implementation AWApi

+ (void) execute:(AWRequest *)request usingBlock: (void (^)(NSMutableArray* friends))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *baseUrl = ([request isHttps]) ? BASE_URL_S : BASE_URL;
        NSString *urlString;
        NSString *strParams = [[request params] paramsAsString];
        if(strParams) {
            urlString = [NSString stringWithFormat: @"%@%@%@%@", baseUrl, [request methodName], QUESTION_SIGN, strParams];
        } else {
            urlString = [NSString stringWithFormat: @"%@%@", baseUrl, [request methodName]];
        }
        
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
//        NSLog(@"urlRequest: %@", urlRequest);
        
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        
        NSMutableArray *friends = nil;
        
        if (!error) {
            friends = [AWResponseParser parseData:data withRequest:request];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(friends);
        });
        
    });
}

@end
