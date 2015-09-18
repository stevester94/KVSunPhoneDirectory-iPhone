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
#import "StandardEntryCell.h"

@implementation CellGenerator
- (id) init:(UITableView*)tableViewRef {
    self = [super init];
    self.tableView = tableViewRef;
    
    return self;
}

- (CGFloat) calculateCellHeight:(ResultsEntry*)entry {
    switch (entry.entryType) {
        case imageEntry:
            //DO MATH HERE!
            return -1;
            break;
        case standardEntry:
            return STANDARD_CELL_HEIGHT;
            break;
        case categoryEntry:
            return CATEGORY_CELL_HEIGHT;
            break;
        default:
            1 / 0; //FUCK IT, WE CRASH HERE
            return -1;
            break;
    }
}

- (UITableViewCell*) generateCell:(ResultsEntry *)entry {
    UITableViewCell* cell;

    switch (entry.entryType) {
        case imageEntry:
            cell = [self generateImageCell:entry];
            break;
        case standardEntry:
            cell = [self generateStandardCell:entry];
            break;
        case categoryEntry:
            cell = [self generateCategoryCell:entry];
            break;
        default:
            NSLog(@"CRASHING, CELL NOT GENERATED");
            1 / 0; //FUCK IT, WE CRASH HERE
            break;
    }
    
    return cell;
}




- (UITableViewCell*) generateImageCell:(ImageEntry*)imageEntry {
    //so this shit doesnt brake
    StandardEntry* standardEntryConv = [StandardEntry alloc];
    standardEntryConv = (StandardEntry*)imageEntry;
    standardEntryConv.hasMultipleNumbers = YES;
    imageEntry.allLines = @"IMAGE CELL";
    return [self generateStandardCell:(StandardEntry*)imageEntry];
}

- (UITableViewCell*) generateStandardCell:(StandardEntry*)standardEntry {
    //Alocate cell
    static NSString *CellIdentifier = @"StandardCell";
    StandardEntryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[StandardEntryCell alloc] init];
    
    //Set labels
    cell.displayNameLabel.text = standardEntry.displayName;
    if(standardEntry.hasMultipleNumbers)
        cell.associatedNumberLabel.text = standardEntry.allLines;
    else
        cell.associatedNumberLabel.text = standardEntry.associatedNumbers;

    return cell;

}

- (UITableViewCell*) generateCategoryCell:(CategoryEntry*)categoryEntry {
    return [self generateStandardCell:(StandardEntry*)categoryEntry];
}
@end