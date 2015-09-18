//
//  ResultsEntries.h
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 9/14/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//
@class ResultsEntry, ImageEntry, CategoryEntry, StandardEntry;
typedef enum {imageEntry, categoryEntry, standardEntry} EntryType;



@interface ResultsEntry : NSObject
@property (nonatomic) EntryType entryType;
@end

@interface RawEntry : ResultsEntry
@property (strong, atomic) NSString* displayName;
@property (strong, atomic) NSString* associatedNumbers;
@property (strong, atomic) NSString* allLines;
@property (strong, atomic) NSString* bannerPath;
@property (nonatomic) bool hasMultipleNumbers;
@property (nonatomic) bool hasMultipleLines;
@end

@interface ImageEntry : ResultsEntry
@property (strong, nonatomic) NSString* bannerPath;
@property (strong, nonatomic) NSString* allLines;
@end


@interface CategoryEntry : ResultsEntry
@property (strong, atomic) NSString* CategoryName;
@end


@interface StandardEntry : ResultsEntry
@property (strong, atomic) NSString* displayName;
@property (strong, atomic) NSString* associatedNumbers;
@property (strong, atomic) NSString* allLines;
@property (nonatomic) bool hasMultipleNumbers;
@end

