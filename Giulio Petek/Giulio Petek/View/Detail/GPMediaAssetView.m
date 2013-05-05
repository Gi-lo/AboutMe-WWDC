/* ------------------------------------------------------------------------------------------------------
 
 GPMediaAssetView.m
 
 Created by Giulio Petek on 29.04.13.
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
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
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
