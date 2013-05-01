/* ------------------------------------------------------------------------------------------------------
 GPAppDelegate.m
 
 Created by Giulio Petek on 24.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAppDelegate.h"
#import "GPTimelineViewController.h"
#import "GPSplashscreen.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPAppDelegate ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPAppDelegate ()

- (void)_asignRootViewController;
- (void)_performLaunchAnimation;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAppDelegate
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAppDelegate

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self _asignRootViewController];
    [self _performLaunchAnimation];
    [self.window makeKeyAndVisible];

    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    UIViewController *presentedViewController = self.window.rootViewController.presentedViewController;
    if (!presentedViewController || [presentedViewController isBeingDismissed]) {
        return UIInterfaceOrientationMaskPortrait;
    }
    
    if ([presentedViewController isKindOfClass:[UINavigationController class]]) {
        presentedViewController = ((UINavigationController *)presentedViewController).visibleViewController;
    }
    
    NSArray *classNamesRotatingToAllDirections = @[@"MPMoviePlayerViewController", @"GPWebViewController"];
    for (NSString *className in classNamesRotatingToAllDirections) {
        if ([presentedViewController isKindOfClass:NSClassFromString(className)]) {
            return UIInterfaceOrientationMaskAll;
        }
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark -
#pragma mark Launch

- (void)_asignRootViewController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[GPTimelineViewController alloc] init]];
    [navigationController setNavigationBarHidden:YES animated:NO];
    self.window.rootViewController = navigationController;
}

- (void)_performLaunchAnimation {
    GPSplashscreen *splashcreen = [[GPSplashscreen alloc] initWithFrame:self.window.bounds];
    [self.window.rootViewController.view addSubview:splashcreen];
}

@end
