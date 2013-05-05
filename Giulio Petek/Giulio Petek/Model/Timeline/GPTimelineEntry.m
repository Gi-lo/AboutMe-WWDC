/* ------------------------------------------------------------------------------------------------------

 GPTimelineEntry.m
 
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

#import "GPTimelineEntry.h"

static NSString *const GPTimelineEntryDateStringKey = @"date";
static NSString *const GPTimelineEntryTitleKey = @"title";
static NSString *const GPTimelineEntryTextKey = @"text";
static NSString *const GPTimelineEntryURLsKey = @"urls";
static NSString *const GPTimelineEntryTypeKey = @"type";
static NSString *const GPTimelineEntryPreviewKey = @"previewText";
static NSString *const GPTimelineEntryVideoURLKey = @"videoURL";

static NSString *const GPTimelineEntryTypeEducationString = @"education";
static NSString *const GPTimelineEntryTypeProfessionString = @"profession";
static NSString *const GPTimelineEntryTypePrivateString = @"private";
static NSString *const GPTimelineEntryTypeOthersString = @"other";

static GPTimelineEntryType GPTimelineEntryTypeFromString(NSString *string) {
    string = [string lowercaseString];
    
    if ([string isEqualToString:GPTimelineEntryTypeEducationString]) {
        return GPTimelineEntryTypeEducation;
    } else if ([string isEqualToString:GPTimelineEntryTypeProfessionString]) {
        return GPTimelineEntryTypeProfession;
    } else if ([string isEqualToString:GPTimelineEntryTypePrivateString]) {
        return GPTimelineEntryTypePrivate;
    } else if ([string isEqualToString:GPTimelineEntryTypeOthersString]) {
        return GPTimelineEntryTypeOthers;
    }

    return -1;
}

static NSString *NSStringFromGPTimelineEntryType(GPTimelineEntryType type) {
    switch (type) {
        case GPTimelineEntryTypeEducation: return GPTimelineEntryTypeEducationString; break;
        case GPTimelineEntryTypePrivate: return GPTimelineEntryTypePrivateString; break;
        case GPTimelineEntryTypeProfession: return GPTimelineEntryTypeProfessionString; break;
        case GPTimelineEntryTypeOthers: return GPTimelineEntryTypeOthersString; break;
    }
    
    return nil;
}

/* ------------------------------------------------------------------------------------------------------
 @interface GPTimelineEntry ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTimelineEntry ()

@property (nonatomic, unsafe_unretained, readwrite) GPTimelineEntryType type;
@property (nonatomic, strong, readwrite) NSString *dateString;
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSString *text;
@property (nonatomic, strong, readwrite) NSString *previewText;
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
    entry.mediaAsset = [GPMediaAsset mediaAssetForAssociatedBundle:timelineEntryBundle andVideoURLString:infoPlist[GPTimelineEntryVideoURLKey]];
    entry.previewText = infoPlist[GPTimelineEntryPreviewKey];
    
    return entry;
}

#pragma mark -
#pragma mark Getter

- (UIColor *)suggestedUIColor {
    switch (self.type) {
        case GPTimelineEntryTypeEducation: return [UIColor colorWithRed:1.0f green:0.502f blue:0.004f alpha:1.0f]; break;
        case GPTimelineEntryTypeProfession: return [UIColor colorWithRed:1.0f green:0.894f blue:0.004f alpha:1.0f]; break;
        case GPTimelineEntryTypePrivate: return [UIColor colorWithRed:0.0f green:0.596f blue:1.0f alpha:1.0f];  break;
        case GPTimelineEntryTypeOthers: return [UIColor colorWithRed:0.008f green:0.859f blue:0.251f alpha:1.0f]; break;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Debug

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@, <Title: %@>, <DateString: %@>, <Type: %@>, <Asset: %@>]", [super description], self.title, self.dateString, NSStringFromGPTimelineEntryType(self.type), self.mediaAsset];
}

@end
