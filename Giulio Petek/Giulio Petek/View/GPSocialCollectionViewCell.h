//
//  GPSocialCollectionViewCell.h
//  Giulio Petek
//
//  Created by Giulio Petek on 27.04.13.
//  Copyright (c) 2013 grandcentrix. All rights reserved.
//

@interface GPSocialCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) dispatch_block_t onPressedTwitter;
@property (nonatomic, copy) dispatch_block_t onPressedGithub;
@property (nonatomic, copy) dispatch_block_t onPressedMail;
@property (nonatomic, copy) dispatch_block_t onPressedWebsite;

@end
