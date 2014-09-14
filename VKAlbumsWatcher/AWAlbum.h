//
//  AWAlbum.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/7/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWAlbum : NSObject
@property (strong, nonatomic) NSString *albumTitle;
@property (strong, nonatomic) NSString *albumId;
@property (strong, nonatomic) NSString *thumbUrlString;
@property NSInteger *thumbWidth;
@property NSInteger *thumbHeight;

- (AWAlbum*) initWithTitle:(NSString*)albumTitle albumId:(NSString*)albumId thumbUrl:(NSString*)thumbUrl thumbWidht:(NSInteger)thumbWidth thumbHeight:(NSInteger)thumbHeight;
- (NSURL*)imageUrl;
@end
