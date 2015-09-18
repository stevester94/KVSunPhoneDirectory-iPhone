//
//  ViewController.m
//  KernValleySunPhoneDirectory
//
//
#import "ViewController.h"
#import "ResultsEntries.h"
#import "CellGenerator.h"
#import "DBManager.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray* resultsArray;
@property (strong, nonatomic) CellGenerator* cellGenerator;
@property (strong, nonatomic) DBManager* dbManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [DBManager alloc];
    [self.dbManager initializeDB];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    self.cellGenerator = [[CellGenerator alloc] init:self.resultsTableView];
    
    //No idea why you have to do this
    //  Have to let table view use the standard cells
    [self.resultsTableView registerNib:[UINib nibWithNibName:@"StandardEntryCell" bundle:nil]
         forCellReuseIdentifier:@"StandardCell"];
    
    //Initialize resultsArray with all entries
    self.resultsArray = [self.dbManager searchByName:@""];
    
    //initialize background image
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellGenerator calculateCellHeight:[self.resultsArray objectAtIndex:indexPath.row]];
}


#pragma Search Bar
//Will submit changed text to DBManager from here
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"text did change!");
    //Will need a switch statement here to determine which search method to use from db manager
    self.resultsArray = [self.dbManager searchByName:searchText];
    [self.resultsTableView reloadData];
}

//Called when user clicks on the results. Via gesture recognizer
-(void)dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

@end
