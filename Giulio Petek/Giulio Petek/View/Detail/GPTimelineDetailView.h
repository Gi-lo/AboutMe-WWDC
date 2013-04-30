/* ------------------------------------------------------------------------------------------------------
 GPTimelineDetailView.h
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPMediaAssetView.h"

/* --- protocol -------------------------------------------------------------------------------------- */

@class GPTimelineDetailView;
@protocol GPTimelineDetailViewActionDelegate <NSObject>

@optional
- (void)didPressURLButtonWithTitle:(NSString *)title inDetailView:(GPTimelineDetailView *)detailView;

@end

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTimelineDetailView : UIView

@property (nonatomic, weak) id <GPTimelineDetailViewActionDelegate> actionDelegate;
@property (nonatomic, weak, readonly) GPMediaAssetView *mediaAssetView;
@property (nonatomic, weak, readonly) UILabel *contentTextLabel;

- (void)appendButtonWithTitle:(NSString *)title;

@end
