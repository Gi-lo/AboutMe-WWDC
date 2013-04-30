/* ------------------------------------------------------------------------------------------------------
 GPTimelineDetailViewController.h
 
 Created by Giulio Petek on 30.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineEntry.h"

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTimelineDetailViewController : UIViewController

- (instancetype)initWithTimelineEntry:(GPTimelineEntry *)entry;

@end
