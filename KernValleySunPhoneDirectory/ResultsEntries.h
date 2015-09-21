//
//  ResultsEntries.h
//  KernValleySunPhoneDirectory
//
//
@class ResultsEntry, ImageEntry, CategoryEntry, StandardEntry;
typedef enum {imageEntry, categoryEntry, standardEntry} EntryType;



@interface ResultsEntry : NSObject
@property (nonatomic) EntryType entryType;
@property (strong, atomic) NSString* allLines;
@end

@interface RawEntry : ResultsEntry
@property (strong, atomic) NSString* displayName;
@property (strong, atomic) NSString* associatedNumbers;

@property (strong, atomic) NSString* bannerPath;
@property (nonatomic) bool hasMultipleNumbers;
@property (nonatomic) bool hasMultipleLines;
@end

@interface ImageEntry : ResultsEntry
@property (strong, nonatomic) NSString* bannerPath;
@end


@interface CategoryEntry : ResultsEntry
@property (strong, atomic) NSString* categoryName;
@end


@interface StandardEntry : ResultsEntry
@property (strong, atomic) NSString* displayName;
@property (strong, atomic) NSString* associatedNumbers;
@property (nonatomic) bool hasMultipleNumbers;
@end

