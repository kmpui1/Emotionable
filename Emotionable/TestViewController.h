//
//  TestViewController.h
//  Emotionable
//
//  Created by Carmen Pui on 10/1/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TestViewController : UIViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UILabel *Happy;
@property (weak, nonatomic) IBOutlet UILabel *Sad;
@property (weak, nonatomic) IBOutlet UILabel *Angry;
@property (weak, nonatomic) IBOutlet UILabel *Tired;
@property (weak, nonatomic) IBOutlet UILabel *Shock;
@property (weak, nonatomic) IBOutlet UILabel *quesNumber;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)backToHome:(id)sender;
- (IBAction)playSound:(id)sender;
- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)button4:(id)sender;
- (IBAction)button5:(id)sender;

@property (strong, retain) NSArray* emotions;
@property (strong, retain) NSArray* imageForEmotions;
@property (nonatomic) int count;
@property (strong, retain) NSArray* question;
@property (strong, retain) NSArray* answer;
@property (strong,retain) IBOutlet UIButton *answerOfTheQues;
@property (nonatomic) int score;
@property (strong, retain) NSMutableArray* totalScore;
@property (nonatomic) NSNumber *sum;
@property (nonatomic) BOOL exit;

//pass from TestLoginViewController
@property (strong, nonatomic) NSString *teacher;
@property (strong, nonatomic) NSString *teacherEmail;
@property (strong, nonatomic) NSString *student;

@end
