//
//  ViewController.m
//  Bouncy Ball Attempt 2
//
//  Created by Sky on 4/14/15.
//  Copyright (c) 2015 com.sky. All rights reserved.
// 

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *bouncyBall;
@property (strong, nonatomic) IBOutlet UIImageView *bouncyPad;
@property (strong, nonatomic) IBOutlet UIImageView *BallOnFire;

@property (strong, nonatomic) AudioController *audioController;
@property (strong, atomic) IBOutletCollection(UIImageView) NSArray *brick;

@end

CGPoint pos;
NSTimer *timer;
bool CGRectIntersectsRect(CGRect rect1, CGRect rect2);
BOOL gameOver;
BOOL brick;

// Added comment
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self restartGame];
}

-(void)restartGame
{
    self.BallOnFire.hidden = true;
    self.bouncyBall.hidden =false;
    [timer invalidate];
    timer = nil; 
    gameOver = false; 
    //For ballImage
    pos = CGPointMake(10,10); //increase the value of Y to have ball go in vertical direction
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
    
    //For BouncyPad
    [self.view addSubview:_bouncyPad];
    _bouncyPad.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *padPanned = [[UIPanGestureRecognizer alloc]initWithTarget:self  action:@selector(bouncyPadTappedOrMoved:)];
    [_bouncyPad addGestureRecognizer:padPanned];
    
    //To Play Background Music
    self.audioController = [[AudioController alloc] init];
    [self.audioController tryPlayMusic];
    
   //Make sure all Bricks are visible

   //self.brick.hidden = NO;
}

- (void) bouncyPadTappedOrMoved: (UIPanGestureRecognizer *) padPanned
{
    UIView *draggedView = padPanned.view;
    CGPoint offset = [padPanned translationInView:draggedView.superview];
    CGPoint center = draggedView.center;
    draggedView.center = CGPointMake(center.x + offset.x, center.y ); //offset.y :because you dont want to add the offset and keep the center.y same. It is the value that you have set from the story board.
    [padPanned setTranslation:CGPointZero inView:draggedView.superview];
}

-(void) moveBall
{
    if (!gameOver)  //if game is not over
    {
        //current position of ball = _ballImage.center.x from storborad & pos.x is seed value providede in viewDidLoad
        
        // They are added eachtime the Timer calls moveBall method & hence the ball keeps on moving in animation.
        
        _bouncyBall.center = CGPointMake(_bouncyBall.center.x + pos.x,  _bouncyBall.center.y + pos.y);
        
        //Added to get the screen frame to make it work for all screen size.
        CGRect screenRect = self.view.frame;//[[UIScreen mainScreen]bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;

        if (_bouncyBall.center.x + _bouncyBall.frame.size.width > screenWidth  || _bouncyBall.center.x  - _bouncyBall.frame.size.height < 0)
            {
                pos.x = -(pos.x);
            }
        
        if ( _bouncyBall.center.y < 0) //_ballImage.center.y > screenHeight ||
            {
                pos.y = -(pos.y);
            }
        
//--->  //game over, when ball is missed
        if (_bouncyBall.center.y > screenHeight-30)
        {
            gameOver = true;
            _BallOnFire.center = _bouncyBall.center;
            self.BallOnFire.hidden = false;
            self.bouncyBall.hidden=true;
            
            //You Lose Audio
            [self.audioController playShotGunFireSound];
    
            //You Lose Alert
            NSString *message = @"Try again?";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You Lose!" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [self restartGame];
                                                                  }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];

        }
    
//--->  //When bouncyPad and Ball collide, keep this
        CGRect bouncyPadRect = _bouncyPad.frame;
        CGRect ballImageRect = _bouncyBall.frame;
        

        //ball co-ordinates
        CGPoint ballRightSideLeftPoint = CGPointMake(_bouncyBall.frame.origin.x , _bouncyBall.frame.origin.y + _bouncyBall.frame.size.height);
        CGPoint ballLeftSideRightPoint = CGPointMake(_bouncyBall.frame.origin.x + 30, _bouncyBall.frame.origin.y + _bouncyBall.frame.size.height);
        //pad co-ordinates
        CGPoint padRightSideLeftPoint = CGPointMake(_bouncyPad.frame.origin.x+_bouncyPad.frame.size.width, _bouncyPad.frame.origin.y+1);
        CGPoint padLeftSideRightPoint = CGPointMake(_bouncyPad.frame.origin.x, _bouncyPad.frame.origin.y+1);

        if (CGPointEqualToPoint(ballRightSideLeftPoint, padRightSideLeftPoint) || CGPointEqualToPoint(ballLeftSideRightPoint, padLeftSideRightPoint))
        {
            pos.x = -(pos.x);
            pos.y = -(pos.y);
        }
        
      if (CGRectIntersectsRect(bouncyPadRect, ballImageRect ))
        //(bouncyPadRect, ballImageRect)) //if CGRectIntersectRect is true
        {
               // pos.x = -(pos.x);
               pos.y = -(pos.y);
        }
        [self onBrickCollision];
      
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- onBrickCollision
-(void) onBrickCollision
{

    for (UIImageView *brick in self.brick)
    {

    if (CGRectIntersectsRect(_bouncyBall.frame, brick.frame) && brick.hidden==false) //if CGRectIntersectRect is true
        {

            pos.x = -(pos.x);
            pos.y = -(pos.y);
            brick.hidden = true;
          //  NSLog(@"value bla: %d", brick.hidden);
            NSLog(@"Hidden brick is: %ld",(long)brick.tag);
            [self.audioController playSystemSound];

        }
    }
    
    if (gameOver == true)
    {
       // gameOver = true;
       // NSLog(@"gameover value %d", gameOver);
        
        //Code for You Win Alert
        NSString *message = @"Congratulations you are a champion";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You Win!" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}


@end
