/* ------------------------------------------------------------------------------------------------------
 GPTimelineCell.h
 
 Created by Giulio Petek on 28.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPCircleView.h"
#import "GPTimelineBubbleView.h"

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTimelineCell : UITableViewCell

+ (GPTimelineCell *)reusableCellFromTableView:(UITableView *)tableView;
   
@property (nonatomic, strong, readonly) GPCircleView *circleView;
@property (nonatomic, strong, readonly) GPTimelineBubbleView *timelineBubbleView;

@end
