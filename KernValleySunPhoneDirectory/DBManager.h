//
//  DBManager.h
//  KernValleySunPhoneDirectory
//
//  Created by Steven S. Mackey on 9/15/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//

#import <sqlite3.h>
#import <UIKit/UIKit.h>
#import <stdio.h>

#define DATABASE_NAME @"entries"


@interface DBManager : NSObject

- (void) initializeDB;
- (void) createEditableCopyOfDatabaseIfNeeded;
- (void)saveData:(id)sender name:(NSString*)name note:(NSString*)note;
- (void)findContact:(id)sender name:(NSString*)name;
- (void) createAndCheckDatabase; 
- (void) getAllData;
- (void) testEntriesDB;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end
