//
//  StandardEntryCellTableViewCell.h
//  KernValleySunPhoneDirectory
//
//

#import <UIKit/UIKit.h>

@interface StandardEntryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *associatedNumberLabel;

@end
