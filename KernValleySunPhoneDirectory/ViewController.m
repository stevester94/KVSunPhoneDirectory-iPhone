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
@property (nonatomic) NSInteger currentScopeIndex;
@property (strong, nonatomic) NSArray* sectionsArray;
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
    [self.resultsTableView registerNib:[UINib nibWithNibName:@"ImageEntryCell" bundle:nil]
                forCellReuseIdentifier:@"ImageCell"];
    
    //Initialize resultsArray with all entries
    self.resultsArray = [self.dbManager searchByName:@""];
    
    //initialize background image
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    // change searchbar font
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir" size:14],
                                                                    }];
    
 // change scope bar font
    [self.searchBar setScopeBarButtonTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Avenir" size:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    //Initialize scope
    self.currentScopeIndex = 0;
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* allLines = ((ResultsEntry*)[self.resultsArray objectAtIndex:indexPath.row]).allLines;
    UIAlertView *messageAlert = [UIAlertView alloc];
    switch (self.currentScopeIndex) {
        case 0://Search by name
        case 1://Search by number
            [messageAlert initWithTitle:@"Contact Information" message:allLines delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            break;
        case 2://Search by category
            self.resultsArray = [self.dbManager searchByCategory:((StandardEntry*)[self.resultsArray objectAtIndex:indexPath.row]).displayName];
            [tableView reloadData];
           // [messageAlert initWithTitle:@"Contact Information" message:allLines delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            break;
        default:
            break;
    }
    //Display Alert Message
    [messageAlert show];
}




#pragma Search Bar
//Will submit changed text to DBManager from here
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"text did change!");
    //Will need a switch statement here to determine which search method to use from db manager
    switch (self.currentScopeIndex) {
        case 0://Search by name
            self.resultsArray = [self.dbManager searchByName:searchText];
            break;
        case 1://Search by number
            self.resultsArray = [self.dbManager searchByNumber:searchText];
            break;
        case 2://Search by category
            self.resultsArray = [self.dbManager getAllCategories];
        default:
            break;
    }

    [self.resultsTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    self.currentScopeIndex = selectedScope;
    self.searchBar.text = @"";
    [self searchBar:searchBar textDidChange:@""];
//    NSLog([NSString stringWithFormat:@"%ld",(long)self.currentScopeIndex]);

}

//Called when user clicks on the results. Via gesture recognizer
-(void)dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

@end
