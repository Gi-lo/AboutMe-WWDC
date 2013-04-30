/* ------------------------------------------------------------------------------------------------------
 GPCircleView.m
 
 Created by Giulio Petek on 28.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPCircleView.h"

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

- (BOOL)isOpaque {
    return NO;
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    GCXSafeCurrentContextDrawing(^{
        [self.circleColor setFill];
        [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:floorf(CGRectGetHeight(self.bounds) / 2.0f)] fill];
    });
}

@end
