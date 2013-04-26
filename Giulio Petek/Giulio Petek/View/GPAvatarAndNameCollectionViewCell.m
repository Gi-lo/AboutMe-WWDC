/* ------------------------------------------------------------------------------------------------------
 GPAvatarAndNameCollectionViewCell.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAvatarAndNameCollectionViewCell.h"

static CGFloat const GPAvatarAndNameCollectionViewCellAvatarLength = 70.0f;

/* ------------------------------------------------------------------------------------------------------
 @interface GPAvatarAndNameCollectionViewCell ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPAvatarAndNameCollectionViewCell ()

@property (nonatomic, weak, readwrite) UIImageView *avatarImageView;
@property (nonatomic, weak, readwrite) UILabel *nameLabel;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAvatarAndNameCollectionViewCell
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAvatarAndNameCollectionViewCell

#pragma mark -
#pragma mark Getter

- (UIImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"person01a.jpg"]];
    imageView.backgroundColor = [UIColor purpleColor];
    
#warning SLOW build image factory or pre rendered image
    imageView.layer.cornerRadius = 8.0f;
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowRadius = 3.0f;
    imageView.layer.shadowOffset = (CGSize){0.0f, 1.0f};
    imageView.layer.borderWidth = 2.0f;
    imageView.layer.shadowOpacity = 0.7f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.contentView addSubview:imageView];

    _avatarImageView = imageView;
    
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel) {
        return _nameLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = (CGSize){0.0f, 1.0f};
    label.font = [UIFont boldSystemFontOfSize:16.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:label];
    
    _nameLabel = label;
    
    return _nameLabel;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    [self.nameLabel sizeToFit];
    self.nameLabel.center = (CGPoint){ self.contentView.center.x, CGRectGetHeight(self.contentView.bounds) - 40.0f };
    self.nameLabel.frame = CGRectIntegral(self.nameLabel.frame);

    self.avatarImageView.frame = (CGRect){
        ceilf(CGRectGetWidth(self.contentView.bounds) / 2.0f - GPAvatarAndNameCollectionViewCellAvatarLength / 2.0f),
        ceilf(CGRectGetMinY(self.nameLabel.frame) / 2.0f - GPAvatarAndNameCollectionViewCellAvatarLength / 2.0f),
        GPAvatarAndNameCollectionViewCellAvatarLength, GPAvatarAndNameCollectionViewCellAvatarLength
    };
}

#pragma mark -
#pragma mark Reuse

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.nameLabel.text = nil;
    self.avatarImageView.image = nil;
}

@end
