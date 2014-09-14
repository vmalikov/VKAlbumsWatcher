//
//  AWAlbum.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/7/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWAlbum.h"

@implementation AWAlbum
- (AWAlbum*) initWithTitle:(NSString*)albumTitle albumId:(NSString*)albumId thumbUrl:(NSString*)thumbUrl thumbWidht:(NSInteger)thumbWidth thumbHeight:(NSInteger)thumbHeight
{
    self = [super init];
    
    if(self) {
        _albumId = albumId;
        _albumTitle = albumTitle;
        _thumbUrlString = thumbUrl;
        _thumbWidth = &thumbWidth;
        _thumbHeight = &thumbHeight;
    }
    
    return self;
}

- (NSURL*)imageUrl
{
    return [NSURL URLWithString:_thumbUrlString];
}
@end
