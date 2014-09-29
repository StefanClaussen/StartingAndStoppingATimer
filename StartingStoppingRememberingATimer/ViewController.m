//
//  ViewController.m
//  StartingStoppingRememberingATimer
//
//  Created by Stefan Claussen on 24/09/2014.
//  Copyright (c) 2014 One foot after the other. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    int currentMinute;
    int currentSeconds;
    BOOL timerIsOn;
}

@property (strong, nonatomic) IBOutlet UILabel *countdownLabel;
@property (strong, nonatomic) IBOutlet UIButton *startAndPauseButtonLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self resetTheTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetTheTimer
{
    currentMinute = 25;
    currentSeconds = 00;
    timerIsOn = NO;
    [self.countdownLabel setText:@"Time : 25:00"];
    [self.startAndPauseButtonLabel setTitle:@"Play" forState:UIControlStateNormal];
}

#pragma mark - Start and pause the timer

- (IBAction)startAndPauseTimer:(UIButton *)sender
{
    if (timerIsOn == NO)
    {
        [self.startAndPauseButtonLabel setTitle:@"Pause" forState:UIControlStateNormal];
        [self startTimer];
        timerIsOn = YES;
    }
    else if (timerIsOn == YES)
    {
        [self.startAndPauseButtonLabel setTitle:@"Play" forState:UIControlStateNormal];
        [self pauseTimer];
        timerIsOn = NO;
    }
}

- (void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:(1)
                                             target: self selector: @selector(timerFired)
                                           userInfo: nil
                                            repeats:YES];
}

- (void)pauseTimer
{
    if (timer != nil) {
        [timer invalidate];
        timer = nil;
    }
}

-(void)timerFired
{
    if((currentMinute>0 || currentSeconds>=0) && currentMinute>=0)
    {
        if(currentSeconds==0)
        {
            currentMinute -= 1;
            currentSeconds=59;
        }
        else if(currentSeconds>0)
        {
            currentSeconds -= 1;
            //[self moveTimerBlock];
        }
        if(currentMinute > -1)
            [self.countdownLabel setText:[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",currentMinute,@":",currentSeconds]];
    }
    else
    {
        [timer invalidate];
    }
}

# pragma mark - Stop and reset the timer

- (IBAction)resetTimerAction:(UIButton *)sender
{
    [self pauseTimer];
    [self resetTheTimer];
}

@end
