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
#import "GPTimelineDetailViewController.h"

#define CELL_HEIGHT 100.0f

typedef NS_ENUM(NSInteger, GPTimelineViewControllerSection) {
    GPTimelineViewControllerAboutMeSection = 0,
    GPTimelineViewControllerTimelineSection,
    GPTimelineViewControllerSectionNum
};

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineViewController ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineViewController ()

@property (nonatomic, unsafe_unretained, getter = _isShowingAboutMeText) BOOL _showAboutMeText;
@property (nonatomic, strong, readwrite) GPTimelineEntriesFetcher *_entriesFetcher;

- (void)_openAboutMe:(GPAboutMeButton *)button;
- (void)_timelineFetcherDidFinishMapping:(NSNotification *)notification;

- (UITableViewCell *)_aboutMeCell;
- (GPTimelineCell *)_timelineCellForIndexPath:(NSIndexPath *)indexPath;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineViewController
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineViewController

#pragma mark - 
#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[GPTimelineBackgroundView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    GPTimelineHeaderView *headerView = [[GPTimelineHeaderView alloc] init];
    headerView.backgroundImageView.image = [UIImage imageNamed:@"SunsetOverBonn"];
    headerView.aboutMeButton.title = @"Giulio Petek";
    [headerView.aboutMeButton addTarget:self action:@selector(_openAboutMe:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:headerView];
    
    self._entriesFetcher = [[GPTimelineEntriesFetcher alloc] init];
    if (![self._entriesFetcher isReady]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_timelineFetcherDidFinishMapping:)
                                                     name:GPTimelineEntriesFetcherDidFinishMappingNotifiaction
                                                   object:nil];
    }
}

#pragma mark -
#pragma mark Notification

- (void)_timelineFetcherDidFinishMapping:(NSNotification *)notification {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GPTimelineEntriesFetcherDidFinishMappingNotifiaction object:nil];
}

#pragma mark -
#pragma mark Actions

- (void)_openAboutMe:(GPAboutMeButton *)button {
    self._showAboutMeText = !self._isShowingAboutMeText;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:self._showAboutMeText ? UITableViewRowAnimationBottom : UITableViewRowAnimationTop];
}

#pragma mark - 
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return GPTimelineViewControllerSectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case GPTimelineViewControllerAboutMeSection: return self._isShowingAboutMeText; break;
        case GPTimelineViewControllerTimelineSection: return [self._entriesFetcher numberOfEntries]; break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == GPTimelineViewControllerAboutMeSection) {
        return [self _aboutMeCell];
    } else {
        return [self _timelineCellForIndexPath:indexPath];
    }
}

#pragma mark -
#pragma mark UITableViewCells 

- (UITableViewCell *)_aboutMeCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"ficken"];
    return cell;
}

- (GPTimelineCell *)_timelineCellForIndexPath:(NSIndexPath *)indexPath {
    GPTimelineCell *cell = [GPTimelineCell reusableCellFromTableView:self.tableView];
    cell.tag = indexPath.row;
    
    [self._entriesFetcher fetchTimelineEntryAtIndex:cell.tag
                                        andCallback:^(GPTimelineEntry *timelineEntry) {
                                            if (cell.tag != indexPath.row) {
                                                return;
                                            }
                                            
                                            cell.circleView.circleColor = [timelineEntry suggestedUIColor];
                                            cell.timelineBubbleView.titleLabel.text = timelineEntry.title;
                                            cell.timelineBubbleView.dateLabel.text = timelineEntry.dateString;
                                            cell.timelineBubbleView.textPreviewLabel.text = timelineEntry.previewText;
                                        }];
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GPTimelineEntry *timelineEntry = [self._entriesFetcher timelineEntryAtIndex:indexPath.row];
    GPTimelineDetailViewController *detailViewController = [[GPTimelineDetailViewController alloc] initWithTimelineEntry:timelineEntry];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
