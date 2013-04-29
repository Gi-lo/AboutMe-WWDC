/* ------------------------------------------------------------------------------------------------------
 GPTimelineEntriesFetcher.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineEntry.h"

typedef void (^GPTimelineEntriesFetcherCallback)(GPTimelineEntry *timelineEntry);

extern NSString *const GPTimelineEntriesFetcherDidFinishMappingNotifiaction;

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPTimelineEntriesFetcher : NSObject

@property (nonatomic, unsafe_unretained, readonly, getter = isReady) BOOL ready;

- (NSUInteger)numberOfEntries;

- (void)fetchTimelineEntryAtIndex:(NSUInteger)idx andCallback:(GPTimelineEntriesFetcherCallback)callback;
- (GPTimelineEntry *)timelineEntryAtIndex:(NSUInteger)idx;

@end
