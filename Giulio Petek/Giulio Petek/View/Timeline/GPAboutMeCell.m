/* ------------------------------------------------------------------------------------------------------
 GPAboutMeButton.m
 
 Created by Giulio Petek on 1.05.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAboutMeCell.h"

static NSString *const GPAboutMeCellIdentifier = @"GPAboutMeCellIdentifier";

#define BACKGROUND_IMAGE_INSETS (UIEdgeInsets){3.0f, 4.0f, 4.0f, 5.0f}
#define BACKGROUND_FRAME (CGRect){30.0f, 20.0f, 280.0f, CGRectGetHeight(self.contentView.bounds) - 20.0f}
#define LABEL_FRAME CGRectIntegral(CGRectInset(BACKGROUND_FRAME, 10.0f, 10.0f))

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAboutMeCell
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAboutMeCell
@synthesize contentTextView = _contentTextView;

#pragma mark -
#pragma mark Init

+ (GPAboutMeCell *)reusableCellFromTableView:(UITableView *)tableView {
    GPAboutMeCell *cell = [tableView dequeueReusableCellWithIdentifier:GPAboutMeCellIdentifier];
    if (!cell) {
        cell = [[GPAboutMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPAboutMeCellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectedBackgroundView = [UIView new];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        UIImage *backgroundImage = [UIImage imageNamed:@"GPContentBackground"];
        imageView.image = [backgroundImage resizableImageWithCapInsets:BACKGROUND_IMAGE_INSETS resizingMode:UIImageResizingModeStretch];
        self.backgroundView = imageView;
    }
    
    return self;
}

#pragma mark -
#pragma mark Getter

- (UITextView *)contentTextView {
    if (_contentTextView) {
        return _contentTextView;
    }
    
    UITextView *textView = [[UITextView alloc] init];
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    textView.contentInset = UIEdgeInsetsMake(-8.0f, -8.0f, -8.0f, -8.0f);
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.font = [UIFont boldSystemFontOfSize:13.0f];
    textView.textColor = [UIColor colorWithWhite:0.302f alpha:1.0f];
    [self.contentView addSubview:textView];
    
    _contentTextView = textView;
    
    return _contentTextView;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentTextView.frame = LABEL_FRAME;
    self.backgroundView.frame = BACKGROUND_FRAME;
}

@end
