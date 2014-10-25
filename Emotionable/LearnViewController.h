//
//  LearnViewController.h
//  Emotionable
//
//  Created by Carmen Pui on 9/8/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MoreExampleViewController.h"

@interface LearnViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *emotionName;
@property (weak, nonatomic) IBOutlet UIButton *playSoundButton;
@property (weak, nonatomic) IBOutlet UIButton *galleryButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIImageView *emotionImage;


- (IBAction)backToHome:(id)sender;
- (IBAction)nextPage:(id)sender;
- (IBAction)previousPage:(id)sender;
- (IBAction)pronounce:(id)sender;
- (IBAction)playSound:(id)sender;

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) AVAudioPlayer *player;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic) int pageCount;
@property (strong, retain) NSArray* emotions;
@property (strong, retain) NSArray* imageForEmotions;
@property (strong, retain) NSArray* happy;
@property (strong, retain) NSArray* sad;
@property (strong, retain) NSArray* angry;
@property (strong, retain) NSArray* tired;
@property (strong, retain) NSArray* shock;
@property (strong, retain) NSArray* fear;


@end
