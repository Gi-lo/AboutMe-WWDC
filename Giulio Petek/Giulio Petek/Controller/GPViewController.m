/* ------------------------------------------------------------------------------------------------------
 GPViewController.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPViewController.h"
#import "GPTableHeaderView.h"
#import "GPTableHeaderDataSource.h"

typedef NS_ENUM(NSInteger, GPViewControllerState) {
    GPViewControllerStateAboutMe = 0,
    GPViewControllerStateResume
};

/* ------------------------------------------------------------------------------------------------------
 @interface GPViewController ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPViewController ()

@property (nonatomic, strong) GPTableHeaderDataSource *_headerDataSource;
@property (nonatomic, unsafe_unretained) GPViewControllerState _currentState;

- (void)_configureHeaderView;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPViewController
 ------------------------------------------------------------------------------------------------------ */

@implementation GPViewController

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self _configureHeaderView];
}

#pragma mark -
#pragma mark Configure View

- (void)_configureHeaderView {    
    GPTableHeaderView *headerView = [[GPTableHeaderView alloc] initWithBackgroundImage:[UIImage imageNamed:@"1318602514_bn_rhein_michael-sondermann_presseamt-bundesstadt-bonn.jpg"]];
    GPTableHeaderDataSource *dataSource = [[GPTableHeaderDataSource alloc] initWithHeaderView:headerView];
    headerView.dataSource = dataSource;
    self._headerDataSource = dataSource;
    [self.tableView setTableHeaderView:headerView];
    
    UIView *blackTopView = [[UIView alloc] initWithFrame:(CGRect){0.0f, -350.0f, CGRectGetWidth(self.tableView.bounds), 350.0f}];
    blackTopView.backgroundColor = [UIColor blackColor];
    [self.tableView addSubview:blackTopView];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self._currentState == GPViewControllerStateAboutMe) {
        return 1;
    }
    
    return 0; // TODO:
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}


@end
