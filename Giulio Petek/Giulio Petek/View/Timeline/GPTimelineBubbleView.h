/* ------------------------------------------------------------------------------------------------------
 GPTimelineBubbleView.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTimelineBubbleView : UIView

@property (nonatomic, weak, readonly) UILabel *titleLabel;
@property (nonatomic, weak, readonly) UILabel *dateLabel;
@property (nonatomic, weak, readonly) UILabel *textPreviewLabel;

@end
