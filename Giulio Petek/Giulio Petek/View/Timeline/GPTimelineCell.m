/* ------------------------------------------------------------------------------------------------------
 GPTimelineCell.m
 
 Created by Giulio Petek on 28.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineCell.h"

static NSString *const GPTimelineCellIdentifier = @"GPTimelineCellIdentifier";

static CGRect const GPTimelineCellCircleViewFrame = (CGRect){9.0f, 54.0f, 9.0f, 9.0f};
static CGRect const GPTimelineCellTimelineBubbleViewFrame = (CGRect){26.0f, 20.0f, 284.0f, 74.0f};
static CGRect const GPTimelineCellIndicatorFrame = (CGRect){294.0f, 50.0f, 7.0f, 12.0f};

/* ------------------------------------------------------------------------------------------------------
 @interface GPTimelineCell ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineCell ()

@property (nonatomic, strong, readwrite) GPCircleView *circleView;
@property (nonatomic, strong, readwrite) GPTimelineBubbleView *timelineBubbleView;

- (void)_addCircleView;
- (void)_addTimelineBubbleView;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineCell
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineCell

#pragma mark -
#pragma mark Init

+ (GPTimelineCell *)reusableCellFromTableView:(UITableView *)tableView {
    GPTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:GPTimelineCellIdentifier];
    if (!cell) {
        cell = [[GPTimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPTimelineCellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectedBackgroundView = [UIView new];
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GPTimelineCellIndicator"]];

        [self _addCircleView];
        [self _addTimelineBubbleView];
    }

    return self;
}

#pragma mark -
#pragma mark Views

- (void)_addCircleView {
    GPCircleView *view = [[GPCircleView alloc] initWithFrame:GPTimelineCellCircleViewFrame];
    [self.contentView addSubview:view];
        
    self.circleView = view;
}

- (void)_addTimelineBubbleView {
    GPTimelineBubbleView *view = [[GPTimelineBubbleView alloc] initWithFrame:GPTimelineCellTimelineBubbleViewFrame];
    [self.contentView addSubview:view];
    
    self.timelineBubbleView = view;
}

#pragma mark - 
#pragma mark Layout 

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.accessoryView.frame = GPTimelineCellIndicatorFrame;
}

#pragma mark -
#pragma mark Reuse

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.circleView.circleColor = nil;
    self.timelineBubbleView.titleLabel.text = nil;
    self.timelineBubbleView.dateLabel.text = nil;
    self.timelineBubbleView.textPreviewLabel.text = nil;
}

@end
