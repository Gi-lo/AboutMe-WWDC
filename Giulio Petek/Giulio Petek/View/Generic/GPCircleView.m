/* ------------------------------------------------------------------------------------------------------
 GPCircleView.m
 
 Created by Giulio Petek on 28.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPCircleView.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPCircleView ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPCircleView ()

@property (nonatomic, strong) UIBezierPath *_circlePath;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPCircleView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPCircleView

#pragma mark -
#pragma mark Setter

- (void)setCircleColor:(UIColor *)circleColor {
    if (circleColor == _circleColor) {
        return;
    }
    
    _circleColor = circleColor;
    
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Getter

- (UIBezierPath *)_circlePath {
    if (__circlePath) {
        return __circlePath;
    }
        
    return __circlePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:floorf(CGRectGetHeight(self.bounds) / 2.0f)];
}

#pragma mark -
#pragma mark Layout

- (void)setNeedsLayout {
    [super setNeedsLayout];
    
    self._circlePath = nil;
}

- (void)didMoveToSuperview {    
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    GCXSafeDrawing(UIGraphicsGetCurrentContext(), ^{
        [self.circleColor setFill];
        [self._circlePath fill];
    });
}

@end
