/* ------------------------------------------------------------------------------------------------------
 
 GPTimelineDetailViewController.m
 
 Created by Giulio Petek on 30.04.13.
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

#import "GPTimelineDetailViewController.h"
#import "GPNavigationBar.h"
#import "GPTimelineDetailView.h"
#import "GPWebViewController.h"

#define DETAIL_VIEW_FRAME (CGRect){10.0f, 10.0f, 0.0f, 0.0f}
#define SCROLL_VIEW_FRAME (CGRect){ 0.0f, CGRectGetHeight(navigationBar.bounds), CGRectGetWidth(container.bounds),  CGRectGetHeight(container.bounds) - CGRectGetHeight(navigationBar.bounds)}
#define SCOLL_VIEW_CONTENT_SIZE (CGSize){CGRectGetWidth(container.bounds), CGRectGetMaxY(detailView.frame) + CGRectGetMinY(DETAIL_VIEW_FRAME)}

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
    navigationBar.lineColor = [self._timelineEntry suggestedUIColor];
    navigationBar.delegate = self;
    navigationBar.titleLabel.text = self._timelineEntry.title;
    [container addSubview:navigationBar];
    
    GPTimelineDetailView *detailView = [[GPTimelineDetailView alloc] initWithFrame:DETAIL_VIEW_FRAME];
    detailView.contentTextLabel.text = self._timelineEntry.text;
    detailView.actionDelegate = self;
    [detailView.mediaAssetView.playButton addTarget:self action:@selector(_didTapVideoButton:) forControlEvents:UIControlEventTouchUpInside];
    detailView.mediaAssetView.type = self._timelineEntry.mediaAsset.type;
    detailView.mediaAssetView.imageView.image = [self._timelineEntry.mediaAsset previewImage];
    detailView.mediaAssetView.playButton.circleColor = [self._timelineEntry suggestedUIColor];
    for (NSString *buttonTitle in [self._timelineEntry.urls allKeys]) { [detailView appendButtonWithTitle:buttonTitle]; }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:SCROLL_VIEW_FRAME];
    [scrollView addSubview:detailView];
    scrollView.contentSize = SCOLL_VIEW_CONTENT_SIZE;
    [container addSubview:scrollView];

    self.view = container;
}

#pragma mark -
#pragma mark Actions

- (void)_didTapVideoButton:(GPPlayButton *)button {
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:self._timelineEntry.mediaAsset.videoURL];
    [self presentMoviePlayerViewControllerAnimated:moviePlayer];
}

#pragma mark -
#pragma mark GPTimelineDetailViewActionDelegate

- (void)didPressURLButtonWithTitle:(NSString *)title inDetailView:(GPTimelineDetailView *)detailView {
    NSURL *url = [NSURL URLWithString:[self._timelineEntry.urls objectForKey:title]];
    GPWebViewController *webController = [[GPWebViewController alloc] initWithURL:url];

    [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:webController] animated:YES completion:nil];
}

#pragma mark -
#pragma mark GPNavigationBarDelegate

- (void)didPressBackButtonInNavigationBar:(GPNavigationBar *)navigationBar {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
