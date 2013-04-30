/* ------------------------------------------------------------------------------------------------------
 GPNavigationBar.h
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

/* --- protocol --------------------------------------------------------------------------------------- */

@class GPNavigationBar;
@protocol GPNavigationBarDelegate <NSObject>

- (void)didPressBackButtonInNavigationBar:(GPNavigationBar *)navigationBar;

@end

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPNavigationBar : UIView

@property (nonatomic, weak, readonly) UILabel *titleLabel;
@property (nonatomic, weak) id <GPNavigationBarDelegate> delegate;
@property (nonatomic, strong) UIColor *lineColor;

@end
