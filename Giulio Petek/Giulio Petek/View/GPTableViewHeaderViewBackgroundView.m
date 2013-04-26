/* ------------------------------------------------------------------------------------------------------
 GPTableViewHeaderViewBackgroundView.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableViewHeaderViewBackgroundView.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPTableViewHeaderViewBackgroundView ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTableViewHeaderViewBackgroundView ()

@property (nonatomic, weak) CAGradientLayer *_overlayLayer;
@property (nonatomic, weak) CAShapeLayer *_shapeLayer;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTableViewHeaderViewBackgroundView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableViewHeaderViewBackgroundView

#pragma mark -
#pragma mark Init

- (id)init {
    if ((self = [super init])) {
        
        // add fade effect and more images
        self.image = [UIImage imageNamed:@"1318602514_bn_rhein_michael-sondermann_presseamt-bundesstadt-bonn.jpg"];
        self.contentMode = UIViewContentModeCenter;
    }
    
    return self;
}

#pragma mark -
#pragma mark Getter

- (CAGradientLayer *)_overlayLayer {
    if (__overlayLayer) {
        return __overlayLayer;
    }
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[
        (__bridge id)[UIColor colorWithWhite:1.0f alpha:0.6f].CGColor,
        (__bridge id)[UIColor clearColor].CGColor,
        (__bridge id)[UIColor colorWithWhite:0.0f alpha:0.8f].CGColor,
        (__bridge id)[UIColor colorWithWhite:1.0f alpha:0.6f].CGColor,
    ];
    layer.locations = @[@0.0001f, @0.0f, @0.9999f, @1.0f];
    [self.layer addSublayer:layer];

    __overlayLayer = layer;
    
    return __overlayLayer;
}

- (CAShapeLayer *)_shapeLayer {
    if (__shapeLayer) {
        return __shapeLayer;
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    //layer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.mask = layer;
    
    __shapeLayer = layer;
    
    return __shapeLayer;
}

#pragma mark -
#pragma mark Overlay

- (void)layoutSubviews {
    [super layoutSubviews];

    self._overlayLayer.frame = self.bounds;
    
    self._shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                        cornerRadii:(CGSize){3.0f, 3.0f}].CGPath;
    self._shapeLayer.frame = self.bounds;
}

@end
