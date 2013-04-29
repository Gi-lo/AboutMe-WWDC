/* ------------------------------------------------------------------------------------------------------
 GPTimelineDetailViewController.m
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineDetailViewController.h"
#import "GPNavigationBar.h"
#import "GPTimelineDetailView.h"

static CGFloat const GPTimelineDetailViewControllerViewMargin = 10.0f;

/* ------------------------------------------------------------------------------------------------------
 @interface GPTimelineDetailViewController ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineDetailViewController () <GPNavigationBarDelegate, GPTimelineDetailViewActionDelegate>

@property (nonatomic, strong) GPTimelineEntry *_timelineEntry;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineDetailViewController
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineDetailViewController

#pragma mark - 
#pragma mark Init

- (instancetype)initWithTimelineEntry:(GPTimelineEntry *)entry {
    if ((self = [super init])) {
        __timelineEntry = entry;
    }
    
    return self;
}

#pragma mark -
#pragma mark UIViewController

- (void)loadView {
    UIView *container = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    container.backgroundColor = [UIColor colorWithWhite:0.902f alpha:1.0f];

    GPNavigationBar *navigationBar = [[GPNavigationBar alloc] init];
    navigationBar.lineColor = [UIColor orangeColor];
    navigationBar.delegate = self;
    navigationBar.titleLabel.text = self._timelineEntry.title;
    [container addSubview:navigationBar];
    
    GPTimelineDetailView *detailView = [[GPTimelineDetailView alloc] initWithFrame:(CGRect){
        GPTimelineDetailViewControllerViewMargin, GPTimelineDetailViewControllerViewMargin, 0.0f, 0.0f
    }];
    detailView.contentTextLabel.text = self._timelineEntry.text;
    detailView.actionDelegate = self;
    for (NSString *buttonTitle in [self._timelineEntry.urls allKeys]) { [detailView appendButtonWithTitle:buttonTitle]; }
    [detailView.mediaAssetView.playButton addTarget:self
                                             action:@selector(_didTapVideoButton:)
                                   forControlEvents:UIControlEventTouchUpInside];
    detailView.mediaAssetView.type = self._timelineEntry.type;
    detailView.mediaAssetView.imageView.image = [self._timelineEntry.mediaAsset previewImage];
    detailView.mediaAssetView.playButton.circleColor = [self._timelineEntry suggestedUIColor];
    
    CGRect scrollViewFrame = container.bounds;
    scrollViewFrame.size.height -= CGRectGetHeight(navigationBar.bounds);
    scrollViewFrame.origin.y += CGRectGetHeight(navigationBar.bounds);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    [scrollView addSubview:detailView];
    scrollView.contentSize = (CGSize){CGRectGetWidth(container.bounds), CGRectGetMaxY(detailView.frame) + GPTimelineDetailViewControllerViewMargin};
    [container addSubview:scrollView];

    self.view = container;
}

#pragma mark -
#pragma mark Actions

- (void)_didTapVideoButton:(GPPlayButton *)button {
    NSLog(@"video");
}

#pragma mark -
#pragma mark GPTimelineDetailViewActionDelegate

- (void)didPressButtonWithTitle:(NSString *)title inDetailView:(GPTimelineDetailView *)detailView {
    NSURL *url = [self._timelineEntry.urls objectForKey:title];
    NSLog(@"%@", url);
}

#pragma mark -
#pragma mark GPNavigationBarDelegate

- (void)didPressBackButtonInNavigationBar:(GPNavigationBar *)navigationBar {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
