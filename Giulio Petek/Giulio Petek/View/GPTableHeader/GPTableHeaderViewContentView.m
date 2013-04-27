/* ------------------------------------------------------------------------------------------------------
 GPTableHeaderViewContentView.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableHeaderViewContentView.h"

static CGFloat const GPTableHeaderViewContentViewAvatarLength = 80.0f;
static CGFloat const GPTableHeaderViewContentViewAvatarInset = 15.0f;


/* ------------------------------------------------------------------------------------------------------
 @interface GPTableHeaderView ()
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableHeaderViewContentView

#pragma mark -
#pragma mark Getter

- (UIImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
#warning SLOW build image factory or pre rendered image
    imageView.layer.cornerRadius = 36.0f;
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowRadius = 3.0f;
    imageView.layer.shadowOffset = (CGSize){0.0f, 1.0f};
    imageView.layer.shadowOpacity = 0.8f;
    imageView.layer.borderWidth = 1.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
    
    [self addSubview:imageView];
    
    _avatarImageView = imageView;
    
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel) {
        return _nameLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.shadowColor = [UIColor blackColor];
    label.layer.shadowRadius = 5.0f;
    label.shadowOffset = (CGSize){0.0f, 2.0f};
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    
    _nameLabel = label;
    
    return _nameLabel;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    self.avatarImageView.frame = (CGRect){
        GPTableHeaderViewContentViewAvatarInset,
        CGRectGetHeight(self.bounds) - GPTableHeaderViewContentViewAvatarLength / 4 * 3,
        GPTableHeaderViewContentViewAvatarLength,
        GPTableHeaderViewContentViewAvatarLength
    };
    self.avatarImageView.frame = CGRectIntegral(self.avatarImageView.frame);

    [self.nameLabel sizeToFit];
    self.nameLabel.frame = (CGRect){{
            CGRectGetMaxX(self.avatarImageView.frame) + GPTableHeaderViewContentViewAvatarInset,
            CGRectGetHeight(self.bounds) - CGRectGetHeight(self.nameLabel.bounds) - GPTableHeaderViewContentViewAvatarInset / 2.0f
        }, self.nameLabel.frame.size
    };
    self.nameLabel.frame = CGRectIntegral(self.nameLabel.frame);
}

@end
