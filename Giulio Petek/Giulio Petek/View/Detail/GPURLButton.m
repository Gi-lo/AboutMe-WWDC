/* ------------------------------------------------------------------------------------------------------

 GPURLButton.m
 
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

#import "GPURLButton.h"

#define LINE_FRAME (CGRect){0.0f, 0.0f, CGRectGetWidth(self.bounds), 1.0f}
#define TEXT_FRAME CGRectIntegral((CGRect){0.0f, CGRectGetHeight(self.bounds)/4.0f, CGRectGetWidth(self.bounds) - CGRectGetHeight(self.bounds)/4.0f, CGRectGetHeight(self.bounds) - CGRectGetHeight(LINE_FRAME)})

/* ------------------------------------------------------------------------------------------------------
 @implementation GPURLButton
 ------------------------------------------------------------------------------------------------------ */

@implementation GPURLButton

#pragma mark -
#pragma mark Setter

- (void)setTitle:(NSString *)title {
    if ([_title isEqualToString:title]) {
        return;
    }
    
    _title = title;

    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
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
        [(self.highlighted ? [UIColor colorWithWhite:0.8f alpha:1.0f] : [UIColor colorWithWhite:0.3f alpha:1.0f]) setFill];
        
        [self.title drawInRect:TEXT_FRAME
                      withFont:[UIFont fontWithName:@"Helvetica-Oblique" size:16.0f]
                 lineBreakMode:NSLineBreakByTruncatingTail
                     alignment:NSTextAlignmentCenter];

        if (!self.highlighted) [[UIColor colorWithWhite:0.7f alpha:1.0f] setFill];
        UIRectFill(LINE_FRAME);
    });
}

@end
