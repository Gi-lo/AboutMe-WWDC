/* ------------------------------------------------------------------------------------------------------
 GPTimelineEntriesFetcher.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineEntriesFetcher.h"

NSString *const GPTimelineEntriesFetcherDidFinishMappingNotifiaction = @"GPTimelineEntriesFetcherDidFinishMappingNotifiaction";

static NSString *mainPath = nil;
static NSArray *months = nil;
static dispatch_once_t mainPathToken = 0;
static dispatch_once_t monthsToken = 0;

/* ------------------------------------------------------------------------------------------------------
 @interface GPTimelineEntriesFetcher ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineEntriesFetcher ()

@property (nonatomic, strong) NSCache *_entryCache;
@property (nonatomic, strong) NSOperationQueue *_entryFetchQueue;

+ (NSMutableArray *)_allEntryNames;
+ (BOOL)_dateStringIsOlder:(NSString *)firstString than:(NSString *)secondString;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineEntriesFetcher
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineEntriesFetcher

#pragma mark -
#pragma mark Load

+ (void)load {
    [self _mapNamesToIndices];
}

#pragma mark -
#pragma mark Mapping

static NSArray *GPTimelineEntriesFetcherIndexList = nil;

+ (NSMutableArray *)_allEntryNames {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSArray *allBundlesInMain = [mainBundle URLsForResourcesWithExtension:@"entry.bundle" subdirectory:nil];
    
    NSMutableArray *allEntryNames = [NSMutableArray arrayWithCapacity:[allBundlesInMain count]];
    for (NSURL *bundleURL in allBundlesInMain) {
        NSString *resourceSpecifier = [bundleURL resourceSpecifier];
        NSRange rangeOfEntryBundle = [resourceSpecifier rangeOfString:@".entry.bundle"];

        if (rangeOfEntryBundle.location != NSNotFound) {
            [allEntryNames addObject:[resourceSpecifier substringToIndex:rangeOfEntryBundle.location]];
        }
    }
    
    return allEntryNames;
}

+ (NSString *)_dateStringForEntryNamed:(NSString *)name {
    dispatch_once(&mainPathToken, ^{
        mainPath = [[NSBundle mainBundle] resourcePath];
    });
    
    NSBundle *timelineEntryBundle = [NSBundle bundleWithPath:[mainPath stringByAppendingFormat:@"/%@.entry.bundle", name]];
    NSData *plistData = [NSData dataWithContentsOfFile:[timelineEntryBundle pathForResource:@"Info" ofType:@"plist"]];
    NSDictionary *infoPlist = [NSPropertyListSerialization propertyListFromData:plistData
                                                               mutabilityOption:0
                                                                         format:0
                                                               errorDescription:nil];
    return [infoPlist objectForKey:@"date"];    
}

+ (void)_mapNamesToIndices {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{        
        NSMutableArray *allEntryNames = [self _allEntryNames];
        NSMutableDictionary *datesForNames = [NSMutableDictionary dictionaryWithCapacity:[allEntryNames count]];
        NSMutableArray *sortedEntryNames = [NSMutableArray arrayWithCapacity:[allEntryNames count]];
        
        while ([allEntryNames count]) {
            NSString *currentName = [allEntryNames lastObject];
            NSString *currentDateString = [self _dateStringForEntryNamed:currentName];
            if (![currentDateString length]) {
                continue;
            }
                        
            __block int i = 0;
            [sortedEntryNames enumerateObjectsUsingBlock:^(NSString *alreadyProcessedName, NSUInteger idx, BOOL *stop) {
                NSString *alreadyProcessedDateString = datesForNames[alreadyProcessedName];
                if ([self _dateStringIsOlder:alreadyProcessedDateString than:currentDateString]) {
                    *stop = YES;
                }
                
                if (idx == 0) { idx++; } i = idx;
            }];
                        
            [datesForNames setObject:currentDateString forKey:currentName];
            [sortedEntryNames insertObject:currentName atIndex:i];
            [allEntryNames removeLastObject];
        }
        
        GPTimelineEntriesFetcherIndexList = [sortedEntryNames copy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:GPTimelineEntriesFetcherDidFinishMappingNotifiaction object:nil];
        });
        
        mainPathToken = 0;
        mainPath = nil;
        monthsToken = 0;
        months = 0;
    });
}

+ (BOOL)_dateStringIsOlder:(NSString *)firstString than:(NSString *)secondString {
    NSArray *componentsOfFirstString = [firstString componentsSeparatedByString:@" "];
    if ([componentsOfFirstString count] != 2) {
        return NO;
    }
    
    NSArray *componentsOfSecondString = [secondString componentsSeparatedByString:@" "];
    if ([componentsOfSecondString count] != 2) {
        return NO;
    }
    
    int yearValueOfFirstString = [[componentsOfFirstString lastObject] intValue];
    int yearValueOfSecondString = [[componentsOfSecondString lastObject] intValue];
        
    if (yearValueOfFirstString > yearValueOfSecondString) {
        return NO;
    } else  if (yearValueOfFirstString < yearValueOfSecondString) {
        return YES;
    }
    
    dispatch_once(&monthsToken, ^{
        months = @[@"january", @"february", @"march", @"april", @"may", @"june", @"july", @"august", @"september", @"october", @"november", @"december"];
    });
    
    int monthValueOfFirstString = [months indexOfObject:[[componentsOfFirstString objectAtIndex:0] lowercaseString]];
    int monthValueOfSecondString = [months indexOfObject:[[componentsOfSecondString objectAtIndex:0] lowercaseString]];
    
    if (monthValueOfFirstString > monthValueOfSecondString) {
        return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark Init

- (instancetype)init {
    if ((self = [super init])) {
        self._entryCache = [[NSCache alloc] init];
        self._entryCache.name = @"GPTimelineEntriesFetcherEntryCache";
        
        self._entryFetchQueue = [[NSOperationQueue alloc] init];
        self._entryFetchQueue.name = @"GPTimelineEntriesFetcherEntryFetchQueue";
        self._entryFetchQueue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

#pragma mark -
#pragma mark Getter

- (BOOL)isReady {
    return GPTimelineEntriesFetcherIndexList ? YES : NO;
}

- (NSUInteger)numberOfEntries {
    if (!self.isReady) {
        NSLog(@"Requested timeline entry before mapping was done! Resgister for GPTimelineEntriesFetcherDidFinsihMappingNotifiaction if you want to be notified once its done.");
        
        return 0;
    }
    
    return [GPTimelineEntriesFetcherIndexList count];
}

#pragma mark -
#pragma mark Fetch

- (void)fetchTimelineEntryAtIndex:(NSUInteger)idx andCallback:(GPTimelineEntriesFetcherCallback)callback {
    if (!self.isReady) {
        NSLog(@"Requested timeline entry before mapping was done! Resgister for GPTimelineEntriesFetcherDidFinsihMappingNotifiaction if you want to be notified once its done.");
        callback(nil);
        return;
    }
    
    if ([GPTimelineEntriesFetcherIndexList count] < idx) {
        NSLog(@"Requested an entry at an index which is not there. Use <numberOfEntries> to avoid this error.");
        
        callback(nil);
        return;
    }
    
    __block GPTimelineEntry *timelineEntry = [self._entryCache objectForKey:@(idx)];
    if (timelineEntry) {
        callback(timelineEntry);
        return;
    }
    
    [self._entryFetchQueue addOperationWithBlock:^{
        timelineEntry = [GPTimelineEntry timelineEntryNamed:GPTimelineEntriesFetcherIndexList[idx]];
        
        if (timelineEntry) {
            [self._entryCache setObject:timelineEntry forKey:@(idx)];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(timelineEntry);
        });
    }];
}

@end
