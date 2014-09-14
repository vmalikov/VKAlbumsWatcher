//
//  AWFullScreenViewController.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/9/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWFullScreenViewController.h"

@interface AWFullScreenViewController ()

@end

@implementation AWFullScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.photo setImageWithURL:[NSURL URLWithString:_photoUrl] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
}
@end
