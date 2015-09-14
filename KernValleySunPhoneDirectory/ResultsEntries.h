//
//  ResultsEntries.h
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 9/14/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//
@class ImageEntry, CategoryEntry, StandardEntry;

@interface ImageEntry : NSObject
@property (strong, nonatomic) NSString* bannerPath;
@property (strong, nonatomic) NSString* allLines;
@end


@interface CategoryEntry : NSObject
@property (strong, atomic) NSString* CategoryName;
@end


@interface StandardEntry : NSObject
@property (strong, atomic) NSString* displayName;
@property (strong, atomic) NSString* allLines;
@end

