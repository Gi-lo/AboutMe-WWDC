/* ------------------------------------------------------------------------------------------------------
 GPTableHeaderBackgroundImageView.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableHeaderBackgroundImageView.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPTableHeaderBackgroundImageView ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTableHeaderBackgroundImageView ()

@property (nonatomic, weak) CAGradientLayer *_overlayLayer;
@property (nonatomic, weak) CAShapeLayer *_shapeLayer;
@property (nonatomic, strong) dispatch_source_t _timerSource;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementatiom GPTableHeaderBackgroundImageView ()
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableHeaderBackgroundImageView

#pragma mark -
#pragma mark Init

- (instancetype)init {
    if ((self = [super init])) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

#pragma mark -
#pragma mark Animation

- (void)startAnimating {
    if (![self.animationImages count]) {
        return;
    }
    
    [self stopAnimating];
    
    self.image = [self.animationImages objectAtIndex:0];
    
    self._timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    uint64_t nsec = (uint64_t)(self.animationDuration * NSEC_PER_SEC);
    dispatch_source_set_timer(self._timerSource, dispatch_time(DISPATCH_TIME_NOW, nsec), nsec, 0);
    dispatch_source_set_event_handler(self._timerSource, ^{
        NSUInteger currentImageIndex = [self.animationImages indexOfObject:self.image];
        if (currentImageIndex == NSNotFound) {
            currentImageIndex = -1;
        }
        currentImageIndex = ++currentImageIndex % [self.animationImages count];
        
        UIImage *nextImage = [self.animationImages objectAtIndex:currentImageIndex];
        self.image = nextImage;
        
        CATransition *transition = [CATransition animation];
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.duration = 2.0f;
        transition.type = kCATransitionFade;
        [self.layer addAnimation:transition forKey:@"subviews"];
        
    });
    dispatch_resume(self._timerSource);
}

- (void)stopAnimating {
    if (self._timerSource) {
        dispatch_source_cancel(self._timerSource);
    }
}

- (BOOL)isAnimating {
    return NO;
}

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
        (__bridge id)[UIColor colorWithWhite:1.0f alpha:0.6f].CGColor,
        (__bridge id)[UIColor clearColor].CGColor,
        (__bridge id)[UIColor colorWithWhite:0.0f alpha:0.8f].CGColor,
        (__bridge id)[UIColor blackColor].CGColor
    ];
    layer.locations = @[@0.0f, @0.01f, @0.99f, @1.0f];
    [self.layer addSublayer:layer];
    
    __overlayLayer = layer;
    
    return __overlayLayer;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self._shapeLayer.frame = self.bounds;
    self._shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                        cornerRadii:(CGSize){3.0f, 3.0f}].CGPath;
    self._overlayLayer.frame = self.bounds;
}

@end

