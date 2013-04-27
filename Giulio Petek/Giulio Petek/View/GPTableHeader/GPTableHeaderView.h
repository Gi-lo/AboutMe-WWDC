/* ------------------------------------------------------------------------------------------------------
 GPTableHeaderView.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

@class GPTableHeaderView;
@protocol GPTableHeaderViewDelegate <NSObject>

- (void)didSwitchToPageNumber:(NSUInteger)integer inHeaderView:(GPTableHeaderView *)headerView;

@end

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTableHeaderView : UICollectionView

- (instancetype)initWithBackgroundImage:(UIImage *)image;

@end
