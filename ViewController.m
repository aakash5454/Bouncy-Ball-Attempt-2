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

@property (weak, nonatomic) IBOutlet UIImageView *ballImage;
@property (weak, nonatomic) IBOutlet UIImageView *bouncyPad;
@property (weak, nonatomic) IBOutlet UIImageView *fire;


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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fire.hidden = true;
   
    //For ballImage
    pos = CGPointMake(-14,-17); //keep value of Y to have ball go in vertical direction
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
    
    //For BouncyPad
    [self.view addSubview:_bouncyPad];
    _bouncyPad.userInteractionEnabled = YES;
    UIPanGestureRecognizer *padPanned = [[UIPanGestureRecognizer alloc]initWithTarget:self  action:@selector(bouncyPadTappedOrMoved:)];
    [_bouncyPad addGestureRecognizer:padPanned];
}

- (void) bouncyPadTappedOrMoved: (UIPanGestureRecognizer *) padPanned
{
    UIView *draggedView = padPanned.view;
    CGPoint offset = [padPanned translationInView:draggedView.superview];
    CGPoint center = draggedView.center;
    draggedView.center = CGPointMake(center.x + offset.x, center.y ); //offset.y because you dont want to add the offset and keep the center.y same. It is the value that you have set from the story board.
    [padPanned setTranslation:CGPointZero inView:draggedView.superview];
    
}
-(void) moveBall
{

    if (!gameOver)  //if game is not over
    {
        //current position of ball = _ballImage.center.x from storborad & pos.x is seed value providede in viewDidLoad
        
        // They are added eachtime the Timer calls moveBall method & hence the ball keeps on moving in animation.
        
        _ballImage.center = CGPointMake(_ballImage.center.x + pos.x,  _ballImage.center.y + pos.y);
        
        //Added to get the screen bounds to make it work for all screen size.
        CGRect screenRect = [[UIScreen mainScreen]bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;

        if (_ballImage.center.x > screenWidth || _ballImage.center.x < 0)
            {
                pos.x = -(pos.x);
            }
        
        //&
        
        if ( _ballImage.center.y < 0) //_ballImage.center.y > screenHeight ||
            {
                pos.y = -(pos.y);
            }
        
        if (_ballImage.center.y > screenHeight) //game over, ball is missed
        {
            gameOver = true;
            _fire.frame =  _ballImage.frame;
            self.fire.hidden = false;
        
        }
        
        // CGSize bouncyPadSize = _ballImage.image.size;
        CGRect bouncyPadRect = _bouncyPad.frame;
        CGRect ballImageRect = _ballImage.frame;
        
        
       // bool CGRectIntersectsRect(CGRect rect1, CGRect rect2);
        
    //When bouncyPad and Ball collide keep this
    if (CGRectIntersectsRect(bouncyPadRect, ballImageRect)) //if CGRectIntersectRect is true
        {
            pos.x = -(pos.x);
            pos.y = -(pos.y);
        }
    
        [self collissionCheck];
        
//New chabge:
        
        
//        
//        [self detetingTheBrickOnCollision1];
//        [self detetingTheBrickOnCollision2];
//        [self detetingTheBrickOnCollision3];
//        [self detetingTheBrickOnCollision4];
//        [self detetingTheBrickOnCollision5];
//        [self detetingTheBrickOnCollision6];
//        [self detetingTheBrickOnCollision7];
//        [self detetingTheBrickOnCollision8];
//        [self detetingTheBrickOnCollision9];
//        [self detetingTheBrickOnCollision10];
//        [self detetingTheBrickOnCollision11];
//        [self detetingTheBrickOnCollision12];
//        [self detetingTheBrickOnCollision13];
//        [self detetingTheBrickOnCollision14];
//        [self detetingTheBrickOnCollision15];
//        [self detetingTheBrickOnCollision16];
//        [self detetingTheBrickOnCollision17];
//        [self detetingTheBrickOnCollision18];

        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) collissionCheck {



    if (CGRectIntersectsRect(_ballImage.frame, _brick1.frame) && self.brick1.hidden==false) //if CGRectIntersectRect is true
    
    {
        
    pos.x = -(pos.x);
    pos.y = -(pos.y);
    self.brick1.hidden = true;
    }
    
    
    
    
    else if (CGRectIntersectsRect(_ballImage.frame, _brick2.frame) && self.brick2.hidden==false) //if CGRectIntersectRect is true
    
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick2.hidden = true;
    }
    
    
    else if (CGRectIntersectsRect(_ballImage.frame, _brick3.frame) && self.brick3.hidden==false) //if CGRectIntersectRect is true
    {
     
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick3.hidden = true;
    }

    
    
else     if (CGRectIntersectsRect(_ballImage.frame, _brick4.frame) && self.brick4.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick4.hidden = true;

    }
    
    else if (CGRectIntersectsRect(_ballImage.frame, _brick5.frame) && self.brick5.hidden==false) //if CGRectIntersectRect is true
    {
     
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick5.hidden = true;
    }

    
    else if (CGRectIntersectsRect(_ballImage.frame, _brick6.frame) && self.brick6.hidden==false) //if CGRectIntersectRect is true
    {

        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick6.hidden = true;
    }
    
    
   else  if (CGRectIntersectsRect(_ballImage.frame, _brick7.frame) && self.brick7.hidden==false) //if CGRectIntersectRect is true
    {

        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick7.hidden = true;
    }
    
    
   else  if (CGRectIntersectsRect(_ballImage.frame, _brick8.frame) && self.brick8.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick8.hidden = true;

    }
    
   else  if (CGRectIntersectsRect(_ballImage.frame, _brick9.frame) && self.brick9.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick9.hidden = true;

    }
    
    
   else  if (CGRectIntersectsRect(_ballImage.frame, _brick10.frame) && self.brick10.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick10.hidden = true;

    }
    
  else   if (CGRectIntersectsRect(_ballImage.frame, _brick11.frame) && self.brick11.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick11.hidden = true;
        return;
    }
    
   else  if (CGRectIntersectsRect(_ballImage.frame, _brick12.frame) && self.brick12.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick12.hidden = true;
    }
    
    
   else  if (CGRectIntersectsRect(_ballImage.frame, _brick13.frame) && self.brick13.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick13.hidden = true;
    }
    
    
   else  if (CGRectIntersectsRect(_ballImage.frame, _brick14.frame) && self.brick14.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick14.hidden = true;
    }
    
    
    
   else if (CGRectIntersectsRect(_ballImage.frame, _brick15.frame) && self.brick15.hidden==false) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick15.hidden = true;
    }
    

}
/*
- (void) detetingTheBrickOnCollision1
{
 
    if (CGRectIntersectsRect(_ballImage.frame, _brick1.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick1.hidden = true;
    }
}

- (void) detetingTheBrickOnCollision2
{
 
    if (CGRectIntersectsRect(_ballImage.frame, _brick2.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick2.hidden = true;
    }
 
}

- (void) detetingTheBrickOnCollision3
{
 
    if (CGRectIntersectsRect(_ballImage.frame, _brick3.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick3.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision4
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick4.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick4.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision5
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick5.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick5.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision6
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick6.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick6.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision7
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick7.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick7.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision8
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick8.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick8.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision9
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick9.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick9.hidden = true;
    }
    
}



- (void) detetingTheBrickOnCollision10
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick10.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick10.hidden = true;
    }
    
}

 
- (void) detetingTheBrickOnCollision11
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick11.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick11.hidden = true;
    }
    
}
- (void) detetingTheBrickOnCollision12
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick12.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick12.hidden = true;
    }
    
}
- (void) detetingTheBrickOnCollision13
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick13.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick13.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision14
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick14.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick14.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision15
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick15.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick15.hidden = true;
    }
    
}

- (void) detetingTheBrickOnCollision16
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick16.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick16.hidden = true;
    }
    
}

    - (void) detetingTheBrickOnCollision17
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick17.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick17.hidden = true;
    }
    
}
- (void) detetingTheBrickOnCollision18
{
    
    if (CGRectIntersectsRect(_ballImage.frame, _brick18.frame)) //if CGRectIntersectRect is true
    {
        pos.x = -(pos.x);
        pos.y = -(pos.y);
        self.brick18.hidden = true;
    }
    
}
*/

    
@end
