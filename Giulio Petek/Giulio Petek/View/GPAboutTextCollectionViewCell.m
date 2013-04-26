/* ------------------------------------------------------------------------------------------------------
 GPAboutTextCollectionViewCell.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAboutTextCollectionViewCell.h"

static CGFloat const GPAboutTextCollectionViewCellTextInset = 5.0f;

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAvatarAndNameCollectionViewCell
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAboutTextCollectionViewCell
@synthesize aboutMeTextLabel = _aboutMeTextLabel;

#pragma mark -
#pragma mark Getter

- (UILabel *)aboutMeTextLabel {
    if (_aboutMeTextLabel) {
        return _aboutMeTextLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    
    _aboutMeTextLabel = label;
    
    return label;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.aboutMeTextLabel.frame = CGRectInset(self.contentView.bounds, GPAboutTextCollectionViewCellTextInset, 0);
}

#pragma mark -
#pragma mark Reuse

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.aboutMeTextLabel.text = nil;
}

@end
