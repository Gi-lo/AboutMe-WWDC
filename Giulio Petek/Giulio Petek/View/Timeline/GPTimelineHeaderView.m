/* ------------------------------------------------------------------------------------------------------
 GPTimelineHeaderView.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineHeaderView.h"

static void *GPTimelineHeaderScrollViewDidScrollViewContext;

static const CGFloat GPTimelineHeaderViewHeight = 100.0f;
static const CGFloat GPTimelineHeaderViewAvatarLength = 70.0f;
static const UIEdgeInsets GPTimelineHeaderViewAvatarEdgeInsets = (UIEdgeInsets){0.0f, 15.0f, 10.0f, 8.0f};

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
    return (CGSize){CGRectGetWidth(self.superview.bounds), GPTimelineHeaderViewHeight};
}

- (void)didMoveToSuperview {
    NSAssert([self.superview isKindOfClass:[UIScrollView class]], @"Superview must be of class UIScrollView");
    
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    UIEdgeInsets newInset = scrollView.contentInset;
    newInset.top = GPTimelineHeaderViewHeight;
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
