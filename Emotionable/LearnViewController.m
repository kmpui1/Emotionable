//
//  LearnViewController.m
//  Emotionable
//
//  Created by Carmen Pui on 9/8/14.
//  Copyright (c) 2014 carmenpui. All rights reserved.
//

#import "LearnViewController.h"

@interface LearnViewController ()

@end

@implementation LearnViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _pageCount = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    _emotions = [NSArray arrayWithObjects:@"Happy", @"Sad", @"Angry", @"Shock", @"Tired", nil];
    _imageForEmotions = [NSArray arrayWithObjects:@"Happy.jpg", @"Sad.jpg", @"Angry.jpg", @"Shock.jpg", @"Tired.jpg", nil];
    

    if (_pageCount == 0) {
        _previousButton.hidden = YES;
    }
    
    
    [self emotionLabel];
    
    NSLog(@"Number of emotions %lu", (unsigned long)[_emotions count]);
}

- (void)emotionLabel
{
    _emotionName.text = [_emotions objectAtIndex:_pageCount];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"MoreExamples"]) {
        MoreExampleViewController *controller = segue.destinationViewController;
        //controller.emotion = [_emotions objectAtIndex:_pageCount];
        controller.emotionType = _pageCount;
    }
    
}


- (IBAction)backToHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextPage:(id)sender {
    if(_pageCount < [_emotions count]-1){
        _previousButton.hidden = NO;
        _pageCount = _pageCount + 1;
        if(_pageCount == [_emotions count]-1){
            _nextButton.hidden = YES;
        }
    }
    
    NSLog(@"Next page %d", _pageCount);
    [self emotionLabel];
    [self setImage:[UIImage imageNamed:[_imageForEmotions objectAtIndex:_pageCount]]];
}

- (IBAction)previousPage:(id)sender {
    if(_pageCount > 0){
        _nextButton.hidden = NO;
        _pageCount = _pageCount - 1;
        if (_pageCount == 0) {
            _previousButton.hidden = YES;
        }
    }
    NSLog(@"Previous page %d", _pageCount);
    [self emotionLabel];
    [self setImage:[UIImage imageNamed:[_imageForEmotions objectAtIndex:_pageCount]]];
}

//reference : http://www.devfright.com/quick-look-avspeechsynthesizer-class/
//reference : http://useyourloaf.com/blog/2014/01/08/synthesized-speech-from-text.html
- (IBAction)pronounce:(id)sender {
    
    /*
    AVSpeechUtterance *bugWorkaroundUtterance = [AVSpeechUtterance speechUtteranceWithString:@" "];
    bugWorkaroundUtterance.rate = AVSpeechUtteranceMaximumSpeechRate;
    [self.synthesizer speakUtterance:bugWorkaroundUtterance];
     */
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:[_emotions objectAtIndex:_pageCount]];
    //utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.1;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-uk"];
    [self.synthesizer speakUtterance:utterance];
}


- (IBAction)playSound:(id)sender {
    NSString *path;
    
    NSURL *url;
    
    path =[[NSBundle mainBundle] pathForResource:[_emotions objectAtIndex:_pageCount] ofType:@"mp3"];
    
    url = [NSURL fileURLWithPath:path];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [_player setVolume:1.0];
    [_player play];
}

- (void)setImage:(UIImage *)image
{
    self.emotionImage.image = image;
}

- (UIImage *)image
{
    return self.emotionImage.image;
}

@end
