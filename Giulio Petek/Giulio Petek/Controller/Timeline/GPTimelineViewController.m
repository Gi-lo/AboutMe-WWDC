/* ------------------------------------------------------------------------------------------------------
 
 GPTimelineViewController.h
 
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
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    
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
    cell.contentTextView.text = @"Hello, my name is Giulio Petek and I am a 20-year-old computer science student from the former capital of Germany, Bonn.\n\nI currently work at grandcentrix where I develop iPhone and iPad applications for large companies. Besides development I love to go out and have fun with friends in games such as soccer and foosball.\n\nEmail:     giulio.petek@grandcentrix.net\nGithub:   http://github.com/gi-lo\nTwitter:   http://twitter.com/GiloTM\nWebsite: giuliopetek.com\nMobile:  +49 0176 31150339";
    
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
