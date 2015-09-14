//
//  CellGenerator.m
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 9/14/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellGenerator.h"
#import "ResultsEntries.h"
#import "StandardEntryCellTableViewCell.h"

@implementation CellGenerator
- (id) init:(UITableView*)tableViewRef {
    self = [super init];
    self.tableView = tableViewRef;
    
    return self;
}

- (UITableViewCell*) generateCell:(NSObject *)entry {
    UITableViewCell* cell;
    
    if([entry isKindOfClass:[StandardEntry class]])
        cell = [self generateStandardCell:(StandardEntry*)entry];
    
    else if ([entry isKindOfClass:[ImageEntry class]])
        cell = [self generateImageCell:(ImageEntry*)entry];
    
    else if ([entry isKindOfClass:[CategoryEntry class]])
        cell = [self generateCategoryCell:(CategoryEntry*)entry];
    
    else
        1 / 0; //FUCK IT, WE CRASH HERE
    
    return cell;
    
}


- (UITableViewCell*) generateImageCell:(ImageEntry*)imageEntry; {
    return nil;
}

- (UITableViewCell*) generateStandardCell:(StandardEntry*)standardEntry; {
    static NSString *CellIdentifier = @"StandardCell";
    StandardEntryCellTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[StandardEntryCellTableViewCell alloc] init];
    
    cell.displayNameLabel.text = standardEntry.displayName;
    
    NSLog(@"standard cell generated");
    return cell;

}

- (UITableViewCell*) generateCategoryCell:(CategoryEntry*)imageEntry; {
    return nil;
}
@end