/* ------------------------------------------------------------------------------------------------------
 GPAboutMeButton.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAboutMeButton.h"

#define ARROW_FRAME (CGRect){{self._textWidth, 4.0f}, CGRectGetHeight(self.bounds), CGRectGetHeight(self.bounds)-4.0f}

/* ------------------------------------------------------------------------------------------------------
 @interface GPAboutMeButton ()
------------------------------------------------------------------------------------------------------ */

@interface GPAboutMeButton ()

@property (nonatomic, unsafe_unretained) CGFloat _textWidth;
@property (nonatomic, weak) UIImageView *_arrowImageView;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAboutMeButton
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAboutMeButton

#pragma mark -
#pragma marl Getter

- (BOOL)isOpaque {
    return NO;
}

- (UIImageView *)_arrowImageView {
    if (__arrowImageView) {
        return __arrowImageView;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GPAboutMeButtonArrow"]];
    imageView.highlightedImage = [UIImage imageNamed:@"GPAboutMeButtonArrow_selected"];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.layer.anchorPoint = (CGPoint){0.5f, 0.45f};
    [self addSubview:imageView];
    
    __arrowImageView = imageView;
    
    return __arrowImageView;
}

#pragma mark -
#pragma marl Setter

- (void)setTitle:(NSString *)title {
    if ([_title isEqualToString:title]) {
        return;
    }
    
    _title = title;
        
    [self sizeToFit];
}

- (void)setDirection:(GPAboutMeButtonArrowDirection)direction {
    if (_direction == direction) {
        return;
    }
    
    _direction = direction;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
        CGFloat degree = direction == GPAboutMeButtonArrowDirectionPointingDown ? 0.0f : 180.0f;
        self._arrowImageView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.0f);
    }];
}

#pragma mark -
#pragma mark Highlighting

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self._arrowImageView.highlighted = highlighted;
    
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self._arrowImageView.frame = ARROW_FRAME;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize textSize = [self.title sizeWithFont:[UIFont systemFontOfSize:20.0f]];
    self._textWidth = textSize.width;
    textSize.width += [UIImage imageNamed:@"GPAboutMeButtonArrow"].size.width;
    
    return textSize;
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    GCXSafeCurrentContextDrawing(^{
        CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), (CGSize){0.0f, 1.0f}, 2.0f, [UIColor colorWithWhite:0.0f alpha:0.7f].CGColor);
        [self.highlighted ? [UIColor colorWithWhite:0.8f alpha:1.0f] : [UIColor whiteColor] setFill];
        [self.title drawInRect:self.bounds withFont:[UIFont systemFontOfSize:20.0f]];
    });
}

@end
