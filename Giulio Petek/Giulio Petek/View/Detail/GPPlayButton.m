/* ------------------------------------------------------------------------------------------------------
 GPPlayButton.m
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPPlayButton.h"

#define CIRCLE_FRAME CGRectIntegral((CGRect){CGRectGetWidth(self.bounds) / 2.0f - 22.0f, CGRectGetHeight(self.bounds) / 2.0f - 22.0f, 44.0f, 44.0f})
#define PLAY_GLYPH_FRAME CGRectIntegral((CGRect){{circleFrame.origin.x + circleFrame.size.width / 3.0f, circleFrame.origin.y + circleFrame.size.height / 4.0f}, playImage.size})

/* ------------------------------------------------------------------------------------------------------
 @implementation GPPlayButton
 ------------------------------------------------------------------------------------------------------ */

@implementation GPPlayButton

#pragma mark -
#pragma mark Setter

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
}

- (void)setCircleColor:(UIColor *)circleColor {
    if (_circleColor == circleColor) {
        return;
    }
    
    _circleColor = circleColor;
    
    self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
    
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    GCXSafeCurrentContextDrawing(^{
        CGRect circleFrame = CIRCLE_FRAME;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:circleFrame cornerRadius:floorf(CGRectGetHeight(circleFrame) / 2.0f)];
        
        [self.circleColor setFill];
        [path fill];
        
        UIImage *playImage = [UIImage imageNamed:@"GPPlayButtonGlyph"];
        [playImage drawInRect:PLAY_GLYPH_FRAME];
        
        if (self.highlighted) {
            [[UIColor colorWithWhite:0.0f alpha:0.3f] setFill];
            [path fill];
        }
    });
}

@end
