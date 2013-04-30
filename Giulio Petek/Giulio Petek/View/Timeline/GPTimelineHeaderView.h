/* ------------------------------------------------------------------------------------------------------
 GPTimelineHeaderView.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPAboutMeButton.h"

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTimelineHeaderView : UIView

@property (nonatomic, weak, readonly) UIImageView *avatarImageView;
@property (nonatomic, weak, readonly) UIImageView *backgroundImageView;
@property (nonatomic, weak, readonly) GPAboutMeButton *aboutMeButton;

@end
