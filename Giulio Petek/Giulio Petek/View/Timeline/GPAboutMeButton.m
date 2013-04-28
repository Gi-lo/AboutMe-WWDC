/* ------------------------------------------------------------------------------------------------------
 GPAboutMeButton.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAboutMeButton.h"

static CGFloat const GPAboutMeButtonArrowSpacing = 5.0f;

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAboutMeButton
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAboutMeButton

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
    sizeOfTitle.width += [UIImage imageNamed:@"GPAboutMeButtonArrow"].size.width + GPAboutMeButtonArrowSpacing;

    return sizeOfTitle;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetShadowWithColor(context, (CGSize){0.0f, 1.0f}, 2.0f, [UIColor colorWithWhite:0.0f alpha:0.5f].CGColor);
    [self.highlighted ? [UIColor colorWithWhite:0.851f alpha:1.0f] : [UIColor whiteColor] setFill];
    
    CGFloat textWidth = [self.title drawInRect:self.bounds withFont:[UIFont systemFontOfSize:20.0f]].width;
    
    UIImage *arrowImage = [UIImage imageNamed:self.highlighted ? @"GPTimelineCellIndicator": @"GPAboutMeButtonArrow"];
    [arrowImage drawInRect:CGRectIntegral((CGRect){{
            textWidth + GPAboutMeButtonArrowSpacing,
            CGRectGetHeight(self.bounds) / 2.0f -  arrowImage.size.height / 2.0f
        }, arrowImage.size})];
     
     CGContextRestoreGState(context);
}

@end
