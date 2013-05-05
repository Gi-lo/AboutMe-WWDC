/* ------------------------------------------------------------------------------------------------------

 GPAppDelegate.m
 
 Created by Giulio Petek on 24.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
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
