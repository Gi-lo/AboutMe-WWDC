/* ------------------------------------------------------------------------------------------------------
 
 GPTimelineCell.m
 
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

#import "GPTimelineCell.h"

static NSString *const GPTimelineCellIdentifier = @"GPTimelineCellIdentifier";

#define CIRCLE_FRAME (CGRect){9.0f, 54.0f, 9.0f, 9.0f}
#define BUBBLE_FRAME (CGRect){26.0f, 20.0f, 284.0f, 74.0f}
#define INDICATOR_FRAME (CGRect){294.0f, 50.0f, 7.0f, 12.0f}

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
        
        UIImageView *accessoryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GPTimelineCellIndicator"]];
        accessoryImageView.highlightedImage = [UIImage imageNamed:@"GPTimelineCellIndicator_selected"];
        self.accessoryView = accessoryImageView;
        
        [self _addCircleView];
        [self _addTimelineBubbleView];
    }

    return self;
}

#pragma mark -
#pragma mark Views

- (void)_addCircleView {
    GPCircleView *view = [[GPCircleView alloc] initWithFrame:CIRCLE_FRAME];
    [self.contentView addSubview:view];
        
    self.circleView = view;
}

- (void)_addTimelineBubbleView {
    GPTimelineBubbleView *view = [[GPTimelineBubbleView alloc] initWithFrame:BUBBLE_FRAME];
    [self.contentView addSubview:view];
    
    self.timelineBubbleView = view;
}

#pragma mark -
#pragma mark Setter

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.timelineBubbleView.highlighted = highlighted;
}

#pragma mark - 
#pragma mark Layout 

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.accessoryView.frame = INDICATOR_FRAME;
}

#pragma mark -
#pragma mark Reuse

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.timelineBubbleView.titleLabel.text = nil;
    self.timelineBubbleView.dateLabel.text = nil;
    self.timelineBubbleView.textPreviewLabel.text = nil;
}

@end
