/* ------------------------------------------------------------------------------------------------------
 GPTimelineBackgroundView.m
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineBackgroundView.h"

static CGFloat const GPTimelineBackgroundViewLineOriginX = 13.0f;

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
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [[UIColor colorWithWhite:0.851f alpha:1.0f] setFill];
    UIRectFill((CGRect){GPTimelineBackgroundViewLineOriginX, 0.0f, 1.0f, CGRectGetHeight(self.bounds)});
    CGContextRestoreGState(context);
}

@end
