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

static NSString *urlEscapeString(NSString *string) {
    NSString *encodedstring = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)string, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return encodedstring;
}

/* ------------------------------------------------------------------------------------------------------
 @interface GPMediaAsset ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPMediaAsset ()

@property (nonatomic, strong, readwrite) NSURL *videoURL;
@property (nonatomic, strong) NSString *_previewImagePath;
@property (nonatomic, unsafe_unretained, readwrite) GPMediaAssetType type;

@end

/* ------------------------------------------------------------------------------------------------------
 @implemention GPMediaAsset
 ------------------------------------------------------------------------------------------------------ */

@implementation GPMediaAsset

#pragma mark -
#pragma mark Init

+ (instancetype)mediaAssetForAssociatedBundle:(NSBundle *)bundle andVideoURLString:(NSString *)urlString {
    GPMediaAsset *asset = [[GPMediaAsset alloc] init];
    
    NSString *previewImageName = @"Preview";
    if ([[UIScreen mainScreen] scale]) {
        previewImageName = [previewImageName stringByAppendingString:([[UIScreen mainScreen] scale] == 2.0 ? @"@2x" : nil)];
    }
    
    asset._previewImagePath = [bundle pathForResource:previewImageName ofType:@"png"];
    asset.videoURL = [urlString length] ? [NSURL URLWithString:urlString] : nil;
    
    return asset;
}

#pragma mark -
#pragma mark Preview Image

- (UIImage *)previewImage {
    return [UIImage imageWithContentsOfFile:self._previewImagePath];
}

#pragma mark -
#pragma mark - Getter

- (GPMediaAssetType)type {
    return self.videoURL ? GPMediaAssetTypeVideo : GPMediaAssetTypePhoto;
}

#pragma mark -
#pragma mark Debug

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@, <Type: %@>]", [super description], NSStringFromGPMediaAssetType(self.type)];

}
@end
