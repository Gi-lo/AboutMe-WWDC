/* ------------------------------------------------------------------------------------------------------
 GPMediaAsset.m
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPMediaAsset.h"

static NSString *NSStringFromGPMediaAssetType(GPMediaAssetType type) {
    switch (type) {
        case GPMediaAssetTypeVideo: return @"Video"; break;
        case GPMediaAssetTypePhoto: return @"Photo"; break;
    }
    
    return nil;
}
/* ------------------------------------------------------------------------------------------------------
 @interface GPMediaAsset ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPMediaAsset ()

@property (nonatomic, strong, readwrite) NSString *filePath;
@property (nonatomic, unsafe_unretained, readwrite) GPMediaAssetType type;

@end

/* ------------------------------------------------------------------------------------------------------
 @implemention GPMediaAsset
 ------------------------------------------------------------------------------------------------------ */

@implementation GPMediaAsset

#pragma mark -
#pragma mark Init

+ (instancetype)mediaAssetInTimelineEntryBundle:(NSBundle *)bundle {
    GPMediaAsset *asset = [[GPMediaAsset alloc] init];
    
    NSString *basePath = [[bundle resourcePath] stringByAppendingPathComponent:@"MediaAsset"];
    
    NSArray *supportedVideoFormats = @[@"mov", @"mp4"];
    for (NSString *videoFormat in supportedVideoFormats) {
        NSString *filePath = [basePath stringByAppendingPathExtension:videoFormat];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            asset.filePath = filePath;
            asset.type = GPMediaAssetTypeVideo;
            break;
        }
    }
    
    NSArray *supportedImageFormats = @[@"png", @"jpg", @"jpeg"];
    for (NSString *imageFormat in supportedImageFormats) {
        NSString *filePath = [basePath stringByAppendingPathExtension:imageFormat];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            asset.filePath = filePath;
            asset.type = GPMediaAssetTypePhoto;
            break;
        }
    }

    return asset;
}

#pragma mark -
#pragma mark Preview Image

- (UIImage *)previewImage {
    if (self.type == GPMediaAssetTypePhoto) {
        return [UIImage imageWithContentsOfFile:self.filePath];
    }
    
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.filePath]];
    return [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
}

#pragma mark -
#pragma mark Debug

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@, <Type: %@>]", [super description], NSStringFromGPMediaAssetType(self.type)];

}
@end
