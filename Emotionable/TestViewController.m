//
//  TestViewController.m
//  Emotionable
//
//  Created by Carmen Pui on 10/1/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _count = 0;
        
        //Enable the button
        [_button1 setEnabled:YES];
        [_button2 setEnabled:YES];
        [_button3 setEnabled:YES];
        [_button4 setEnabled:YES];
        [_button5 setEnabled:YES];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _exit = FALSE;
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    NSArray *happy = [NSArray arrayWithObjects:@"Happy.jpg", @"Happy1.png", @"Happy2.jpg", @"Happy3.jpg", @"Happy4.jpg", @"Happy5.png",nil];
    NSArray *sad = [NSArray arrayWithObjects:@"Sad.jpg", @"Sad1.jpg", @"Sad2.jpg", @"Sad3.jpg", @"Sad4.png", @"Sad5.jpg", nil];
    NSArray *angry = [NSArray arrayWithObjects:@"Angry.jpg", @"Angry1.jpg", @"Angry2.jpg", @"Angry3.jpg", @"Angry4.jpg", @"Angry5.jpg", nil];
    NSArray *shock = [NSArray arrayWithObjects:@"Shock.jpg", @"Shock1.jpg", @"Shock2.jpg", @"Shock3.jpg", @"Shock4.png", @"Shock5.png", nil];
    NSArray *tired = [NSArray arrayWithObjects:@"Tired.jpg", @"Tired1.jpg", @"Tired2.jpg", @"Tired3.jpg", @"Tired4.jpg", @"Tired5.jpg", nil];
    
    _emotions = [NSArray arrayWithObjects:@"Shock", @"Happy", @"Angry", @"Tired", @"Sad", nil];
    _imageForEmotions = [NSArray arrayWithObjects:@"Happy.jpg", @"Sad.jpg", @"Angry.jpg", @"Shock.jpg", @"Tired.jpg", @"Surprised.jpg", nil];
    _question = [NSArray arrayWithObjects: shock, happy, angry, tired, sad, nil];
    _answer = [NSArray arrayWithObjects: _button5, _button1, _button3, _button4, _button2, nil];
    _totalScore = [[NSMutableArray alloc] initWithCapacity:[_question count]];
    
    [self startTest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startTest
{
    _quesNumber.text = [NSString stringWithFormat:@"%d of %lu", _count+1, (unsigned long)[_question count]];
    _score = 20;
    [self setEnabledButton];
    _answerOfTheQues = [_answer objectAtIndex:_count];
    
    //Setting the image for the question
    NSArray *target = [_question objectAtIndex:_count];
    NSInteger randomNumber = arc4random() % [target count];
    NSLog(@"the random Number is %li, with size of the target is %li", (long)randomNumber, (long)[target count]);
    
    [self setImage:[UIImage imageNamed:[target objectAtIndex:randomNumber]]];
}

-(void)setEnabledButton
{
    //Re-enable the buttons for next questions.
    [_button1 setEnabled:YES];
    [_button2 setEnabled:YES];
    [_button3 setEnabled:YES];
    [_button4 setEnabled:YES];
    [_button5 setEnabled:YES];
}

-(void)goToNextQuestion
{
    if(_count < [_question count]-1){
        _count += 1;
    }
}

-(void)endOfQuestion
{
    NSLog(@"End of the Question");
    
    //Calculating the total score of the test
    NSInteger sum = 0;
    for (NSNumber *num in _totalScore)
    {
        NSLog(@"Score");
        sum += [num intValue];
    }
    NSLog(@"Total score: %ld/100", (long)sum);
    
    //convert NSInteger to NSNumber --> [NSNumber numberWithInteger:[[namecard objectForKey:@"ID"] integerValue]]
    _sum = [NSNumber numberWithInteger:sum];
    
    //send email to teacher
    [self updateDatabaseWithResult];
    [self sendEmail];
    
    //Alert to exit the test
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Well Done!" message:[NSString stringWithFormat:@"Your Score: %@\n\nScore has been calculated and sent to teacher's email.", _sum] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    [alert show];
    _exit = TRUE;

}

-(void)playApplauseSoundEffect
{
    NSString *path;
    
    NSURL *url;
    
    path =[[NSBundle mainBundle] pathForResource:@"Applause" ofType:@"mp3"];
    
    
    url = [NSURL fileURLWithPath:path];
    
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [_player setVolume:1.0];
    [_player play];
    

}

-(void)playTerrificSoundEffect
{
    NSString *path;
    
    NSURL *url;
    
    path =[[NSBundle mainBundle] pathForResource:@"Terrific" ofType:@"mp3"];
    
    url = [NSURL fileURLWithPath:path];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [_player setVolume:1.0];
    [_player play];
}

-(void)playTryAgainSoundEffect
{
    NSString *path;
    
    NSURL *url;
    
    path =[[NSBundle mainBundle] pathForResource:@"TryAgain" ofType:@"mp3"];
    
    url = [NSURL fileURLWithPath:path];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [_player setVolume:1.0];
    [_player play];
}

-(void)recordScore
{
    [_totalScore addObject:[NSNumber numberWithInt: _score]];
    NSLog(@"The score this question is  %i/20", _score);
}

-(void)sendEmail
{
    NSString *name = _teacher;
    NSString *email = _teacherEmail;
    NSString *sName = _student;
    
    NSString *rawStr = [NSString stringWithFormat:@"Teacher=%@&TeacherEmail=%@&Student=%@&Score=%@", name, email, sName, _sum];
    
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:@"http://emotionable.elasticbeanstalk.com/send.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *responseString = [NSString stringWithUTF8String:[responseData bytes]];
    NSLog(@"%@", responseString);
}

-(void)updateDatabaseWithResult
{
    NSString *sName = _student;
    
    NSString *rawStr = [NSString stringWithFormat:@"SName=%@&Score=%@&Feedback=%@", sName, _sum, @"Well Done!"];
    
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:@"http://emotionable.elasticbeanstalk.com/update.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *responseString = [NSString stringWithUTF8String:[responseData bytes]];
    NSLog(@"%@", responseString);
    NSLog(@"Updated Database");
    
    
    //    if ([responseString intValue] == 1) {
    //        self.found = YES;
    //        return YES;
    //    }
    //    else{
    //        return NO;
    //    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backToHome:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are you confirm to exit the test. It will not save the score into the database." delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:@"Cancel",nil];
    
    [alert show];
    _exit = TRUE;
}

-(void) alertView: (UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        if(_exit == TRUE){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)playSound:(id)sender {
    NSString *path;
    
    NSURL *url;
    
    path =[[NSBundle mainBundle] pathForResource:[_emotions objectAtIndex:_count] ofType:@"mp3"];
    
    url = [NSURL fileURLWithPath:path];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [_player setVolume:1.0];
    [_player play];

}

- (IBAction)button1:(id)sender {
    if (_answerOfTheQues == _button1) {
        [_button1 setEnabled:YES];
        //[self playApplauseSoundEffect];
        [self playTerrificSoundEffect];
        
        [self recordScore];
        
        if (_count != 4) {
            [self goToNextQuestion];
            [self startTest];
        }
        else{
            [self endOfQuestion];
        }

    }
    else{
        _score -= 4;
        [_button1 setEnabled:NO];
        [self playTryAgainSoundEffect];
    }
    
}

- (IBAction)button2:(id)sender {
    if (_answerOfTheQues == _button2) {
        [_button2 setEnabled:YES];
        [self playApplauseSoundEffect];
        //[self playTerrificSoundEffect];
        
        [self recordScore];
        
        if (_count != 4) {
            [self goToNextQuestion];
            [self startTest];
        }
        else{
            [self endOfQuestion];
        }
    }
    else{
        _score -= 4;
        [_button2 setEnabled:NO];
        [self playTryAgainSoundEffect];
    }
}

- (IBAction)button3:(id)sender {
    if (_answerOfTheQues == _button3) {
        [_button3 setEnabled:YES];
        [self playApplauseSoundEffect];
        //[self playTerrificSoundEffect];
        
        [self recordScore];
        
        if (_count != 4) {
            [self goToNextQuestion];
            [self startTest];
        }
        else{
            [self endOfQuestion];
        }
    }
    else{
        _score -= 4;
        [_button3 setEnabled:NO];
        [self playTryAgainSoundEffect];
    }
}

- (IBAction)button4:(id)sender {
    if (_answerOfTheQues == _button4) {
        [_button4 setEnabled:YES];
        //[self playApplauseSoundEffect];
        [self playTerrificSoundEffect];
        
        [self recordScore];
        
        if (_count != 4) {
            [self goToNextQuestion];
            [self startTest];
        }
        else{
            [self endOfQuestion];
        }
    }
    else{
        _score -= 4;
        [_button4 setEnabled:NO];
        [self playTryAgainSoundEffect];
    }
}

- (IBAction)button5:(id)sender {
    if (_answerOfTheQues == _button5) {
        [_button5 setEnabled:YES];
        [self playApplauseSoundEffect];
        //[self playTerrificSoundEffect];
        
        [self recordScore];

        if (_count != 4) {
            [self goToNextQuestion];
            [self startTest];
        }
        else{
            [self endOfQuestion];
        }
    }
    else{
        _score -= 4;
        [_button5 setEnabled:NO];
        [self playTryAgainSoundEffect];
    }
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (UIImage *)image
{
    return self.imageView.image;
}

@end
