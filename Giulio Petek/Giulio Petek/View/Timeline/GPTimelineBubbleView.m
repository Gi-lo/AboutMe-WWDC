/* ------------------------------------------------------------------------------------------------------
 GPTimelineBubbleView.m
 
 Created by Giulio Petek on 28.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineBubbleView.h"
 
#define BACKGROUND_INSETS self.highlighted ? (UIEdgeInsets){0.0f, 7.0f, 5.0f, 3.0f} : (UIEdgeInsets){0.0f, 8.0f, 5.0f, 3.0f}
#define DATE_FRAME (CGRect){CGRectGetWidth(self.bounds) - 110.f, 2.0f, 90.0f, 28.0f}
#define TITLE_FRAME (CGRect){12.0f, 2.0f, CGRectGetWidth(self.bounds) - CGRectGetMinX(DATE_FRAME) - 12.0f, 28.0f}
#define TEXT_FRAME (CGRect){12.0f, CGRectGetMinY(DATE_FRAME) + CGRectGetHeight(DATE_FRAME) - 5.0f, CGRectGetWidth(self.bounds) - 34.0f, CGRectGetHeight(self.bounds) - CGRectGetMinY(DATE_FRAME) - CGRectGetHeight(DATE_FRAME)}

/* ------------------------------------------------------------------------------------------------------
 @interface GPTimelineBubbleView
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineBubbleView ()

@property (nonatomic, weak, readwrite) UILabel *titleLabel;
@property (nonatomic, weak, readwrite) UILabel *dateLabel;
@property (nonatomic, weak, readwrite) UILabel *textPreviewLabel;

- (void)_addTitleLabel;
- (void)_addDateLabel;
- (void)_addTextPreviewLabel;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineBubbleView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineBubbleView
@synthesize titleLabel = _titleLabel;
@synthesize textPreviewLabel = _textPreviewLabel;
@synthesize dateLabel = _dateLabel;

#pragma mark -
#pragma mark Init

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self _addTitleLabel];
        [self _addDateLabel];
        [self _addTextPreviewLabel];
    }

    return self;
}

#pragma mark -
#pragma mark Views

- (void)_addTitleLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textColor = [UIColor colorWithWhite:0.302f alpha:1.0f];
    label.adjustsFontSizeToFitWidth = YES;
    label.frame = TITLE_FRAME;
    [self addSubview:label];
    
    self.titleLabel = label;
}

- (void)_addDateLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.textColor = [UIColor colorWithWhite:0.502f alpha:1.0f];
    label.textAlignment = NSTextAlignmentRight;
    label.frame = DATE_FRAME;
    [self addSubview:label];
    
    self.dateLabel = label;
}

- (void)_addTextPreviewLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = [UIColor colorWithWhite:0.502f alpha:1.0f];
    label.numberOfLines = 2;
    label.frame = TEXT_FRAME;
    [self addSubview:label];
    
    self.textPreviewLabel = label;
}

#pragma mark -
#pragma mark Setter

- (void)setHighlighted:(BOOL)highlighted {
    if (_highlighted == highlighted) {
        return;
    }
    
    _highlighted = highlighted;
    
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Layout

- (void)didMoveToSuperview {        
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {    
    UIImage *image = [UIImage imageNamed:(self.highlighted ? @"GPTimelineBubbleBackground_selected" : @"GPTimelineBubbleBackground")];
    image = [image resizableImageWithCapInsets:BACKGROUND_INSETS resizingMode:UIImageResizingModeStretch];
    [image drawInRect:self.bounds];
}

@end
