/* ------------------------------------------------------------------------------------------------------
 GPTimelineBackgroundView.m
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
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
    GCXSafeDrawing(UIGraphicsGetCurrentContext(), ^{
        [[UIColor colorWithWhite:0.851f alpha:1.0f] setFill];
        UIRectFill(LINE_FRAME);
    });
}

@end
