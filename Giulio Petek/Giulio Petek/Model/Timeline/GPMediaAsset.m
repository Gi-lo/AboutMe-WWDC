/* ------------------------------------------------------------------------------------------------------

 GPMediaAsset.m
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
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
        previewImageName = [previewImageName stringByAppendingString:([[UIScreen mainScreen] scale] == 2.0 ? @"@2x" : @"")];
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
