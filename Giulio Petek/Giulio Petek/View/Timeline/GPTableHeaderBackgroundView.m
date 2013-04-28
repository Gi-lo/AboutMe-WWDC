/* ------------------------------------------------------------------------------------------------------
 GPTableHeaderBackgroundVie.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableHeaderBackgroundView.h"

static NSTimeInterval const GPTableHeaderBackgroundViewAnimationDuration = 10.0f;

/* ------------------------------------------------------------------------------------------------------
 @interface GPTableHeaderBackgroundView ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTableHeaderBackgroundView ()

@property (nonatomic, weak) CAGradientLayer *_overlayLayer;
@property (nonatomic, weak) CAShapeLayer *_shapeLayer;
@property (nonatomic, weak) NSTimer *_imageTimer;

- (void)_changeImage;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementatiom GPTableHeaderBackgroundView ()
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableHeaderBackgroundView

#pragma mark -
#pragma mark Getter

- (CAShapeLayer *)_shapeLayer {
    if (__shapeLayer) {
        return __shapeLayer;
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    self.layer.mask = layer;
    
    __shapeLayer = layer;
    
    return __shapeLayer;
}

- (CAGradientLayer *)_overlayLayer {    
    if (__overlayLayer) {
        return __overlayLayer;
    }
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[
        (__bridge id)[UIColor colorWithWhite:1.0f alpha:0.3f].CGColor,
        (__bridge id)[UIColor clearColor].CGColor,
        (__bridge id)[UIColor clearColor].CGColor,
       // (__bridge id)[UIColor colorWithWhite:0.0f alpha:0.1f].CGColor,
        (__bridge id)[UIColor colorWithWhite:0.0f alpha:0.6f].CGColor,
    ];
    layer.locations = @[@0.005f, @0.01f, @0.995f, @1.0f];
    [self.layer addSublayer:layer];
    
    __overlayLayer = layer;
    
    return __overlayLayer;
}

#pragma mark -
#pragma mark Animations

- (void)setAnimationImages:(NSArray *)animationImages {
    [super setAnimationImages:animationImages];

    if ([animationImages count]) {
        self.image = animationImages[0];
        
        [self startAnimating];
    }
}

- (void)startAnimating {
    if (![self.animationImages count]) {
        return;
    }
    
    [self stopAnimating];
        
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.animationDuration
                                             target:self
                                           selector:@selector(_changeImage)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self._imageTimer = timer;
}

- (void)_changeImage {
    NSUInteger currentImageIndex = [self.animationImages indexOfObject:self.image];
    if (currentImageIndex == NSNotFound) {
        currentImageIndex = -1;
    }
    currentImageIndex = ++currentImageIndex % [self.animationImages count];
    UIImage *nextImage = self.animationImages[currentImageIndex];
    
    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.duration = 1.5f;
    transition.type = kCATransitionFade;
    [self.layer addAnimation:transition forKey:@"image change"];
    
    self.image = nextImage;
}

- (void)stopAnimating {
    if ([self._imageTimer isValid]) {
        [self._imageTimer invalidate];
    }
}

- (BOOL)isAnimating {
    return NO;
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
    NSLog(@"You cannot override the animation duration. It is hard set to %f.", self.animationDuration);
}

- (NSTimeInterval)animationDuration {
    return GPTableHeaderBackgroundViewAnimationDuration;
}

#pragma mark -
#pragma mark Layout

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self startAnimating];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [self stopAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
        
    self._shapeLayer.frame = self.bounds;
    self._shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                        cornerRadii:(CGSize){3.0f, 3.0f}].CGPath;
    self._overlayLayer.frame = self.bounds;
}

@end

