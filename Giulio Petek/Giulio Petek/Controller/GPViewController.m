/* ------------------------------------------------------------------------------------------------------
 GPViewController.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPViewController.h"
#import "GPTableHeaderView.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPViewController ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPViewController ()

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
    
    [self _configureHeaderView];
}

#pragma mark -
#pragma mark Configure View

- (void)_configureHeaderView {
    NSArray *images = @[
        [UIImage imageNamed:@"1318602514_bn_rhein_michael-sondermann_presseamt-bundesstadt-bonn.jpg"],
        [UIImage imageNamed:@"content_1321453764_hochschule_bonn-rhein-sieg-quellehochschule.jpg"]
    ];
    
    GPTableHeaderView *headerView = [[GPTableHeaderView alloc] initWithBackgroundImages:images
                                                                            avatarImage:[UIImage imageNamed:@"person01a.jpg"]
                                                                                andName:@"Giulio Petek"];
    [self.tableView setTableHeaderView:headerView];
    
    UIView *blackTopView = [[UIView alloc] initWithFrame:(CGRect){0.0f, -350.0f, CGRectGetWidth(self.tableView.bounds), 350.0f}];
    blackTopView.backgroundColor = [UIColor blackColor];
    [self.tableView addSubview:blackTopView];
    
}

@end
