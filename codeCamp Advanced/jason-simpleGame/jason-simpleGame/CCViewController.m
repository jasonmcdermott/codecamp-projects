//
//  CCViewController.m
//  jason-simpleGame
//
//  Created by coding on 2/07/2014.
//  Copyright (c) 2014 codeCamp. All rights reserved.
//

#import "CCViewController.h"

@interface CCViewController ()
{
    int score;
    int lives;
    int highScore;
}

@property (weak, nonatomic) IBOutlet UIButton *hitMeButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
@property (weak, nonatomic) IBOutlet UIButton *loseLifeButton;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    score = 0;
    lives = 3;
    
    highScore = [[NSUserDefaults standardUserDefaults]
                 integerForKey:@"highScore"];
    
    self.hitMeButton.hidden = TRUE;
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(showButton) userInfo:nil repeats:YES];
    [self updateLabels];
}

- (void)showButton {
    int randomHeightInt = roundf(self.view.frame.size.height - self.hitMeButton.frame.size.height)-50;
    int randomWidthInt = roundf(self.view.frame.size.width - self.hitMeButton.frame.size.width) - 20;
    int randomHeight = arc4random() %randomHeightInt + 50;
    int randomWidth = arc4random() % randomWidthInt + 20;
    self.hitMeButton.frame =
    CGRectMake(randomWidth,
               randomHeight,
               self.hitMeButton.frame.size.width,
               self.hitMeButton.frame.size.height );
    
    self.hitMeButton.hidden = FALSE;
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(hideButton)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)hideButton {
    self.hitMeButton.hidden = TRUE;
}

- (IBAction)pressHitMeButton:(UIButton *)sender
{
    score++;
    if (score > highScore) {
        highScore = score;
        [[NSUserDefaults standardUserDefaults]
         setObject:[NSNumber numberWithInt:highScore]
         forKey:@"highScore"];
    }
    [self updateLabels];
}

- (IBAction)pressLoseLifeButton:(UIButton *)sender
{
    lives--;
    self.livesLabel.text =
    [NSString stringWithFormat:@"Lives: %d",lives];
    if (lives == 0) {
        // game is over!

        score = 0;
        lives = 3;
        
        UIAlertView *alertView =
        [[UIAlertView alloc]
         initWithTitle:@"Oh no!"
         message:@"game over, friend!"
         delegate:self
         cancelButtonTitle:@"Try again"
         otherButtonTitles:nil];
        [alertView show];
        
    }
    [self updateLabels];
}

- (void)updateLabels
{
    self.scoreLabel.text =
    [NSString stringWithFormat:@"Score: %d",score];
    
    self.livesLabel.text =
    [NSString stringWithFormat:@"Lives: %d",lives];
    
    self.highScoreLabel.text =
    [NSString stringWithFormat:@"High Score: %d",highScore];
}

@end
