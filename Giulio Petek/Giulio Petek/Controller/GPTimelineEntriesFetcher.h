/* ------------------------------------------------------------------------------------------------------
 GPTimelineEntriesFetcher.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineEntry.h"

extern NSString *const GPTimelineEntriesFetcherDidFinishMappingNotifiaction;

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTimelineEntriesFetcher : NSObject

@property (nonatomic, unsafe_unretained, readonly, getter = isReady) BOOL ready;

- (NSUInteger)numberOfEntries;
- (GPTimelineEntry *)timelineEntryAtIndex:(NSUInteger)idx;

@end
