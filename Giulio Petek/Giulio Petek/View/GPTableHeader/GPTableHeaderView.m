/* ------------------------------------------------------------------------------------------------------
 GPTableHeaderView.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableHeaderView.h"
#import "GPTableHeaderBackgroundImageView.h"
#import "GPTableHeaderViewContentView.h"

static CGFloat const GPTableHeaderViewHeight = 120.0f;

/* ------------------------------------------------------------------------------------------------------
 @interface GPTableHeaderView ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTableHeaderView ()

@property (nonatomic, weak) GPTableHeaderViewContentView *_contentView;
@property (nonatomic, weak) GPTableHeaderBackgroundImageView *_backgroundImageView;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTableHeaderView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableHeaderView

#pragma mark -
#pragma mark Init

- (instancetype)initWithBackgroundImages:(NSArray *)images avatarImage:(UIImage *)avatar andName:(NSString *)name {
    if ((self = [super init])) {
        self._backgroundImageView.animationImages = images;
        self._contentView.avatarImageView.image = avatar;
        self._contentView.nameLabel.text = name;
        
        self.backgroundColor = [UIColor blackColor];
    }
    
    return self;
}

#pragma mark -
#pragma mark Getter

- (GPTableHeaderBackgroundImageView *)_backgroundImageView {
    if (__backgroundImageView) {
        return __backgroundImageView;
    }
    
    GPTableHeaderBackgroundImageView *imageView = [[GPTableHeaderBackgroundImageView alloc] init];
    [imageView setAnimationDuration:20.0f];
    [self addSubview:imageView];
    
    __backgroundImageView = imageView;
    
    return __backgroundImageView;
}

- (GPTableHeaderViewContentView *)_contentView {
    if (__contentView) {
        return __contentView;
    }
    
    GPTableHeaderViewContentView *contentView = [[GPTableHeaderViewContentView alloc] init];
    [self addSubview:contentView];
    
    __contentView = contentView;
    
    return __contentView;
}

#pragma mark -
#pragma mark Layout

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self sizeToFit];
    
    [self._backgroundImageView startAnimating];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [self._backgroundImageView stopAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self._backgroundImageView.frame = self.bounds;
    self._contentView.frame = self.bounds;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return (CGSize){CGRectGetWidth(self.superview.frame), GPTableHeaderViewHeight};
}

@end
