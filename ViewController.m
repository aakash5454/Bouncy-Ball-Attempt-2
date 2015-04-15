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
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@end

CGPoint pos;
NSTimer *timer;
bool CGRectIntersectsRect(CGRect rect1, CGRect rect2);
BOOL gameOver;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fire.hidden = true;
    self.restartButton.hidden= true;
    //For ballImage
    pos = CGPointMake(15, 35); //keep high value of Y to have ball go in vertical direction
    
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
    draggedView.center = CGPointMake(center.x + offset.x, center.y + 0 ); //offset.y because you dont want to add the offset and keep the center.y same. It is the value that you have set from the story board.
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
        
        if (_ballImage.center.y > screenHeight) //game over ball is missed
        {
            gameOver = true;
            _fire.frame =  _ballImage.frame;
            self.fire.hidden = false;
            self.restartButton.hidden = false; 
        
        }
        
        // CGSize bouncyPadSize = _ballImage.image.size;
        CGRect bouncyPadRect = _bouncyPad.frame;
        CGRect ballImageRect = _ballImage.frame;
        
        
       // bool CGRectIntersectsRect(CGRect rect1, CGRect rect2);
        
        
    if (CGRectIntersectsRect(bouncyPadRect, ballImageRect)) //if CGRectIntersectRect is true
        {
            pos.x = -(pos.x);
            pos.y = -(pos.y);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)restartButtonTapped:(id)sender {

    self.fire.hidden = true;
    self.restartButton.hidden= true;
    
    //For ballImage
    pos = CGPointMake(15, 35.0); //keep value of Y to have ball go in vertical direction
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
    
    //For BouncyPad
    [self.view addSubview:_bouncyPad];
    _bouncyPad.userInteractionEnabled = YES;
    UIPanGestureRecognizer *padPanned = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(bouncyPadTappedOrMoved:)];
    [_bouncyPad addGestureRecognizer:padPanned];

}


@end
