/* ------------------------------------------------------------------------------------------------------
 GPAppDelegate.m
 
 Created by Giulio Petek on 24.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAppDelegate.h"
#import "GPTimelineViewController.h"
#import "CAAnimation+CompletionBlock.h"

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAppDelegate
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAppDelegate

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[GPTimelineViewController alloc] init]];
    [navigationController setNavigationBarHidden:YES animated:NO];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];

    /*
    UIView *container = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    container.backgroundColor = [UIColor whiteColor];
    [self.window.rootViewController.view addSubview:container];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WWDCLogo"]];
    imageView.center = self.window.center;
    [container addSubview:imageView];
    /*
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @((2.0f * M_PI) * 9.0f);
	rotationAnimation.duration = 4.0f;
    rotationAnimation.removedOnCompletion = NO;
    [rotationAnimation setFillMode:kCAFillModeForwards];

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.fromValue = @0.0f;
	scaleAnimation.toValue = @6.0f;
	scaleAnimation.duration = 4.0f;
    scaleAnimation.removedOnCompletion = NO;
    [scaleAnimation setFillMode:kCAFillModeForwards];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.duration = 4.0f;
    animationGroup.removedOnCompletion = NO;
    [animationGroup setFillMode:kCAFillModeForwards];
    animationGroup.completionBlock = ^(CAAnimation *animation) {
        [container removeFromSuperview];
    };
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	[animationGroup setAnimations:@[rotationAnimation, scaleAnimation]];
    [imageView.layer addAnimation:animationGroup forKey:@"test"];
    */
    
    /*
    CAKeyframeAnimation *alertAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [alertAnimation setValues:@[
     [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
     [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
     [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
     [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]
     ]];
    [alertAnimation setKeyTimes:@[ @0.0f, @0.5f, @0.75, @1.0f ]];
    alertAnimation.fillMode = kCAFillModeForwards;
    alertAnimation.removedOnCompletion = NO;
    alertAnimation.duration = 0.5f;
    [imageView.layer addAnimation:alertAnimation forKey:@"pop in"];
    
    CABasicAnimation *fadeAnimation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeAnimation2.fromValue = @1.0f;
	fadeAnimation2.toValue = @0.0f;
	fadeAnimation2.duration = 1.5f;
    fadeAnimation2.removedOnCompletion = NO;
    [fadeAnimation2 setFillMode:kCAFillModeForwards];
	fadeAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    fadeAnimation2.completionBlock = ^(CAAnimation *ani) {
        [container removeFromSuperview];
    };
    [container.layer addAnimation:fadeAnimation2 forKey:@"fade"];

    [self.window makeKeyAndVisible];
*/
    /*
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * 30];
    rotationAnimation.duration = 5.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    CAKeyframeAnimation *growAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [growAnimation setValues:@[
     [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
     [NSValue valueWithCATransform3D:CATransform3DMakeScale(5.0f, 5.0f, 5.0f)],
     ]];
    growAnimation.duration = 4.0f;
    
    double delayInSeconds = 1.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){        
        [imageView.layer addAnimation:growAnimation forKey:@"growAnimation"];
    });
    */

    
/*
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[GPTimelineViewController alloc] init]];
    [navigationController setNavigationBarHidden:YES animated:NO];
    self.window.rootViewController = navigationController;
    */
    
   // [self.window makeKeyAndVisible];

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


@end
