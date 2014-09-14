//
//  AWResponseParser.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWResponseParser.h"
#import "AWFriend.h"
#import "AWRequest.h"
#import "AWAlbum.h"
#import "AWPhoto.h"

static NSString * const RESPONSE_STR = @"response";
static NSString * const ITEMS_STR = @"items";
static NSString * const PHOTO_STR = @"photo_100";
static NSString * const ID_STR = @"id";
static NSString * const FIRST_NAME_STR = @"first_name";
static NSString * const LAST_NAME_STR = @"last_name";
static NSString * const COUNT_STR = @"count";
static NSString * const TITLE = @"title";

static NSString * const THUMBNAIL_SRC = @"thumb_src";
static NSString * const SRC_STR = @"src";
static NSString * const SIZES_STR = @"sizes";
static NSString * const TYPE_STR = @"type";
static NSString * const NEED_TYPE = @"m";
static NSString * const WIDTH_STR = @"width";
static NSString * const HEIGHT_STR = @"height";

static NSString * const DEFAULT_NEED_TYPE_FOR_FULLSCREEN = @"y";
static NSString * const NEED_TYPE_FOR_FULLSCREEN = @"m";



@implementation AWResponseParser
+ (NSMutableArray*) parseData:(NSData*)data withRequest:(AWRequest*)request

{
    if([[request methodName]isEqualToString:FIRENDS_GET]) {
        return [AWResponseParser parseFriendsList:data];
    } else if([[request methodName]isEqualToString:PHOTOS_GET_ALBUMS]) {
        return [AWResponseParser parseAlbumsList:data];
    } else if([[request methodName]isEqualToString:PHOTOS_GET]) {
        return [AWResponseParser parsePhotosList:data];
    } else {
        return nil;
    }
}

+(NSMutableArray*) parseFriendsList:(NSData*)data
{
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *dict = jsonDictionary[RESPONSE_STR];
    
    NSMutableArray *friends = [[NSMutableArray alloc] init];
    
    NSDictionary *items = dict[ITEMS_STR];
    for(NSDictionary *item in items) {
        NSString *name = [NSString stringWithFormat:@"%@ %@", item[FIRST_NAME_STR], item[LAST_NAME_STR]];
        NSString *friendId = item[ID_STR];
        NSString *imageUrl = item[PHOTO_STR];
        AWFriend *friend = [[AWFriend alloc] initWithName:name friendId:friendId imageUrl:imageUrl];
        [friends addObject:friend];
    }
//    NSString *count = dict[COUNT_STR];
    return friends;

}

+(NSMutableArray*) parseAlbumsList:(NSData*)data
{
    NSMutableArray *albums = [[NSMutableArray alloc] init];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *dict = jsonDictionary[RESPONSE_STR];
    
    NSDictionary *items = dict[ITEMS_STR];
    for(NSDictionary *item in items) {
        NSString *albumId = item[ID_STR];
        NSString *title = item[TITLE];
        NSString *thumb = nil;
        NSInteger thumbWidth = -1;
        NSInteger thumbHeight = -1;
        NSDictionary *sizes = item[SIZES_STR];
        for(NSDictionary *sizesItem in sizes) {
            NSString *typeStr = sizesItem[TYPE_STR];
            if([typeStr isEqualToString:NEED_TYPE]) {
                thumb = sizesItem[SRC_STR];
                thumbWidth = [sizesItem[WIDTH_STR] intValue];
                thumbHeight = [sizesItem[HEIGHT_STR] intValue];
            }
        }
        if(!thumb) {
            thumb = item[THUMBNAIL_SRC];
        }
        
        AWAlbum *album = [[AWAlbum alloc] initWithTitle:title albumId:albumId thumbUrl:thumb thumbWidht:thumbWidth thumbHeight:thumbHeight];
        [albums addObject:album];
    }
//    NSString *count = dict[COUNT_STR];
    return albums;
}

+(NSMutableArray*) parsePhotosList:(NSData*)data
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *dict = jsonDictionary[RESPONSE_STR];

    NSDictionary *items = dict[ITEMS_STR];
    for(NSDictionary *item in items) {
        NSString *photoId = item[ID_STR];
        NSString *thumb = nil;
        NSString *fullImageUrl = nil;
        NSInteger thumbWidth = -1;
        NSInteger thumbHeight = -1;
        NSDictionary *sizes = item[SIZES_STR];
        
        for(NSDictionary *sizesItem in sizes) {
            NSString *typeStr = sizesItem[TYPE_STR];
            if([typeStr isEqualToString:NEED_TYPE]) {
                thumb = sizesItem[SRC_STR];
                thumbWidth = [sizesItem[WIDTH_STR] intValue];
                thumbHeight = [sizesItem[HEIGHT_STR] intValue];
            }
        }

        fullImageUrl = [AWResponseParser getFullImageUrlStringForType:DEFAULT_NEED_TYPE_FOR_FULLSCREEN inSizesArray:sizes];
        
        if(!fullImageUrl) {
            fullImageUrl = [AWResponseParser getFullImageUrlStringForType:NEED_TYPE_FOR_FULLSCREEN inSizesArray:sizes];
        }
        
        AWPhoto *photo = [[AWPhoto alloc] initWithId:photoId thumbUrl:thumb fullImageUrl:fullImageUrl thumbWidth:&thumbWidth thumbHeight:&thumbHeight];
        [photos addObject:photo];
    }
//    NSString *count = dict[COUNT_STR];
    return photos;
    
}

+(NSString*)getFullImageUrlStringForType:(NSString*)type inSizesArray:(NSDictionary*)sizes
{
    for(NSDictionary *sizesItem in sizes) {
        NSString *typeStr = sizesItem[TYPE_STR];
        if([typeStr isEqualToString:type]) {
            return sizesItem[SRC_STR];
        }
    }
    return  nil;
}

@end
