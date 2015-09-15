//
//  CellGenerator.h
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 9/14/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ResultsEntries.h"

#define STANDARD_CELL_HEIGHT 76.0
#define CATEGORY_CELL_HEIGHT 76.0


@interface CellGenerator : NSObject
- (id) init:(UITableView*)tableViewRef;
- (CGFloat) calculateCellHeight:(ResultsEntry*)entry;
- (UITableViewCell*) generateCell:(NSObject*)entry;

@property (weak, nonatomic) UITableView* tableView;
@end