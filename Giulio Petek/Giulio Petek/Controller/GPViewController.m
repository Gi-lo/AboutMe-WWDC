/* ------------------------------------------------------------------------------------------------------
 GPViewController.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPViewController.h"
#import "GPTableViewHeaderView.h"
#import "GPTableViewHeaderViewDataSource.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPViewController ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPViewController ()

@property (nonatomic, strong) GPTableViewHeaderViewDataSource *_headerDataSource;

- (void)_configureTableView;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPViewController
 ------------------------------------------------------------------------------------------------------ */

@implementation GPViewController

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _configureTableView];
}

#pragma mark -
#pragma mark Configure View

- (void)_configureTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    
    GPTableViewHeaderView *headerView = [[GPTableViewHeaderView alloc] init];
    self._headerDataSource = [[GPTableViewHeaderViewDataSource alloc] initWithHeaderView:headerView];
    
    headerView.dataSource = self._headerDataSource;
    self.tableView.tableHeaderView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
}

@end
