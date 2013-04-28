/* ------------------------------------------------------------------------------------------------------
 GPTimelineEntry.m
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTimelineEntry.h"

static NSString *const GPTimelineEntryDateStringKey = @"date";
static NSString *const GPTimelineEntryTitleKey = @"title";
static NSString *const GPTimelineEntryTextKey = @"text";
static NSString *const GPTimelineEntryURLsKey = @"urls";
static NSString *const GPTimelineEntryTypeKey = @"type";

static NSString *const GPTimelineEntryTypeEducationString = @"education";
static NSString *const GPTimelineEntryTypeProfessionString = @"profession";

static GPTimelineEntryType GPTimelineEntryTypeFromString(NSString *string) {
    string = [string lowercaseString];
    
    if ([string isEqualToString:GPTimelineEntryTypeEducationString]) {
        return GPTimelineEntryTypeEducation;
    } else if ([string isEqualToString:GPTimelineEntryTypeProfessionString]) {
        return GPTimelineEntryTypeProfession;
    }
    
    return -1;
}

static NSString *NSStringFromGPTimelineEntryType(GPTimelineEntryType type) {
    switch (type) {
        case GPTimelineEntryTypeEducation: return GPTimelineEntryTypeEducationString; break;
        case GPTimelineEntryTypeProfession: return GPTimelineEntryTypeProfessionString; break;
    }
    
    return nil;
}

/* ------------------------------------------------------------------------------------------------------
 @interface GPTimelineEntry ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineEntry ()

@property (nonatomic, unsafe_unretained, readwrite) GPTimelineEntryType type;
@property (nonatomic, strong, readwrite) NSDate *dateString;
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSString *text;
@property (nonatomic, strong, readwrite) NSDictionary *urls;
@property (nonatomic, strong, readwrite) GPMediaAsset *mediaAsset;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTimelineEntry
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTimelineEntry

#pragma mark -
#pragma mark Init

+ (instancetype)timelineEntryNamed:(NSString *)name {
    NSBundle *timelineEntryBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@.entry.bundle", name]];
    if (!timelineEntryBundle) {
        return nil;
    }
    
    NSData *plistData = [NSData dataWithContentsOfFile:[timelineEntryBundle pathForResource:@"Info" ofType:@"plist"]];
    NSDictionary *infoPlist = [NSPropertyListSerialization propertyListFromData:plistData
                                                               mutabilityOption:0
                                                                         format:0
                                                               errorDescription:nil];
    
    GPTimelineEntry *entry = [[GPTimelineEntry alloc] init];
    entry.dateString = infoPlist[GPTimelineEntryDateStringKey];
    entry.title = infoPlist[GPTimelineEntryTitleKey];
    entry.text = infoPlist[GPTimelineEntryTextKey];
    entry.urls = infoPlist[GPTimelineEntryURLsKey];
    entry.type = GPTimelineEntryTypeFromString(infoPlist[GPTimelineEntryTypeKey]);
    entry.mediaAsset = [GPMediaAsset mediaAssetInTimelineEntryBundle:timelineEntryBundle];
    
    return entry;
}

#pragma mark -
#pragma mark Debug

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@, <Title: %@>, <DateString: %@>, <Type: %@>, <Asset: %@>]", [super description], self.title, self.dateString, NSStringFromGPTimelineEntryType(self.type), self.mediaAsset];
}

@end