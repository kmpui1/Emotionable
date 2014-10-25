//
//  TestLoginViewController.h
//  Emotionable
//
//  Created by Carmen Pui on 9/23/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#import "TestViewController.h"

@interface TestLoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *tName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *sName;

- (IBAction)startTest:(id)sender;
- (IBAction)backToHome:(id)sender;

@property (nonatomic) BOOL allow;
@property (nonatomic) BOOL connection;

@end
