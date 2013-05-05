/* ------------------------------------------------------------------------------------------------------
 
 GPPlayButton.m
 
 Created by Giulio Petek on 29.04.13.
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
    
    self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
    
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
            [[UIColor colorWithWhite:0.0f alpha:0.2f] setFill];
            [path fill];
        }
    });
}

@end
