/* ------------------------------------------------------------------------------------------------------
 GPTimelineEntry.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPMediaAsset.h"

/* --- typedef ---------------------------------------------------------------------------------------- */

typedef NS_ENUM(NSInteger, GPTimelineEntryType) {
    GPTimelineEntryTypeEducation = 0,
    GPTimelineEntryTypeProfession
    // ...
};

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTimelineEntry : NSObject

+ (instancetype)timelineEntryNamed:(NSString *)name;

@property (nonatomic, unsafe_unretained, readonly) GPTimelineEntryType type;
@property (nonatomic, strong, readonly) NSDate *dateString;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSDictionary *urls;
@property (nonatomic, strong, readonly) GPMediaAsset *mediaAsset;

@end
