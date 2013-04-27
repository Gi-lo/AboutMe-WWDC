/* ------------------------------------------------------------------------------------------------------
 GPTableHeaderDataSource.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableHeaderView.h"

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTableHeaderDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithHeaderView:(GPTableHeaderView *)headerView;

@end
