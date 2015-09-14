//
//  ViewController.m
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 9/14/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray* resultsArray;
@property (strong, nonatomic) NSArray* possibleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.possibleArray = [[NSArray alloc] initWithObjects:@"apple", @"Samsung", @"HTC", @"LG", @"Moto", @"lel", nil];
    self.resultsArray = [[NSArray alloc] initWithArray:self.possibleArray];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.resultsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma Search Bar
- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    self.resultsArray = [self.possibleArray filteredArrayUsingPredicate:predicate];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterContentForSearchText:searchText scope:nil];
    NSLog(@"text did change!");
    NSLog(searchText);
    [self.resultsTableView reloadData];
}

//Called when user clicks on the results. Via gesture recognizer
-(void)dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

@end
