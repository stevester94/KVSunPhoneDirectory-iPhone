//
//  CellGenerator.h
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 9/14/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ResultsEntries.h"

@interface CellGenerator : NSObject
- (id) init:(UITableView*)tableViewRef;
- (UITableViewCell*) generateCell:(NSObject*)entry;

@property (weak, nonatomic) UITableView* tableView;
@end