/* ------------------------------------------------------------------------------------------------------
 GPAppDelegate.m
 
 Created by Giulio Petek on 24.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAppDelegate.h"
#import "GPTimelineViewController.h"

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAppDelegate
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAppDelegate

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[GPTimelineViewController alloc] init]];
    [navigationController setNavigationBarHidden:YES animated:NO];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];

    /*
    GPNavigationBar *navbar = [[GPNavigationBar alloc] initWithFrame:(CGRect){0.0f, 20.0f, 0.0f, 0.0f}];
    navbar.lineColor = [UIColor orangeColor];
    navbar.titleLabel.text = @"My way is great";
    [self.window addSubview:navbar];
    */
    
    //self.window.rootViewController = [[GPTimelineViewController alloc] init];
   

    return YES;
}

@end
