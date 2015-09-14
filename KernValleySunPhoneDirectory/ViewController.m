//
//  ViewController.m
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 9/14/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//
#import "ViewController.h"
#import "ResultsEntries.h"
#import "CellGenerator.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray* resultsArray;
@property (strong, nonatomic) NSArray* possibleArray;
@property (strong, nonatomic) CellGenerator* cellGenerator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    StandardEntry* testEntry;
    testEntry = [StandardEntry alloc];
    testEntry.displayName = @"Holy shit did that just work??";
    testEntry.allLines = @"These are all of the lines for the test entry!";
    self.resultsArray = [[NSArray alloc] initWithObjects:testEntry, nil];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    self.cellGenerator = [[CellGenerator alloc] init:self.resultsTableView];
    
    [self.resultsTableView registerNib:[UINib nibWithNibName:@"ResultsViewCells" bundle:nil]
         forCellReuseIdentifier:@"StandardCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Results Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultsArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    return [self.cellGenerator generateCell:[self.resultsArray objectAtIndex:indexPath.row]];
}


#pragma Search Bar
//- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
//    self.resultsArray = [self.possibleArray filteredArrayUsingPredicate:predicate];
//}
//
//
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    [self filterContentForSearchText:searchText scope:nil];
    NSLog(@"text did change!");
//    NSLog(searchText);
//    [self.resultsTableView reloadData];
}

//Called when user clicks on the results. Via gesture recognizer
-(void)dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

@end
