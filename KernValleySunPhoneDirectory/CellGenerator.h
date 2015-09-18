//
//  CellGenerator.h
//  KernValleySunPhoneDirectory
//
//
#import <UIKit/UIKit.h>
#import "ResultsEntries.h"

#define STANDARD_CELL_HEIGHT 60
#define CATEGORY_CELL_HEIGHT 76


@interface CellGenerator : NSObject
- (id) init:(UITableView*)tableViewRef;
- (CGFloat) calculateCellHeight:(ResultsEntry*)entry;
- (UITableViewCell*) generateCell:(NSObject*)entry;

@property (weak, nonatomic) UITableView* tableView;
@end