/* ------------------------------------------------------------------------------------------------------
 
 GPCircleView.m
 
 Created by Giulio Petek on 28.04.13.
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
    [super didMoveToSuperview];
    
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    GCXSafeCurrentContextDrawing(^{
        [self.circleColor setFill];
        [self._circlePath fill];
    });
}

@end