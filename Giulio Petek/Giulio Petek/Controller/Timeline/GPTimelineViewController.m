/* ------------------------------------------------------------------------------------------------------
 GPTimelineViewController.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineViewController.h"
#import "GPTimelineEntriesFetcher.h"
#import "GPTimelineCell.h"
#import "GPTimelineBackgroundView.h"
#import "GPTimelineHeaderView.h"
#import "GPBonnSource.h"

static CGFloat const GPTimelineViewControllerCellHeight = 100.0f;

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineViewController ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineViewController ()

@property (nonatomic, strong, readwrite) GPTimelineEntriesFetcher *_entriesFetcher;

- (void)_configureTableView;
- (void)_openAboutMe:(GPAboutMeButton *)button;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineViewController
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineViewController

#pragma mark - 
#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureTableView];
    
    self._entriesFetcher = [[GPTimelineEntriesFetcher alloc] init];
    if (![self._entriesFetcher isReady]) {
        [[NSNotificationCenter defaultCenter] addObserver:self.tableView
                                                 selector:@selector(reloadData)
                                                     name:GPTimelineEntriesFetcherDidFinishMappingNotifiaction
                                                   object:nil];
    }
}

#pragma mark -
#pragma mark Configure

- (void)_configureTableView {
    self.tableView.backgroundView = [[GPTimelineBackgroundView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *fakeOverlay = [[UIView alloc] initWithFrame:(CGRect){0.0f, -347.0f, CGRectGetWidth(self.tableView.bounds), 350.0f}];
    fakeOverlay.backgroundColor = [UIColor blackColor];
    [self.tableView addSubview:fakeOverlay];
    
    GPTimelineHeaderView *headerView = [[GPTimelineHeaderView alloc] init];
    headerView.backgroundView.animationImages = [GPBonnSource allImages];
    headerView.aboutMeButton.title = @"Giulio Petek";
    [headerView.aboutMeButton addTarget:self action:@selector(_openAboutMe:) forControlEvents:UIControlEventTouchUpInside];
    [headerView sizeToFit];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark -
#pragma mark Actions

- (void)_openAboutMe:(GPAboutMeButton *)button {
    // ... 
}

#pragma mark - 
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self._entriesFetcher isReady] ? [self._entriesFetcher numberOfEntries] : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return GPTimelineViewControllerCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPTimelineCell *cell = [GPTimelineCell reusableCellFromTableView:tableView];
    cell.tag = indexPath.row;
    
    [self._entriesFetcher fetchTimelineEntryAtIndex:cell.tag
                                        andCallback:^(GPTimelineEntry *timelineEntry) {
                                            if (cell.tag != indexPath.row) {
                                                return;
                                            }
                                            
                                            cell.circleView.circleColor = [timelineEntry suggestedUIColor];
                                            cell.timelineBubbleView.titleLabel.text = timelineEntry.title;
                                            cell.timelineBubbleView.dateLabel.text = timelineEntry.dateString;
                                            cell.timelineBubbleView.textPreviewLabel.text = timelineEntry.text;
                                        }];
    
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
