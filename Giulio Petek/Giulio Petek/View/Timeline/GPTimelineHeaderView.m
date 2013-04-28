/* ------------------------------------------------------------------------------------------------------
 GPTimelineHeaderView.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineHeaderView.h"

static const CGFloat GPTimelineHeaderViewAvatarLength = 70.0f;
static const UIEdgeInsets GPTimelineHeaderViewAvatarEdgeInsets = (UIEdgeInsets){0.0f, 15.0f, 10.0f, 8.0f};

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineHeaderView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineHeaderView
@synthesize aboutMeButton = _aboutMeButton;
@synthesize avatarImageView = _avatarImageView;
@synthesize backgroundView = _backgroundView;

#pragma mark -
#pragma mark Getter

- (GPTableHeaderBackgroundView *)backgroundView {
    if (_backgroundView) {
        return _backgroundView;
    }
        
    GPTableHeaderBackgroundView *backgroundView = [[GPTableHeaderBackgroundView alloc] init];
    [self addSubview:backgroundView];
    [self sendSubviewToBack:backgroundView];
    
    _backgroundView = backgroundView;
        
    return _backgroundView;
}

- (GPAboutMeButton *)aboutMeButton {
    if (_aboutMeButton) {
        return _aboutMeButton;
    }
    
    GPAboutMeButton *button = [[GPAboutMeButton alloc] init];
    [self addSubview:button];
    
    _aboutMeButton = button;
    
    return _aboutMeButton;
}

- (UIImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.layer.cornerRadius = GPTimelineHeaderViewAvatarLength / 2.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 2.0f;
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowOffset = (CGSize){0.0f, 1.0f};
    imageView.layer.shadowOpacity = 0.5f;
    imageView.layer.shadowRadius = 1.0f;
    imageView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:(CGRect){0.0f, 0.0f, GPTimelineHeaderViewAvatarLength, GPTimelineHeaderViewAvatarLength}
                                                            cornerRadius:imageView.layer.cornerRadius].CGPath;
    [self addSubview:imageView];
    
    _avatarImageView = imageView;
    
    return _avatarImageView;
}

#pragma mark -
#pragma mark Layout

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.backgroundView sizeThatFits:size];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
    
    self.avatarImageView.frame = (CGRect){
        GPTimelineHeaderViewAvatarEdgeInsets.left,
        CGRectGetHeight(self.bounds) - GPTimelineHeaderViewAvatarLength + GPTimelineHeaderViewAvatarEdgeInsets.bottom,
        GPTimelineHeaderViewAvatarLength,
        GPTimelineHeaderViewAvatarLength
    };
    self.avatarImageView.frame = CGRectIntegral(self.avatarImageView.frame);

    [self.aboutMeButton sizeToFit];
    self.aboutMeButton.frame = (CGRect){{
            CGRectGetMaxX(self.avatarImageView.frame) + GPTimelineHeaderViewAvatarEdgeInsets.right,
            CGRectGetMidY(self.avatarImageView.frame) - CGRectGetHeight(self.aboutMeButton.frame) / 2.0f,
        }, self.aboutMeButton.frame.size
    };
    self.aboutMeButton.frame = CGRectIntegral(self.aboutMeButton.frame);
}

@end
