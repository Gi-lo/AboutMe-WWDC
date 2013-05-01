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
#import "GPAboutMeCell.h"

#define TIMELINE_CELL_HEIGHT 100.0f
#define ABOUT_CELL_HEIGHT 310.0f

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
@property (nonatomic, weak) GPTimelineHeaderView *_headerView;

- (void)_openAboutMe:(GPAboutMeButton *)button;
- (void)_timelineFetcherDidFinishMapping:(NSNotification *)notification;

- (GPAboutMeCell *)_aboutMeCell;
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
    self._headerView = headerView;
    
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
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationBottom];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GPTimelineEntriesFetcherDidFinishMappingNotifiaction object:nil];
}

#pragma mark -
#pragma mark Actions

- (void)_openAboutMe:(GPAboutMeButton *)button {
    self._showAboutMeText = !self._isShowingAboutMeText;
    self._headerView.aboutMeButton.direction = self._showAboutMeText ? GPAboutMeButtonArrowDirectionPointingUp : GPAboutMeButtonArrowDirectionPointingDown;
   
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
    switch (indexPath.section) {
        case GPTimelineViewControllerAboutMeSection: return ABOUT_CELL_HEIGHT; break;
        case GPTimelineViewControllerTimelineSection: return TIMELINE_CELL_HEIGHT; break;
    }
    
    return 0;
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

- (GPAboutMeCell *)_aboutMeCell {
    GPAboutMeCell *cell = [GPAboutMeCell reusableCellFromTableView:self.tableView];
    cell.contentTextLabel.text = @"Hello, my name is Giulio Petek and I am a 20-years-old computer science student from the former capital of Germany, Bonn.\n\nI currently work at grandcentrix where I develop iPhone and iPad Applications for larger companies. Besides developing I love going out and have fun with friends. I am also fascinated by soccer as well as tablesoccer.\n\nEmail:       giulio.petek@grandcentrix.net\nGithub:     http://github.com/gi-lo\nTwitter:    http://twitter.com/GiloTM\nWebsite:  giuliopetek.com\nMobile:    +49 0176 31150339";
    
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == GPTimelineViewControllerAboutMeSection) {
        return nil;
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    GPTimelineEntry *timelineEntry = [self._entriesFetcher timelineEntryAtIndex:indexPath.row];
    GPTimelineDetailViewController *detailViewController = [[GPTimelineDetailViewController alloc] initWithTimelineEntry:timelineEntry];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
