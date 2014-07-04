
#import "CCViewController.h"

@interface CCViewController ()
{
    int score,lives,highScore,timeLeft;
    BOOL playing;
}

@property (weak, nonatomic) IBOutlet UIButton *hitMeButton;
@property (weak, nonatomic) IBOutlet UIButton *loseLifeButton;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *addTimeButton;

@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // do any additional...
    
UITapGestureRecognizer *gestureRecogniser =
[[UITapGestureRecognizer alloc] initWithTarget:self
                                        action:@selector(handleTap:)];

gestureRecogniser.numberOfTapsRequired = 1;
[self.view addGestureRecognizer:gestureRecogniser];

[self resetGame];
    
    self.hitMeButton.hidden = YES;
    self.loseLifeButton.hidden = YES;
    self.addTimeButton.hidden = YES;
    playing = NO;
    
    highScore = [[NSUserDefaults standardUserDefaults]
                 integerForKey:@"highScore"];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(showButton) userInfo:nil repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    
    [self updateLabels];
}

#pragma mark - Game Logic

- (void)endGame
{
    if (playing) {
        playing = NO;
        [self hideButton];
        
        [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];

        if (score > highScore) {
            highScore = score;
            [[NSUserDefaults standardUserDefaults]
             setObject:[NSNumber numberWithInt:highScore]
             forKey:@"highScore"];
        }
        
        UIAlertView *alertView =
        [[UIAlertView alloc]
         initWithTitle:@"Game Over!"
         message:[NSString stringWithFormat:@"You scored %d",score]
         delegate:self
         cancelButtonTitle:@"Try again"
         otherButtonTitles:nil];
        [alertView show];
        
        [self resetGame];
    }
}

- (void)showButton {
    
    if (playing) {
        
        int buttonSelection = arc4random() % 3;
        
        if (buttonSelection == 1) {
            self.hitMeButton.frame = [self makeFrameForButton:self.hitMeButton];
            self.hitMeButton.hidden = FALSE;
        } else if (buttonSelection == 0) {
            self.loseLifeButton.frame = [self makeFrameForButton:self.loseLifeButton];
            self.loseLifeButton.hidden = FALSE;
        } else if (buttonSelection == 2) {
            self.addTimeButton.frame = [self makeFrameForButton:self.addTimeButton];
            self.addTimeButton.hidden = FALSE;
        }
        
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(hideButton)
                                       userInfo:nil
                                        repeats:NO];
    }
}

- (CGRect)makeFrameForButton:(UIButton*)button
{
    int randomHeightInt = roundf(self.view.frame.size.height - self.hitMeButton.frame.size.height)-50;
    int randomWidthInt = roundf(self.view.frame.size.width - self.hitMeButton.frame.size.width) - 20;
    int randomHeight = arc4random() %randomHeightInt + 50;
    int randomWidth = arc4random() % randomWidthInt + 20;
    
    CGRect frame = CGRectMake(randomWidth,
               randomHeight,
               button.frame.size.width,
               button.frame.size.height );
    return frame;
}

#pragma mark - Interface Elements

- (void)handleTap:(UIGestureRecognizer*)tap {
    
    if  (playing) {
//        score--;
        [self updateLabels];
        if (score < 0) {
            [self endGame];
        }
    }
}

- (IBAction)pressHitMeButton:(UIButton *)sender
{
    if (playing) {
        score++;
        [self updateLabels];
        [self hideButton];
    }
}

- (IBAction)pressLoseLifeButton:(UIButton *)sender
{
    if (playing) {
        lives--;
        [self updateLabels];
        if (lives == 0) {
            [self endGame];
        }
    }
}

- (IBAction)pressAddMoreTimeButton:(UIButton *)sender {
    timeLeft += 3;
}

- (IBAction)pressPlayPause:(UIButton *)sender {
    if (playing) {
        playing = NO;
        [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
        self.resetButton.hidden = NO;
    } else {
        [self.playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        playing = YES;
        self.resetButton.hidden = YES;
        [self resetGame];
    }
}

#pragma mark - Utilities

- (void)hideButton {
    self.hitMeButton.hidden = TRUE;
    self.loseLifeButton.hidden = TRUE;
    self.addTimeButton.hidden = TRUE;
}

- (IBAction)pressResetButton:(UIButton *)sender {
    if (!playing) {
        highScore = 0;
        score = 0;
        [[NSUserDefaults standardUserDefaults]
         setObject:[NSNumber numberWithInt:highScore]
         forKey:@"highScore"];
    }
    [self updateLabels];
}

- (void)updateLabels
{
    self.highScoreLabel.text =
    [NSString stringWithFormat:@"High Score: %d",highScore];
    
    self.scoreLabel.text =
    [NSString stringWithFormat:@"Score: %d",score];
    
    self.livesLabel.text =
    [NSString stringWithFormat:@"Lives: %d",lives];
    
    if (playing) {
        self.timeLeftLabel.hidden = NO;
        self.timeLeftLabel.text =
        [NSString stringWithFormat:@"Time left: %d",timeLeft];
    } else {
        self.timeLeftLabel.hidden = YES;
    }
}

- (void)countDown
{
    if (playing) {
        timeLeft --;
        if (timeLeft == 0) {
            [self endGame];
        }
    }
    [self updateLabels];
}

- (void)resetGame
{
    score = 0;
    lives = 3;
    timeLeft = 30;
}

@end
