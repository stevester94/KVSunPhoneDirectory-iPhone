//
//  UIPopup.m
//  KernValleySunPhoneDirectory
//
//  Created by Steven Mackey on 10/17/15.
//  Copyright (c) 2015 Steven Mackey. All rights reserved.
//

#import "UIPopup.h"

@interface UIPopup ()

@end

@implementation UIPopup

- (void)viewDidLoad {
    NSLog(@"Display you bitch");
    [super viewDidLoad];
}

- (IBAction)buttonTapped:(UIButton*)sender {
    NSLog(@"Button Pressed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    [self.view setHidden:YES];
}

- (void)setLabelText:(NSString*)text {
    [self.contactInfoText setText:nil];
    [self.contactInfoText setText:text];
    
}

- (void)show {
    [self.view setHidden:NO];
}

@end
