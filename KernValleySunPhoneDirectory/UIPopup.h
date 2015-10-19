//
//  UIPopup.h
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 10/17/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPopup : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *contactInfoText;


- (void)setLabelText:(NSString*)text;
- (void)show;

@end
