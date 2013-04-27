/* ------------------------------------------------------------------------------------------------------
 GPTableHeaderCell.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableHeaderCell.h"

static CGFloat const GPTableHeaderCellImageViewLength = 70.0f;
static UIOffset const GPTableHeaderCellImageViewOffset = (UIOffset){22.0f, 12.0f};

/* ------------------------------------------------------------------------------------------------------
 @interface GPTableHeaderCell ()
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableHeaderCell

#pragma mark -
#pragma mark Getter

- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
#warning SLOW -> pre rendered image
    imageView.layer.cornerRadius = 36.0f;
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowRadius = 3.0f;
    imageView.layer.shadowOffset = (CGSize){0.0f, 1.0f};
    imageView.layer.shadowOpacity = 0.8f;
    imageView.layer.borderWidth = 1.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
        
    [self.contentView addSubview:imageView];
    
    _imageView = imageView;
    
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.shadowColor = [UIColor blackColor];
    label.layer.shadowRadius = 5.0f;
    label.shadowOffset = (CGSize){0.0f, 1.0f};
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:label];
    
    _titleLabel = label;
    
    return _titleLabel;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    self.imageView.frame = (CGRect){
        GPTableHeaderCellImageViewOffset.horizontal,
        CGRectGetHeight(self.bounds) - GPTableHeaderCellImageViewLength + GPTableHeaderCellImageViewOffset.vertical,
        GPTableHeaderCellImageViewLength,
        GPTableHeaderCellImageViewLength
    };
    self.imageView.frame = CGRectIntegral(self.imageView.frame);

    [self.titleLabel sizeToFit];
    self.titleLabel.frame = (CGRect){{
            CGRectGetMaxX(self.imageView.frame) + GPTableHeaderCellImageViewOffset.horizontal,
            CGRectGetHeight(self.bounds) - CGRectGetHeight(self.titleLabel.bounds) - GPTableHeaderCellImageViewOffset.vertical / 2.0f
        }, self.titleLabel.frame.size
    };
    self.titleLabel.frame = CGRectIntegral(self.titleLabel.frame);
}

@end
