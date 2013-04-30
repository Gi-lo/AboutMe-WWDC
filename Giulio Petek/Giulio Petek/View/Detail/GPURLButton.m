/* ------------------------------------------------------------------------------------------------------
 GPURLButton.m
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
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
