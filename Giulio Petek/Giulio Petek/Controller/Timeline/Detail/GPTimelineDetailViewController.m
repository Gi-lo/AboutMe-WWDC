/* ------------------------------------------------------------------------------------------------------
 GPTimelineDetailViewController.m
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineDetailViewController.h"
#import "GPNavigationBar.h"

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineDetailViewController ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineDetailViewController () <GPNavigationBarDelegate>

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
    UIView *container = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    container.backgroundColor = [UIColor colorWithWhite:0.902f alpha:1.0f];
    self.view = container;

    GPNavigationBar *navigationBar = [[GPNavigationBar alloc] init];
    navigationBar.delegate = self;
    navigationBar.titleLabel.text = self._timelineEntry.title;
    navigationBar.lineColor = [self._timelineEntry suggestedUIColor];
    [container addSubview:navigationBar];
}

#pragma mark -
#pragma mark GPNavigationBarDelegate

- (void)didPressBackButtonInNavigationBar:(GPNavigationBar *)navigationBar {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
