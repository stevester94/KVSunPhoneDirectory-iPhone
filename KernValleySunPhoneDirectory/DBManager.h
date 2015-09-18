//
//  DBManager.h
//  KernValleySunPhoneDirectory
//
//

#import <sqlite3.h>
#import <UIKit/UIKit.h>
#import <stdio.h>

#define DATABASE_NAME @"entries"


@interface DBManager : NSObject


- (void) initializeDB;
- (void)saveData:(id)sender name:(NSString*)name note:(NSString*)note;
- (void)findContact:(id)sender name:(NSString*)name;
- (void)createAndCheckDatabase;
- (void)getAllData;
- (NSMutableArray*)getAllCategories;
- (NSMutableArray*) searchByName:(NSString*)name;
- (NSMutableArray*)searchByNumber:(NSString*)number;
- (NSMutableArray*)searchByCategory:(NSString*)category;
- (void)testEntriesDB;
- (void)testCategories;


@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end
