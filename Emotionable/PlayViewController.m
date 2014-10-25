//
//  PlayViewController.m
//  Emotionable
//
//  Created by Carmen Pui on 9/23/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Coming Soon!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}


- (IBAction)backToHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];    
}
@end
