/* ------------------------------------------------------------------------------------------------------
 GCXAppDelegate.m
 
 Created by Giulio Petek on 24.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GCXAppDelegate.h"

/* ------------------------------------------------------------------------------------------------------
 @implementation GCXAppDelegate
 ------------------------------------------------------------------------------------------------------ */

@implementation GCXAppDelegate

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
