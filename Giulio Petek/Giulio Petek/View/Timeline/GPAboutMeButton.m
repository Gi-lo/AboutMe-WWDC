/* ------------------------------------------------------------------------------------------------------
 GPAboutMeButton.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAboutMeButton.h"

#define ARROW_SPACING 5.0f
#define ARROW_FRAME CGRectIntegral((CGRect){{textWidth + ARROW_SPACING, CGRectGetHeight(self.bounds) / 2.0f -  arrowImage.size.height / 2.0f}, arrowImage.size})

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAboutMeButton
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAboutMeButton

#pragma mark -
#pragma marl Getter

- (BOOL)isOpaque {
    return NO;
}

#pragma mark -
#pragma marl Setter

- (void)setTitle:(NSString *)title {
    if ([_title isEqualToString:title]) {
        return;
    }
    
    _title = title;
    
    [self setNeedsLayout];
}

#pragma mark -
#pragma mark Highlighting

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Layout

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize sizeOfTitle = [self.title sizeWithFont:[UIFont systemFontOfSize:20.0f]];
    sizeOfTitle.width += [UIImage imageNamed:@"GPAboutMeButtonArrow"].size.width + ARROW_SPACING;

    return sizeOfTitle;
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    GCXSafeCurrentContextDrawing(^{
        CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), (CGSize){0.0f, 1.0f}, 2.0f, [UIColor colorWithWhite:0.0f alpha:0.7f].CGColor);
        [self.highlighted ? [UIColor colorWithWhite:0.8f alpha:1.0f] : [UIColor whiteColor] setFill];
        
        CGFloat textWidth = [self.title drawInRect:self.bounds withFont:[UIFont systemFontOfSize:20.0f]].width;
        
        UIImage *arrowImage = [UIImage imageNamed:self.highlighted ? @"GPAboutMeButtonArrow_selected": @"GPAboutMeButtonArrow"];
        [arrowImage drawInRect:ARROW_FRAME];
    });
}

@end
