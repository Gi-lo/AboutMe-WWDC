/* ------------------------------------------------------------------------------------------------------
 GPTimelineBubbleView.m
 
 Created by Giulio Petek on 28.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineBubbleView.h"

static UIEdgeInsets const GPTimelineBubbleBackgroundImageEdgeInsets = (UIEdgeInsets){0.0f, 8.0f, 5.0f, 3.0f};

static CGRect const GPTimelineTitleLabelFrame = (CGRect){12.0f, 2.0f, 0.0f, 28.0f};
static CGRect const GPTimelineDateLabelFrame = (CGRect){112.0f, 2.0f, 90.0f, 28.0f};
static CGRect const GPTimelinePreviewTextLabelFrame = (CGRect){12.0f, 0.0f, 0.0f, 0.0f};

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

    CGRect frame = GPTimelineTitleLabelFrame;
    frame.size.width = CGRectGetWidth(self.bounds) - CGRectGetMinX(GPTimelineDateLabelFrame) - CGRectGetMinX(GPTimelineTitleLabelFrame);
    label.frame = frame;
    
    [self addSubview:label];
    self.titleLabel = label;
}

- (void)_addDateLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.textColor = [UIColor colorWithWhite:0.502f alpha:1.0f];
    label.textAlignment = NSTextAlignmentRight;
    
    CGRect frame = GPTimelineDateLabelFrame;
    frame.origin.x = CGRectGetWidth(self.bounds) - CGRectGetMinX(GPTimelineDateLabelFrame);
    label.frame = frame;
    
    [self addSubview:label];
    self.dateLabel = label;
}

- (void)_addTextPreviewLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = [UIColor colorWithWhite:0.502f alpha:1.0f];
    label.numberOfLines = 2;

    CGRect frame = GPTimelinePreviewTextLabelFrame;
    frame.origin.y = CGRectGetMinY(GPTimelineTitleLabelFrame) + CGRectGetHeight(GPTimelineTitleLabelFrame);
    frame.size.height = CGRectGetHeight(self.bounds) - frame.origin.y;
    frame.origin.y -= 5.0f;
    frame.size.width = CGRectGetWidth(self.bounds) - CGRectGetMinX(GPTimelinePreviewTextLabelFrame) * 2.0f - 10.0f;
    label.frame = frame;
    
    [self addSubview:label];
    self.textPreviewLabel = label;
}

#pragma mark -
#pragma mark Layout

- (void)didMoveToSuperview {        
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {    
    UIImage *image = [UIImage imageNamed:@"GPTimelineBubbleBackground"];
    image = [image resizableImageWithCapInsets:GPTimelineBubbleBackgroundImageEdgeInsets resizingMode:UIImageResizingModeStretch];
    [image drawInRect:self.bounds];
}

@end
