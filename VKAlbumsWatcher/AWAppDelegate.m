//
//  AWAppDelegate.m
//  VKAlbumsWatcher
//
//  Created by vmalikov on 9/6/14.
//  Copyright (c) 2014 owner organisation. All rights reserved.
//

#import "AWAppDelegate.h"

@implementation AWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"VIEW: %@", self.window.rootViewController);
    UINavigationController *navigationViewController = (UINavigationController*)self.window.rootViewController;
    UIViewController *viewController = [navigationViewController.storyboard instantiateViewControllerWithIdentifier:@"first"];
    navigationViewController.viewControllers = @[viewController];
    return YES;
}

@end
