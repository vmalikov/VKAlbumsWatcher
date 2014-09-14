//
//  AWPhoto.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/8/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWPhoto.h"

@implementation AWPhoto
-(AWPhoto*)initWithId:(NSString*)photoId thumbUrl:(NSString*)thumbUrlString fullImageUrl:(NSString*)fullImageUrl thumbWidth:(NSInteger*)width thumbHeight:(NSInteger*)height
{
    self = [super init];
    
    if(self) {
        _photoId = photoId;
        _thumbUrlString = thumbUrlString;
        _thumbWidth = width;
        _thumbHeight = height;
        _fullImageUrlString = fullImageUrl;
    }
    
    return self;
}

- (NSURL*)thumbUrl
{
    return [NSURL URLWithString:_thumbUrlString];
}

- (NSURL*)fullImageUrl
{
    return [NSURL URLWithString:_fullImageUrlString];
}
@end
