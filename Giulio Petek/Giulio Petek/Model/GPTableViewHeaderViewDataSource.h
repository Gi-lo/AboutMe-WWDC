/* ------------------------------------------------------------------------------------------------------
 GPTableView.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableViewHeaderView.h"

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTableViewHeaderViewDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithHeaderView:(GPTableViewHeaderView *)headerView;

@end
