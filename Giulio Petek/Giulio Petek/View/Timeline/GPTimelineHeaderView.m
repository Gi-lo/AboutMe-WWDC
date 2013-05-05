/* ------------------------------------------------------------------------------------------------------
 
 GPTimelineHeaderView.h
 
 Created by Giulio Petek on 27.04.13.
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

#import "GPTimelineHeaderView.h"

static void *GPTimelineHeaderScrollViewDidScrollViewContext;

#define AVATAR_LENGTH 72.0f
#define HEADER_HEIGTH 100.0f
#define AVATAR_FRAME CGRectIntegral((CGRect){15.0f, CGRectGetHeight(self.bounds) - AVATAR_LENGTH + 8.0f, AVATAR_LENGTH, AVATAR_LENGTH})
#define ABOUT_ME_FRAME CGRectIntegral((CGRect){CGRectGetMaxX(self.avatarImageView.frame) + 10.0f, CGRectGetMidY(self.avatarImageView.frame) - 12.0, 140.0f, 24.0f})

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineHeaderView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineHeaderView
@synthesize aboutMeButton = _aboutMeButton;
@synthesize avatarImageView = _avatarImageView;
@synthesize backgroundImageView = _backgroundImageView;

#pragma mark -
#pragma mark Getter

- (UIImageView *)backgroundImageView {
    if (_backgroundImageView) {
        return _backgroundImageView;
    }
        
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    [self sendSubviewToBack:imageView];
    
    _backgroundImageView = imageView;
        
    return _backgroundImageView;
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

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Avatar"]];
    [self addSubview:imageView];


    _avatarImageView = imageView;
    
    return _avatarImageView;
}

#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIScrollView *)object change:(NSDictionary *)change context:(void *)context {
    if (context == GPTimelineHeaderScrollViewDidScrollViewContext) {
        [self _scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    }
}

- (void)_scrollViewDidScroll:(CGPoint)contentOffset {
    if (contentOffset.y > 0) {
        return;
    }
    
    self.frame = CGRectIntegral((CGRect){0.0f, contentOffset.y, CGRectGetWidth(self.bounds), contentOffset.y * (-1)});
}

#pragma mark -
#pragma mark Layout

- (CGSize)sizeThatFits:(CGSize)size {
    return (CGSize){CGRectGetWidth(self.superview.bounds), HEADER_HEIGTH};
}

- (void)didMoveToSuperview {
    NSAssert([self.superview isKindOfClass:[UIScrollView class]], @"Superview must be of class UIScrollView");
    
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    UIEdgeInsets newInset = scrollView.contentInset;
    newInset.top = HEADER_HEIGTH;
    scrollView.contentInset = newInset;
    
    [self.superview addObserver:self
                     forKeyPath:@"contentOffset"
                        options:NSKeyValueObservingOptionNew
                        context:GPTimelineHeaderScrollViewDidScrollViewContext];
    
    [self sizeToFit];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [self removeObserver:self forKeyPath:@"contentOffset" context:GPTimelineHeaderScrollViewDidScrollViewContext];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
    self.avatarImageView.frame = AVATAR_FRAME;
    self.aboutMeButton.frame = ABOUT_ME_FRAME;
}

@end
