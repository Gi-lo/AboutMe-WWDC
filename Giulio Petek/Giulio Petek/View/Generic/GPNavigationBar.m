/* ------------------------------------------------------------------------------------------------------
 GPNavigationBar.m
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPNavigationBar.h"

#define NAVIGATION_BAR_HEIGHT 44.0f
#define LINE_FRAME (CGRect){0.0f, CGRectGetHeight(self.bounds) - 1.0f, CGRectGetWidth(self.bounds), 1.0f}
#define TITLE_FRAME self.titleLabel.frame = (CGRect){NAVIGATION_BAR_HEIGHT, 0.0f, CGRectGetWidth(self.bounds) - NAVIGATION_BAR_HEIGHT * 2.0f,NAVIGATION_BAR_HEIGHT - CGRectGetHeight(LINE_FRAME)};
#define BACK_FRAME (CGRect){0.0f, 0.0f, NAVIGATION_BAR_HEIGHT, NAVIGATION_BAR_HEIGHT}

/* ------------------------------------------------------------------------------------------------------
 @interface GPNavigationBar ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPNavigationBar ()

@property (nonatomic, weak) UIButton *_backButton;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPNavigationBar
 ------------------------------------------------------------------------------------------------------ */

@implementation GPNavigationBar

@synthesize titleLabel = _titleLabel;

#pragma mark -
#pragma mark Getter

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = [UIColor colorWithWhite:0.298f alpha:1.0f];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [self bringSubviewToFront:label];

    _titleLabel = label;
    
    return _titleLabel;
}

- (UIButton *)_backButton {
    if (__backButton) {
        return __backButton;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"GPBackButtonArrow"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"GPBackButtonArrow_selected"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(_popBack:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    __backButton = button;
    
    return __backButton;
}

#pragma mark -
#pragma mark Actions

- (void)_popBack:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(didPressBackButtonInNavigationBar:)]) {
        [self.delegate didPressBackButtonInNavigationBar:self];
    }
}

#pragma mark -
#pragma mark Setter

- (void)setLineColor:(UIColor *)lineColor {
    if (_lineColor == lineColor) {
        return;
    }
    
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark - Layout 

- (CGSize)sizeThatFits:(CGSize)size {
    return (CGSize){CGRectGetWidth(self.superview.bounds), NAVIGATION_BAR_HEIGHT};
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = TITLE_FRAME;
    self._backButton.frame = BACK_FRAME;
}

- (void)didMoveToSuperview {        
    [self sizeToFit];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    GCXSafeDrawing(UIGraphicsGetCurrentContext(), ^{
        [[UIColor whiteColor] setFill];
        UIRectFill(self.bounds);
        
        [self.lineColor setFill];
        UIRectFill(LINE_FRAME);
    });
}

@end
