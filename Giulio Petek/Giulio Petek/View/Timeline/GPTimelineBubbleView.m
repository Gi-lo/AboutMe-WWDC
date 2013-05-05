/* ------------------------------------------------------------------------------------------------------
 
 GPTimelineBubbleView.m
 
 Created by Giulio Petek on 28.04.13.
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

#import "GPTimelineBubbleView.h"
 
#define BACKGROUND_INSETS self.highlighted ? (UIEdgeInsets){0.0f, 7.0f, 5.0f, 3.0f} : (UIEdgeInsets){0.0f, 8.0f, 5.0f, 3.0f}
#define DATE_FRAME (CGRect){CGRectGetWidth(self.bounds) - 116.f, 2.0f, 96.0f, 28.0f}
#define TITLE_FRAME (CGRect){12.0f, 2.0f, CGRectGetWidth(self.bounds) - 116.f - 12.0f, 28.0f}
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
