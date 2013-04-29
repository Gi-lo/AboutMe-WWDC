/* ------------------------------------------------------------------------------------------------------
 GPMediaAssetView.h
 
 Created by Giulio Petek on 29.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPMediaAsset.h"
#import "GPPlayButton.h"

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPMediaAssetView : UIView

@property (nonatomic, weak, readonly) UIImageView *imageView;
@property (nonatomic, weak, readonly) GPPlayButton *playButton;
@property (nonatomic, unsafe_unretained) GPMediaAssetType type;

@end
