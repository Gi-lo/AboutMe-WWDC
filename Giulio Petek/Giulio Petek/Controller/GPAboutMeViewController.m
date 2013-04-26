/* ------------------------------------------------------------------------------------------------------
 GPAboutMeViewController.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAboutMeViewController.h"
#import "GPAboutMeTableView.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPAboutMeViewController ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPAboutMeViewController ()

@property (nonatomic, weak) GPAboutMeTableView *_tableView;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPAboutMeViewController
 ------------------------------------------------------------------------------------------------------ */

@implementation GPAboutMeViewController

#pragma mark -
#pragma mark UIViewController

- (void)loadView {
    GPAboutMeTableView *tableView = [[GPAboutMeTableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]
                                                                        style:UITableViewStylePlain];
    self.view = tableView;
}

#pragma mark -
#pragma mark Getter

- (GPAboutMeTableView *)view {
    return (GPAboutMeTableView *)[super view];
}

@end
