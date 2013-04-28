/* ------------------------------------------------------------------------------------------------------
 GPBonnSource.m
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPBonnSource.h"

/* ------------------------------------------------------------------------------------------------------
 @implementation GPBonnSource
 ------------------------------------------------------------------------------------------------------ */

@implementation GPBonnSource

#pragma mark -
#pragma mark Images

+ (NSArray *)allImages {
    NSBundle *bonnBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Bonn" ofType:@"bundle"]];
    NSArray *imagePaths = [bonnBundle pathsForResourcesOfType:@"png" inDirectory:@"Images"];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[imagePaths count]];
    for (NSString *path in imagePaths) {
        [images addObject:[UIImage imageWithContentsOfFile:path]];
    }
    
    return images;
} 

@end
