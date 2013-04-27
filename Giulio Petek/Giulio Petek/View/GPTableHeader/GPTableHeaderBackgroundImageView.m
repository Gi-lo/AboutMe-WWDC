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
        (__bridge id)[UIColor whiteColor].CGColor,
        (__bridge id)[UIColor clearColor].CGColor,
        (__bridge id)[UIColor colorWithWhite:0.0f alpha:0.6f].CGColor,
        (__bridge id)[UIColor blackColor].CGColor,
    ];
    layer.locations = @[@0.000f, @0.008f, @0.960f, @1.000f];
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

