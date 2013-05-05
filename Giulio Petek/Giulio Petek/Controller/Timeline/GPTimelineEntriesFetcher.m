/* ------------------------------------------------------------------------------------------------------
 
 GPTimelineEntriesFetcher.h
 
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
    NSArray *allBundlesInMain = [mainBundle pathsForResourcesOfType:@"entry.bundle" inDirectory:nil];
    
    NSMutableArray *allEntryNames = [NSMutableArray arrayWithCapacity:[allBundlesInMain count]];
    for (NSString *bundlePath in allBundlesInMain) {
        NSString *lastPathComponent = [bundlePath lastPathComponent];
        NSRange rangeOfEntryBundle = [lastPathComponent rangeOfString:@".entry.bundle"];

        if (rangeOfEntryBundle.location != NSNotFound) {
            [allEntryNames addObject:[lastPathComponent substringToIndex:rangeOfEntryBundle.location]];
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
                [allEntryNames removeLastObject];
                continue;
            }
        
            __block int i = 0;
            __block BOOL loopWasCancelled = NO;
            [sortedEntryNames enumerateObjectsUsingBlock:^(NSString *alreadyProcessedName, NSUInteger idx, BOOL *stop) {
                i = idx;

                NSString *alreadyProcessedDateString = datesForNames[alreadyProcessedName];
                if ([self _dateStringIsOlder:alreadyProcessedDateString than:currentDateString]) {
                    loopWasCancelled = YES;
                    *stop = YES;
                }
            }];
            if (!loopWasCancelled) { i = [sortedEntryNames count]; }
        
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
    return [GPTimelineEntriesFetcherIndexList count];
}

#pragma mark -
#pragma mark Fetch

- (GPTimelineEntry *)timelineEntryAtIndex:(NSUInteger)idx {    
    return [GPTimelineEntry timelineEntryNamed:GPTimelineEntriesFetcherIndexList[idx]];
}

- (void)fetchTimelineEntryAtIndex:(NSUInteger)idx andCallback:(GPTimelineEntriesFetcherCallback)callback {
    [self._entryFetchQueue addOperationWithBlock:^{
        GPTimelineEntry *timelineEntry = [self timelineEntryAtIndex:idx];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            callback(timelineEntry);
        }];
    }];
}

@end
