//
//  MoreExampleViewController.m
//  Emotionable
//
//  Created by Carmen Pui on 9/17/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import "MoreExampleViewController.h"

@interface MoreExampleViewController ()

@end

@implementation MoreExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _page = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    _emotions = [NSArray arrayWithObjects:@"Happy", @"Sad", @"Angry", @"Shock", @"Tired", nil];
    [_moreEmotionImage setUserInteractionEnabled:YES];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [_moreEmotionImage addGestureRecognizer:swipeLeft];
    [_moreEmotionImage addGestureRecognizer:swipeRight];
    
    //Get the emotion type
    if (_emotionType == 0) {
        _emotionImage = [NSArray arrayWithObjects:@"Happy1.png", @"Happy2.jpg", @"Happy3.jpg", @"Happy4.jpg", @"Happy5.png", nil];
        _emotion = [_emotionImage objectAtIndex:_page];
    }
    else if (_emotionType == 1) {
        _emotionImage = [NSArray arrayWithObjects:@"Sad1.jpg", @"Sad2.jpg", @"Sad3.jpg", @"Sad4.png", @"Sad5.jpg", nil];
        _emotion = [_emotionImage objectAtIndex:_page];
    }
    else if (_emotionType == 2) {
        _emotionImage = [NSArray arrayWithObjects:@"Angry1.jpg", @"Angry2.jpg", @"Angry3.jpg", @"Angry4.jpg", @"Angry5.jpg", nil];
        _emotion = [_emotionImage objectAtIndex:_page];
    }
    else if (_emotionType == 3) {
        _emotionImage = [NSArray arrayWithObjects:@"Shock1.jpg", @"Shock2.jpg", @"Shock3.jpg", @"Shock4.png", @"Shock5.png", nil];
        _emotion = [_emotionImage objectAtIndex:_page];
    }
    else{
        _emotionImage = [NSArray arrayWithObjects:@"Tired1.jpg", @"Tired2.jpg", @"Tired3.jpg", @"Tired4.jpg", @"Tired5.jpg", nil];
        _emotion = [_emotionImage objectAtIndex:_page];
    }
    
//    else{
//        _emotionImage = [NSArray arrayWithObjects:@"Fear.jpg", nil];
//        _emotion = [_emotionImage objectAtIndex:_page];
//    }

    [self setImage:[UIImage imageNamed:[_emotionImage objectAtIndex:_page]]];
    [self pronounce];
}

- (void)setImage:(UIImage *)image
{
    self.moreEmotionImage.image = image;
}

- (UIImage *)image
{
    return self.moreEmotionImage.image;
}

-(void)pronounce
{
    NSString *path;
    
    NSURL *url;
    
    path =[[NSBundle mainBundle] pathForResource:[_emotions objectAtIndex:_emotionType] ofType:@"mp3"];
    
    url = [NSURL fileURLWithPath:path];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [_player setVolume:1.0];
    //[_player play];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:[_emotions objectAtIndex:_emotionType]];
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.1;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-uk"];
    [self.synthesizer speakUtterance:utterance];

}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe %@ %d", _emotion, _page);
        if(_page < [_emotionImage count] - 1){
            _page = _page + 1;

            [self setImage:[UIImage imageNamed:[_emotionImage objectAtIndex:_page]]];
            [self pronounce];

        }
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe %@ %d", _emotion, _page);
        if(_page > 0){
            _page = _page - 1;

            [self setImage:[UIImage imageNamed:[_emotionImage objectAtIndex:_page]]];
            [self pronounce];

        }
    }
    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
