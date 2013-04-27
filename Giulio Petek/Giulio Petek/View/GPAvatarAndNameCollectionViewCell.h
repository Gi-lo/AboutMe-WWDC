/* ------------------------------------------------------------------------------------------------------
 GPAvatarAndNameCollectionViewCell.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#warning TODO
/*
 Create image factory ... layer properties ... no way ?
 */

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPAvatarAndNameCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak, readonly) UIImageView *avatarImageView;
@property (nonatomic, weak, readonly) UILabel *nameLabel;

@end
