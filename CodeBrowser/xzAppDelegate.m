//
//  xzAppDelegate.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzAppDelegate.h"

#import "xzViewController.h"

@implementation xzAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc {
    [super dealloc];
    [_window release];
    [_viewController release];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[xzViewController alloc] initWithNibName:@"xzViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
