//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//
//  ViewController.m
//  Bouncy Ball Attempt 2
//
//  Created by Sky on 4/14/15.
//  Copyright (c) 2015 com.sky. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bouncyBall;
@property (weak, nonatomic) IBOutlet UIImageView *bouncyPad;
@property (weak, nonatomic) IBOutlet UIImageView *BallOnFire;

@property (strong, nonatomic) AudioController *audioController;


@property (weak, nonatomic) IBOutlet UIImageView *brick1;
@property (weak, nonatomic) IBOutlet UIImageView *brick2;
@property (weak, nonatomic) IBOutlet UIImageView *brick3;
@property (weak, nonatomic) IBOutlet UIImageView *brick4;
@property (weak, nonatomic) IBOutlet UIImageView *brick5;
@property (weak, nonatomic) IBOutlet UIImageView *brick6;
@property (weak, nonatomic) IBOutlet UIImageView *brick7;
@property (weak, nonatomic) IBOutlet UIImageView *brick8;
@property (weak, nonatomic) IBOutlet UIImageView *brick9;
@property (weak, nonatomic) IBOutlet UIImageView *brick10;
@property (weak, nonatomic) IBOutlet UIImageView *brick11;
@property (weak, nonatomic) IBOutlet UIImageView *brick12;
@property (weak, nonatomic) IBOutlet UIImageView *brick13;
@property (weak, nonatomic) IBOutlet UIImageView *brick14;
@property (weak, nonatomic) IBOutlet UIImageView *brick15;

@property (weak, nonatomic) IBOutlet UIImageView *brick16;
@property (weak, nonatomic) IBOutlet UIImageView *brick17;
@property (weak, nonatomic) IBOutlet UIImageView *brick18;

@end

CGPoint pos;
NSTimer *timer;
bool CGRectIntersectsRect(CGRect rect1, CGRect rect2);
BOOL gameOver;

BOOL brick1;
BOOL brick2;
BOOL brick3;
BOOL brick4;
BOOL brick5;
BOOL brick6;
BOOL brick7;
BOOL brick8;
BOOL brick9;
BOOL brick10;
BOOL brick11;
BOOL brick12;
BOOL brick13;
BOOL brick14;
BOOL brick15;

// Added comment
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self restartGame];
    //    self.BallOnFire.hidden = true;
    //
    //    //For ballImage
    //    pos = CGPointMake(10,10); //increase the value of Y to have ball go in vertical direction
    //
    //    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
    //
    //    //For BouncyPad
    //    [self.view addSubview:_bouncyPad];
    //    _bouncyPad.userInteractionEnabled = YES;
    //    UIPanGestureRecognizer *padPanned = [[UIPanGestureRecognizer alloc]initWithTarget:self  action:@selector(bouncyPadTappedOrMoved:)];
    //    [_bouncyPad addGestureRecognizer:padPanned];
    //
    //    //To Play Background Music
    //   self.audioController = [[AudioController alloc] init];
    //    [self.audioController tryPlayMusic];
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
        self.brick1.hidden = false;
        self.brick2.hidden = false;
        self.brick3.hidden = false;
        self.brick4.hidden = false;
        //    self.brick5.hidden = false;
        self.brick6.hidden = false;
        self.brick7.hidden = false;
        self.brick8.hidden = false;
        self.brick9.hidden = false;
        //    self.brick10.hidden = false;
        self.brick11.hidden = false;
        self.brick12.hidden = false;
        self.brick13.hidden = false;
        self.brick14.hidden = false;
        //    self.brick15.hidden = false;
        //    self.brick16.hidden = false;
        //    self.brick17.hidden = false;
        //    self.brick18.hidden = false;
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
            
            //Added to get the screen bounds to make it work for all screen size.
            CGRect screenRect = self.view.frame;//[[UIScreen mainScreen]bounds];
            CGFloat screenWidth = screenRect.size.width;
            CGFloat screenHeight = screenRect.size.height;
            
            if (_bouncyBall.center.x + 15 > screenWidth  || _bouncyBall.center.x  - 15 < 0)
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
            
            
            CGPoint rightSideLeftPoint = CGPointMake(_bouncyBall.frame.origin.x , _bouncyBall.frame.origin.y + 30);
            CGPoint leftSideRightPoint = CGPointMake(_bouncyBall.frame.origin.x + 30, _bouncyBall.frame.origin.y + 30);
            
            
            if ((CGRectContainsPoint(bouncyPadRect, rightSideLeftPoint )) || (CGRectContainsPoint(bouncyPadRect, leftSideRightPoint )))
            {
                pos.x = -(pos.x);
                pos.y = -(pos.y);
                
            }
            
            if (CGRectIntersectsRect(bouncyPadRect, ballImageRect ))
                //(bouncyPadRect, ballImageRect)) //if CGRectIntersectRect is true
            {
                pos.x = -(pos.x);
                pos.y = -(pos.y);
                
                
                //        if (_bouncyBall.frame.origin.y + 30  == _bouncyPad.frame.origin.y)
                //        {
                //            pos.x = -(pos.x);
                //            pos.y = -(pos.y);
                //        }
                
                
                //  NSLog(@"  x position %f",pos.x);
                //  NSLog(@"  y position %f",pos.y);
            }
            
            [self onBrickCollision];
            // NSLog(@"x co %f", _bouncyBall.center.x);
            //NSLog(@"y co %f", _bouncyBall.center.y);
            
        }
    }
    
    
    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#pragma mark- onBrickCollision
