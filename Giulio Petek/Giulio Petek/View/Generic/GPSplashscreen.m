/* ------------------------------------------------------------------------------------------------------
 
 GPSplashscreen.m
 
 Created by Giulio Petek on 1.05.13.
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

#import "GPSplashscreen.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPSplashscreen ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPSplashscreen ()

@property (nonatomic, weak) UIImageView *_logoImageView;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPSplashscreen
 ------------------------------------------------------------------------------------------------------ */

@implementation GPSplashscreen

#pragma mark -
#pragma mark Getter

- (UIImageView *)_logoImageView {
    if (__logoImageView) {
        return __logoImageView;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WWDC_Logo"]];
    [self addSubview:imageView];
    
    __logoImageView = imageView;
    
    return __logoImageView;
}

#pragma mark - 
#pragma mark Layout

- (void)didMoveToSuperview {
    self.backgroundColor = [UIColor whiteColor];
    
    self._logoImageView.center = self.center;

    [self _startAnimation];
}

#pragma mark -
#pragma mark Animation

- (void)_startAnimation {
    CAKeyframeAnimation *alertAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [alertAnimation setValues:@[
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]
    ]];
    [alertAnimation setKeyTimes:@[@0.0f, @0.5f, @0.75f, @1.0f]];
    alertAnimation.fillMode = kCAFillModeForwards;
    alertAnimation.removedOnCompletion = NO;
    alertAnimation.duration = 0.3f;
    [self._logoImageView.layer addAnimation:alertAnimation forKey:@"pop in"];
    
    [UIView animateWithDuration:1.0f
                          delay:0.3f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
