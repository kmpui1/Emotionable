//
//  MoreExampleViewController.h
//  Emotionable
//
//  Created by Carmen Pui on 9/17/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MoreExampleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *moreEmotionImage;

- (IBAction)done:(id)sender;

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) AVAudioPlayer *player;

@property (nonatomic) int page;
@property (nonatomic) int emotionType;
@property (strong, retain) NSString *emotion;
@property (strong, retain) NSArray *emotions;
@property (strong, nonatomic) UIImage *image;
@property (strong, retain) NSArray* emotionImage;

@end
