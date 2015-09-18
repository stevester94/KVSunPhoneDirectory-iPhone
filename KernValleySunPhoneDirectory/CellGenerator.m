//
//  CellGenerator.m
//  KernValleySunPhoneDirectory
//
//

#import <Foundation/Foundation.h>
#import "CellGenerator.h"
#import "ResultsEntries.h"
#import "StandardEntryCell.h"
#import "ImageEntryCell.h"

@implementation CellGenerator
- (id) init:(UITableView*)tableViewRef {
    self = [super init];
    self.tableView = tableViewRef;
    
    return self;
}

- (CGFloat) calculateCellHeight:(ResultsEntry*)entry {
    NSString *bannerPath = @"ready/";
    switch (entry.entryType) {
        case imageEntry:
            bannerPath = [bannerPath stringByAppendingString:((ImageEntry*)entry).bannerPath];
            bannerPath = [bannerPath stringByAppendingString:@".jpg"];
            return [UIImage imageNamed: bannerPath].size.height * 0.5;
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
    //Alocate cell
    static NSString *CellIdentifier = @"ImageCell";
    ImageEntryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[ImageEntryCell alloc] init];
    NSString* bannerPath = @"ready/";
    bannerPath = [bannerPath stringByAppendingString:imageEntry.bannerPath];
    bannerPath = [bannerPath stringByAppendingString:@".jpg"];
    //NSLog(bannerPath);
    
    [cell.bannerImageView setImage:[UIImage imageNamed: bannerPath]];
    return cell;
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