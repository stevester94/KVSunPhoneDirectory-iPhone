//
//  DBManager.m
//  KernValleySunPhoneDirectory
//
//  Created by Steven S. Mackey on 9/15/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

@interface DBManager ()

@end

//CREATE TABLE Entries(displayName TEXT PRIMARY KEY, associatedNumbers TEXT, allLines TEXT, bannerPath TEXT, hasMultipleNumbers BOOLEAN, hasMultipleLines BOOLEAN);
//CREATE TABLE Categories(displayName TEXT, category TEXT, FOREIGN KEY(displayName) REFERENCES entries(displayName));
//CREATE TABLE CategoriesList(Category TEXT PRIMARY KEY);


@implementation DBManager
- (id) init {
    self = [super init];
    return self;
}

- (void)initializeDB {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      DATABASE_NAME]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //Is going to create an empty database if not found, need to change!!
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, NOTE TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            sqlite3_close(_contactDB);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
}

- (void) saveData:(id)sender name:(NSString*) name note:(NSString *)note
{
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACTS (name, note) VALUES (\"%@\", \"%@\")",
                               name, note];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"save succesfull");
        } else {
            NSLog(@"Save failed");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
}

- (void) findContact:(id)sender name:(NSString*)name
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT * FROM contacts WHERE name=\"%@\"",
                              name];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            unsigned char* cols = sqlite3_column_name(statement, 2);
            
            
            if (sqlite3_step(statement) == SQLITE_ROW) {
                const unsigned char* note = sqlite3_column_text(statement, 2);
                
                NSLog(@"Match found");
                printf("Column name: %s\n", cols);
                printf("Vlaue: %s\n", note);
            } else {
                NSLog(@"Match not found");
            }
            sqlite3_finalize(statement);
        } else
            NSLog(@"shits all fucked");
        sqlite3_close(_contactDB);
    }
}


- (void)getAllData {
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"entries.db"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelectQuery = @"SELECT * FROM Entries";
    
    // Query result
    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
    while([resultsWithNameLocation next]) {
        NSString *strID = [NSString stringWithFormat:@"%d",[resultsWithNameLocation intForColumn:@"displayName"]];
        
        // loading your data into the array, dictionaries.
        NSLog(@"ID = %@",strID);
    }
    [database close];
}



@end
