/* ------------------------------------------------------------------------------------------------------
 GPMediaAsset.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPMediaAsset.h"

/* --- typedef ---------------------------------------------------------------------------------------- */

typedef NS_ENUM(NSInteger, GPMediaAssetType) {
    GPMediaAssetTypePhoto = 0,
    GPMediaAssetTypeVideo
};

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPMediaAsset : NSObject

+ (instancetype)mediaAssetInTimelineEntryBundle:(NSBundle *)bundle;

@property (nonatomic, unsafe_unretained, readonly) GPMediaAssetType type;
@property (nonatomic, strong, readonly) NSString *filePath;

@end
