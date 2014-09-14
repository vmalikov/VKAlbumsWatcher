//
//  AWPhoto.h
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/8/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWPhoto : NSObject
@property (strong, nonatomic) NSString *photoId;
@property (strong, nonatomic) NSString *thumbUrlString;
@property (strong, nonatomic) NSString *fullImageUrlString;
@property NSInteger *thumbWidth;
@property NSInteger *thumbHeight;
-(AWPhoto*)initWithId:(NSString*)photoId thumbUrl:(NSString*)thumbUrlString fullImageUrl:(NSString*)fullImageUrl thumbWidth:(NSInteger*)width thumbHeight:(NSInteger*)height;
- (NSURL*)thumbUrl;
- (NSURL*)fullImageUrl;
@end
