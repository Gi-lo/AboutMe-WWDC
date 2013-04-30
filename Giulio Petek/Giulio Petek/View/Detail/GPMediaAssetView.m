/* ------------------------------------------------------------------------------------------------------
 GPMediaAssetView.m
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPMediaAssetView.h"

/* ------------------------------------------------------------------------------------------------------
 @implementation GPMediaAssetView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPMediaAssetView
@synthesize imageView = _imageView;
@synthesize playButton = _playButton;

#pragma mark -
#pragma mark - Getter

- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    [self sendSubviewToBack:imageView];

    _imageView = imageView;
    
    return _imageView;
}

- (GPPlayButton *)playButton {
    if (_playButton) {
        return _playButton;
    }
    
    GPPlayButton *playButton = [[GPPlayButton alloc] init];
    [self addSubview:playButton];
    [self bringSubviewToFront:playButton];
    
    _playButton = playButton;
    
    return _playButton;
}

#pragma mark -
#pragma mark - Setter

- (void)setType:(GPMediaAssetType)type {
    self.playButton.hidden = type == GPMediaAssetTypeVideo ? NO : YES;
}

- (GPMediaAssetType)type {
    return self.playButton.hidden ? GPMediaAssetTypePhoto : GPMediaAssetTypeVideo;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    self.playButton.frame = self.imageView.frame;
}

@end
