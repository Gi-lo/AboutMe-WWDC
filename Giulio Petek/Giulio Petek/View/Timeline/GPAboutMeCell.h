/* ------------------------------------------------------------------------------------------------------
 GPAboutMeButton.h
 
 Created by Giulio Petek on 1.05.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPAboutMeCell : UITableViewCell

+ (GPAboutMeCell *)reusableCellFromTableView:(UITableView *)tableView;

@property (nonatomic, weak, readonly) UITextView *contentTextView;

@end
