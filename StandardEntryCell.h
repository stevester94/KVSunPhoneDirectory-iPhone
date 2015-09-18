//
//  StandardEntryCellTableViewCell.h
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 9/14/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandardEntryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *associatedNumberLabel;

@end