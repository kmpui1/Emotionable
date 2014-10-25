//
//  TestLoginViewController.m
//  Emotionable
//
//  Created by Carmen Pui on 9/23/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import "TestLoginViewController.h"

@interface TestLoginViewController ()

@end

@implementation TestLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set UITextField delegate
    _tName.delegate = self;
    _email.delegate = self;
    _sName.delegate = self;
    
    //When UITextfield is not active or when user tap at the background which is not a textfield, the keyboard will be dismissed
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //to get the current orientation of the device
    UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
    
    typedef enum {
        UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeLeft,
        UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeRight
    } UIInterfaceOrientation;
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake((self.view.frame.origin.x + 100.0), self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake((self.view.frame.origin.x - 100.0), self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //to get the current orientation of the device
    UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
    
    typedef enum {
        UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeLeft,
        UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeRight
    } UIInterfaceOrientation;
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake((self.view.frame.origin.x - 100.0), self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake((self.view.frame.origin.x + 100.0), self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

-(void) dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    _allow = FALSE;
    
    [_tName setText:@""];
    [_email setText:@""];
    [_sName setText:@""];
    
}

- (void)checkNetworkConnection {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable){
        NSLog(@"There is no internet connection");
        _connection = FALSE;
    }
    else{
        NSLog(@"There is internet connection");
        _connection = TRUE;
    }
    
    //return _connection;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"startTestSegue"]&& _allow == TRUE)
    {
        TestViewController *controller = segue.destinationViewController;
        
        //for display purpose
        NSString *name = _tName.text;
        NSString *email = _email.text;
        NSString *sName = _sName.text;
        controller.teacher = name;
        controller.teacherEmail = email;
        controller.student = sName;
    }

}


//http://emotionable.elasticbeanstalk.com/ //Web Server URL

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"startTestSegue"] && _allow == TRUE)
    {
        return YES;
    }
    return NO;
}

-(void)addToDatabase
{
    NSString *name = _tName.text;
    NSString *email = _email.text;
    NSString *sName = _sName.text;
    
    NSString *rawStr = [NSString stringWithFormat:@"Name=%@&Email=%@&SName=%@", name, email, sName];
    
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:@"http://emotionable.elasticbeanstalk.com/insert.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *responseString = [NSString stringWithUTF8String:[responseData bytes]];
    NSLog(@"%@", responseString);
    NSLog(@"Added into Database");
    
    
//    if ([responseString intValue] == 1) {
//        self.found = YES;
//        return YES;
//    }
//    else{
//        return NO;
//    }

}

-(BOOL)validateEmail
{
    
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+.)+\\.(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:_email.text options:0 range:NSMakeRange(0, [_email.text length])];
    NSLog(@"%lu", (unsigned long)regExMatches);
    
    if (regExMatches == 0) {
        [_email setText:@""];
        return NO;
    } else
        return YES;

}

- (IBAction)startTest:(id)sender {
    [self checkNetworkConnection];
    
    if(![_tName.text isEqualToString:@""] && ![_email.text isEqualToString:@""] && ![_sName.text isEqualToString:@""]){
        if(_connection){
            if([self validateEmail] == TRUE){
                _allow = TRUE;
                [self addToDatabase]; //uncomment it later
                [self performSegueWithIdentifier:@"startTestSegue" sender:sender];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Format of Email" message:@"Please make sure the email is in a correct format and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
                _allow = FALSE;

            }
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet to do the test and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            _allow = FALSE;
            NSLog(@"Fill in!");
        }

    }
    else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"One or More Empty Text Field" message:@"Please make sure to fill in all text field and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

- (IBAction)backToHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
