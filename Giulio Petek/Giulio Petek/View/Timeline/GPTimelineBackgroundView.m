/* ------------------------------------------------------------------------------------------------------

 GPTimelineBackgroundView.m
 
 Created by Giulio Petek on 27.04.13.
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

#import "GPTimelineBackgroundView.h"

#define LINE_FRAME (CGRect){13.0f, 0.0f, 1.0f, CGRectGetHeight(self.bounds)}

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineBackgroundView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineBackgroundView

#pragma mark -
#pragma mark Init

- (id)init {
    if ((self = [super init])) {
        self.backgroundColor = [UIColor colorWithWhite:0.949f alpha:1.0f];
    }
    
    return self;
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    GCXSafeCurrentContextDrawing(^{
        [[UIColor colorWithWhite:0.851f alpha:1.0f] setFill];
        UIRectFill(LINE_FRAME);
    });
}

@end
