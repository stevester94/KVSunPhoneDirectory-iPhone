//
//  DBManager.m
//  KernValleySunPhoneDirectory
//
//

#import "DBManager.h"
#import "ResultsEntries.h"

@interface DBManager ()

@end

//CREATE TABLE Entries(displayName TEXT PRIMARY KEY, associatedNumbers TEXT, allLines TEXT, bannerPath TEXT, hasMultipleNumbers BOOLEAN, hasMultipleLines BOOLEAN);
//CREATE TABLE Categories(displayName TEXT, category TEXT, FOREIGN KEY(displayName) REFERENCES entries(displayName));
//CREATE TABLE CategoriesList(Category TEXT PRIMARY KEY);

//Need:
//  search by name
//  search by category
//  search by number

//Need to return as ResultsArray

@implementation DBManager
- (id) init {
    self = [super init];
    return self;
}


//schema: Entries(displayName TEXT PRIMARY KEY, associatedNumbers TEXT, allLines TEXT, bannerPath TEXT, hasMultipleNumbers BOOLEAN, hasMultipleLines BOOLEAN);
- (NSMutableArray*) searchByName:(NSString*)name {
    NSString* baseQuery = @"select * from Entries where displayName like ";
    NSString* query = [baseQuery stringByAppendingString:@"'%"];
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"%'"];

    
    sqlite3_stmt* statement = [self executeQuery:query];
    return [self dumpAllEntriesFromStatement:statement];
}

//schema: Categories(displayName TEXT, category TEXT, FOREIGN KEY(displayName) REFERENCES entries(displayName));
- (NSMutableArray*) searchByCategory:(NSString *)category {
    NSString* baseQuery = @"SELECT Entries.* from Entries, Categories where ";
    baseQuery = [baseQuery stringByAppendingString:@"Entries.displayName = Categories.displayName and Categories.category = "];
    NSString* query = [baseQuery stringByAppendingString:@"'"];
    query = [query stringByAppendingString:category];
    query = [query stringByAppendingString:@"'"];
    
    sqlite3_stmt* statement = [self executeQuery:query];
    return [self dumpAllEntriesFromStatement:statement];
    
}

- (NSMutableArray*) getAllCategories {
    NSString* baseQuery = @"select category from categorieslist";
    NSMutableArray* rowDump = [[NSMutableArray alloc] init];
    sqlite3_stmt* statement = [self executeQuery:baseQuery];
    while(sqlite3_step(statement) == SQLITE_ROW) {
        RawEntry* row = [RawEntry alloc];
        
        row.displayName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
        row.allLines = @"...";
        //Determine type
        row.entryType = categoryEntry;
        [rowDump addObject:(CategoryEntry*)row];
    }
    
    [self finalizeAndClose:statement];
    return rowDump;
}

- (NSMutableArray*) searchByNumber:(NSString *)number {
    NSString* baseQuery = @"select * from Entries where associatedNumbers like ";
    NSString* query = [baseQuery stringByAppendingString:@"'%"];
    query = [query stringByAppendingString:number];
    query = [query stringByAppendingString:@"%'"];
    
    sqlite3_stmt* statement = [self executeQuery:query];
    return [self dumpAllEntriesFromStatement:statement];
}

//Will only dump Entries!!!! NOT CATEGORIES!!!
- (NSMutableArray*) dumpAllEntriesFromStatement:(sqlite3_stmt*)statement {
    NSMutableArray* rowDump = [[NSMutableArray alloc] init];
    while(sqlite3_step(statement) == SQLITE_ROW) {
        RawEntry* row = [RawEntry alloc];
        
        row.displayName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
        row.associatedNumbers = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
        row.allLines = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 2)];
        row.bannerPath = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 3)];
        row.hasMultipleNumbers = (bool)sqlite3_column_int(statement, 4);
        row.hasMultipleLines = (bool)sqlite3_column_int(statement, 5);
        
        //Determine type
        if([row.bannerPath isEqualToString:@"no path entered"]) {
            row.entryType = standardEntry;
            [rowDump addObject:(StandardEntry*)row];
        } else {
            row.entryType = imageEntry;
            [rowDump addObject:(ImageEntry*)row];
        }
        
        
    }
    [self finalizeAndClose:statement];
    
    return rowDump;
}

- (void) testEntriesDB {
    NSString *querySQL = @"SELECT * FROM categories";
    sqlite3_stmt* queryReturn = [self executeQuery:querySQL];
    
    while (sqlite3_step(queryReturn) == SQLITE_ROW) {
        const unsigned char* rowData = sqlite3_column_text(queryReturn, 1);
                
        printf("Category: %s\n", rowData);
    }
    [self finalizeAndClose:queryReturn];
}



- (void)initializeDB {
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSError*__autoreleasing* error;
   
    //Check for file in bundle
    NSLog(@"Checking for database file in bundle");
    NSString *pathToBundleDB = [[NSBundle mainBundle]pathForResource:DATABASE_NAME ofType:@"db"];

    if (!pathToBundleDB) {
        NSLog(@"Unable to find file in bundle");
        return;
    }
    
    //Get document path
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //Get absolute path to DB in document directory
    NSMutableString* pathToDocumentsDB  = [NSMutableString stringWithString:documentsDirectory];
    [pathToDocumentsDB appendString:@"/entries.db"];
    NSLog(pathToDocumentsDB);
    
    //Delete db in documents if present
    if ([fileManager fileExistsAtPath:pathToDocumentsDB] == YES) {
        [fileManager removeItemAtPath:pathToDocumentsDB error:error];
        NSLog(@"DB in documents deleted");
    }
    
    //Copy db from bundle to documents
    bool copySuccess = [fileManager copyItemAtPath:pathToBundleDB toPath:pathToDocumentsDB error:error];
    if(copySuccess & [fileManager fileExistsAtPath:pathToDocumentsDB])
        NSLog(@"Copy was succesfull");
    else
        NSLog(@"Copy unsuccesfull");
    
    self.databasePath = pathToDocumentsDB;
}

//need to execute finalize and close after using statement
- (sqlite3_stmt*) executeQuery:(NSString*)query {
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    const char *query_stmt = [query UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) {
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            return statement;
        else {
            NSLog(@"Query failed");
            return nil;
        }
    } else {
        NSLog(@"Query failed");
        return nil;
    }
}

- (void) finalizeAndClose:(sqlite3_stmt*)statement {
    sqlite3_finalize(statement);
    sqlite3_close(_contactDB);
}

- (void) testCategories {
    NSString* baseQuery = @"select * from categories";

    
    sqlite3_stmt* statement = [self executeQuery:baseQuery];
    [self dumpAllEntriesFromStatement:statement];
}





@end