-(void) onBrickCollision {
    
    //brick1
    if (CGRectIntersectsRect(_bouncyBall.frame, _brick1.frame) && self.brick1.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick1.hidden = true;
        brick1 = true;
        NSLog(@"1 value %d", self.brick1.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick2
    else if (CGRectIntersectsRect(_bouncyBall.frame, _brick2.frame) && self.brick2.hidden==false) //if CGRectIntersectRect is true
        
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick2.hidden = true;
        brick2 = true;
        NSLog(@"2 value %d", self.brick2.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick3
    else if (CGRectIntersectsRect(_bouncyBall.frame, _brick3.frame) && self.brick3.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick3.hidden = true;
        brick3 = true;
        NSLog(@"3 value %d", self.brick3.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick4
    else  if (CGRectIntersectsRect(_bouncyBall.frame, _brick4.frame) && self.brick4.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick4.hidden = true;
        brick4 = true;
        NSLog(@"4 value %d", self.brick4.hidden);
        [self.audioController playSystemSound];
    }
        
        //    //brick5
        //    else if (CGRectIntersectsRect(_bouncyBall.frame, _brick5.frame) && self.brick5.hidden==false) //if CGRectIntersectRect is true
        //    {
        //
        //        pos.x = -(pos.x);
        //        pos.y = -(pos.y);
        //        self.brick5.hidden = true;
        //        brick5 = true;
        //         NSLog(@"5 value %d", self.brick5.hidden);
        //    }
        
        //brick6
    else if (CGRectIntersectsRect(_bouncyBall.frame, _brick6.frame) && self.brick6.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick6.hidden = true;
        brick6 = true;
        NSLog(@"6 value %d", self.brick6.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick7
    else  if (CGRectIntersectsRect(_bouncyBall.frame, _brick7.frame) && self.brick7.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick7.hidden = true;
        brick7 = true;
        NSLog(@"7 value %d", self.brick7.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick8
    else  if (CGRectIntersectsRect(_bouncyBall.frame, _brick8.frame) && self.brick8.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick8.hidden = true;
        brick8 = true;
        NSLog(@"8 value %d", self.brick8.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick9
    else  if (CGRectIntersectsRect(_bouncyBall.frame, _brick9.frame) && self.brick9.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick9.hidden = true;
        brick9 = true;
        NSLog(@"9 value %d", self.brick9.hidden);
        [self.audioController playSystemSound];
    }
        
        //   //brick10
        //   else  if (CGRectIntersectsRect(_bouncyBall.frame, _brick10.frame) && self.brick10.hidden==false) //if CGRectIntersectRect is true
        //    {
        //        pos.x = -(pos.x);
        //        pos.y = -(pos.y);
        //
        //        self.brick10.hidden = true;
        //        brick10 = true;
        //         NSLog(@"10 value %d", self.brick10.hidden);
        //    }
        
        //brick11
    else   if (CGRectIntersectsRect(_bouncyBall.frame, _brick11.frame) && self.brick11.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick11.hidden = true;
        brick11 = true;
        NSLog(@"11 value %d", self.brick11.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick12
    else  if (CGRectIntersectsRect(_bouncyBall.frame, _brick12.frame) && self.brick12.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick12.hidden = true;
        brick12 = true;
        NSLog(@"12 value %d", self.brick12.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick13
    else  if (CGRectIntersectsRect(_bouncyBall.frame, _brick13.frame) && self.brick13.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick13.hidden = true;
        brick13 = true;
        NSLog(@"13 value %d", self.brick13.hidden);
        [self.audioController playSystemSound];
    }
        
        //brick14
    else  if (CGRectIntersectsRect(_bouncyBall.frame, _brick14.frame) && self.brick14.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick14.hidden = true;
        brick14 = true;
        NSLog(@"14 value %d", self.brick14.hidden);
        [self.audioController playSystemSound];
    }
    
    //   //brick15
    //   else if (CGRectIntersectsRect(_bouncyBall.frame, _brick15.frame) && self.brick15.hidden==false) //if CGRectIntersectRect is true
    //    {
    //        pos.x = -(pos.x);
    //        pos.y = -(pos.y);
    //        self.brick15.hidden = true;
    //        brick15 = true;
    //        NSLog(@"15 value %d", self.brick15.hidden);
    //    }
    
    if (brick1 == true && brick2 == true && brick3 == true && brick4 == true  && brick6 == true && brick7 == true && brick8 == true && brick9 == true  && brick11 == true && brick12 == true && brick13 == true && brick14 == true )//&& brick15 == true && brick5 == true && brick10 == true)
    {
        gameOver = true;
        NSLog(@"gameover value %d", gameOver);
        
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
