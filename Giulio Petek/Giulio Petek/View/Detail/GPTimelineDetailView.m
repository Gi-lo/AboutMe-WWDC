/* ------------------------------------------------------------------------------------------------------
 GPTimelineDetailView.h
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineDetailView.h"
#import "GPURLButton.h"

#define MEDIA_ASSET_FRAME (CGRect){10.0f, 10.0f, CGRectGetWidth(self.bounds) - 20.0f, 150.0f}
#define CONTENT_LABEL_FRAME (CGRect) {10.0f, 10.0f + CGRectGetMaxY(MEDIA_ASSET_FRAME), CGRectGetWidth(self.bounds) - 20.0f, self._contentLabelHeight}
#define CONTENT_LABEL_MAX_SIZE (CGSize){CGRectGetWidth(CONTENT_LABEL_FRAME), MAXFLOAT}
#define BACKGROUND_IMAGE_INSETS (UIEdgeInsets){3.0f, 4.0f, 4.0f, 5.0f}
#define BUTTON_FRAME(idx) (CGRect){10.0f, CGRectGetMaxY(CONTENT_LABEL_FRAME) + 40.0f * ++idx, CGRectGetWidth(self.bounds) - 20.0f, 40.0f}

/* ------------------------------------------------------------------------------------------------------
 @interface GPTimelineDetailView ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineDetailView ()

@property (nonatomic, unsafe_unretained) CGFloat _contentLabelHeight;
@property (nonatomic, strong) NSPointerArray *_buttons;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineDetailView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineDetailView
@synthesize mediaAssetView = _mediaAssetView;
@synthesize contentTextLabel = _contentTextLabel;

#pragma mark -
#pragma mark Getter

- (GPMediaAssetView *)mediaAssetView {
    if (_mediaAssetView) {
        return _mediaAssetView;
    }
    
    GPMediaAssetView *mediaAssetView = [[GPMediaAssetView alloc] init];
    [self addSubview:mediaAssetView];
    
    _mediaAssetView = mediaAssetView;
    
    return _mediaAssetView;
}

- (UILabel *)contentTextLabel {
    if (_contentTextLabel) {
        return _contentTextLabel;
    }
    
    UILabel *contentTextLabel = [[UILabel alloc] init];
    contentTextLabel.numberOfLines = 0;
    contentTextLabel.textColor = [UIColor colorWithWhite:0.298f alpha:1.0f];
    [self addSubview:contentTextLabel];
    
    _contentTextLabel = contentTextLabel;
    
    return _contentTextLabel;
}

#pragma mark -
#pragma mark Buttons

- (void)appendButtonWithTitle:(NSString *)title {
    if (!self._buttons) {
        self._buttons = [NSPointerArray weakObjectsPointerArray];
    }
    
    GPURLButton *button = [[GPURLButton alloc] init];
    button.title = title;
    [button addTarget:self action:@selector(_pressedURLButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self._buttons addPointer:(__bridge void *)(button)];
    
    [self sizeToFit];
}

#pragma mark -
#pragma mark Actions

- (void)_pressedURLButton:(GPURLButton *)button {
    if ([self.actionDelegate respondsToSelector:@selector(didPressURLButtonWithTitle:inDetailView:)]) {
        [self.actionDelegate didPressURLButtonWithTitle:button.title inDetailView:self];
    }
}

#pragma mark -
#pragma mark Layout

- (CGSize)sizeThatFits:(CGSize)size {
    self._contentLabelHeight = [self.contentTextLabel sizeThatFits:CONTENT_LABEL_MAX_SIZE].height;

    NSInteger i = [self._buttons count] - 1;
    if (i < 0) {
        return (CGSize){300.0f, CGRectGetMaxY(CONTENT_LABEL_FRAME) + 10.0f};
    }
    
    return (CGSize){300.0f, CGRectGetMaxY(BUTTON_FRAME(i)) + 5.0f};
}

- (void)didMoveToSuperview {
    self.backgroundColor = [UIColor clearColor];

    [self sizeToFit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.mediaAssetView.frame = MEDIA_ASSET_FRAME;
    self.contentTextLabel.frame = CONTENT_LABEL_FRAME;

    [[self._buttons allObjects] enumerateObjectsUsingBlock:^(GPURLButton *button, NSUInteger idx, BOOL *stop) {
        button.frame = BUTTON_FRAME(idx);
    }];
}

#pragma mark - 
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {    
    UIImage *backgroundImage = [UIImage imageNamed:@"GPContentTextBackground"];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:BACKGROUND_IMAGE_INSETS resizingMode:UIImageResizingModeStretch];
    [backgroundImage drawInRect:self.bounds];
}

@end
