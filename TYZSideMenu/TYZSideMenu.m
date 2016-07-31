//
//  TYZSideMenu.m
//  SideMenu
//
//  Created by Tywin on 16/7/22.
//  Copyright © 2016年 zql. All rights reserved.
//

#import "TYZSideMenu.h"

typedef enum : NSUInteger {
    TYZSideMenu_LeftState = 1,
    TYZSideMenu_RightState,
    TYZSideMenu_NoneState,
} TYZOrientationState;

typedef enum : NSUInteger {
    TYZSideMenu_LeftModel = 1,
    TYZSideMenu_RightModel,
    TYZSideMenu_NoneModel,
} TYZSideModel;

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define DefaultLeftVisibleOffset (ScreenWidth-80)
#define DefaultRightVisibleOffset (ScreenWidth-80)

#define LEFT_TAG   100
#define RIGHT_TAG  101
#define CENTER_TAG 102
@interface TYZSideMenu ()
{
    UIView *_coverView;
    UIVisualEffectView *_visualEfView;
    UIPanGestureRecognizer *_panGestureRecognizer;
    CGFloat _startPointX;
    TYZOrientationState _currentState;
    TYZSideModel _currentModel;
}

@end

@implementation TYZSideMenu

- (TYZSideMenu *)initWithContentViewController:(UIViewController *)contentViewController leftSideViewController:(UIViewController *)leftSideViewController rightSideViewController:(UIViewController *)rightSideViewController
{
    self = [super init];
    if (self) {
        _centerViewController = contentViewController;
        _leftSideViewController = leftSideViewController;
        _rightSideViewController = rightSideViewController;
        _leftVisibleOffset = DefaultLeftVisibleOffset;
        _rightVisibleOffset = DefaultRightVisibleOffset;
        self.showAble = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubView];
    if (_leftSideViewController) {
        [self addChildViewController:_leftSideViewController];
    }
    
    if (self.rightSideViewController) {
        [self addChildViewController:_rightSideViewController];
    }
    [self configFrame];
    _currentState = TYZSideMenu_NoneState;
    _currentModel = TYZSideMenu_NoneModel;
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    [self.view addGestureRecognizer:_panGestureRecognizer];
}

- (void)configFrame{
    _centerViewController.view.frame = self.view.frame;
    _leftSideViewController.view.frame = self.view.frame;
    _rightSideViewController.view.frame = self.view.frame;
    CGPoint leftInitCenter = CGPointMake(-ScreenWidth/2, ScreenHeight/2);
    _leftSideViewController.view.center = leftInitCenter;
    CGPoint rightInitCenter = CGPointMake(ScreenWidth+ScreenWidth/2, ScreenHeight/2);
    _rightSideViewController.view.center = rightInitCenter;
}

- (void)addCoverView{
    if(!_coverView && !_visualEfView){
        _coverView = [[UIView alloc] initWithFrame:self.view.frame];
        _coverView.backgroundColor = [UIColor clearColor];
        _visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _visualEfView.frame = _coverView.frame;
        _visualEfView.alpha = 1.0f;
        _coverView.alpha = 0.0f;
        [_coverView addSubview:_visualEfView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAll)];
        [_coverView addGestureRecognizer:tap];
        [self.view addSubview:_coverView];
    }
}

- (void)removeCoverView{
    
    self.isLeftShow = NO;
    self.isRightShow = NO;
    _coverView.hidden = YES;
    _visualEfView = nil;
    _coverView = nil;
    _currentModel = TYZSideMenu_NoneModel;
    [_visualEfView removeFromSuperview];
    [_coverView removeFromSuperview];
    [_leftSideViewController.view removeFromSuperview];
    [_rightSideViewController.view removeFromSuperview];
}

- (void)configSubView{
    [self addChildViewController:_centerViewController];
    [self.view addSubview:_centerViewController.view];
}

- (void)setCenterViewController:(UIViewController *)centerViewController
{
    _centerViewController = nil;
    _centerViewController = centerViewController;
    [[self.view viewWithTag:CENTER_TAG] removeFromSuperview];
    _centerViewController.view.frame = self.view.frame;
    centerViewController.view.tag = CENTER_TAG;
    
    [self.view addSubview:centerViewController.view];
    [self.view sendSubviewToBack:centerViewController.view];
    [self.view setNeedsLayout];
}

- (void)showLeftSideMenu
{
    [self addCoverView];
    self.isLeftShow = YES;
    [self leftAnimate:YES];
}

- (void)showRightSideMenu
{
    
    [self addCoverView];
    self.isRightShow = YES;
    [self rightAnimate:YES];
}

- (void)leftAnimate:(BOOL)closeOrOpen{
    if (!_leftSideViewController) {
        return;
    }
    if(![self.view viewWithTag:LEFT_TAG]){
        [self.view addSubview:_leftSideViewController.view];
    }
    
    self.isLeftShow = closeOrOpen;
    _currentModel = closeOrOpen?TYZSideMenu_LeftModel:TYZSideMenu_NoneModel;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint center;
        if(closeOrOpen){
            _coverView.alpha = 1.0f;
            center = CGPointMake(DefaultLeftVisibleOffset - ScreenWidth/2, ScreenHeight/2);
        }else{
            _coverView.alpha = 0.0f;
            center = CGPointMake(-ScreenWidth/2, ScreenHeight/2);
        }
        
        _leftSideViewController.view.center = center;
    } completion:^(BOOL finished) {
        
        if(!closeOrOpen){
            [self removeCoverView];
        }
        _currentState = TYZSideMenu_NoneState;
    }];
}

- (void)rightAnimate:(BOOL)closeOrOpen{
    if (!_rightSideViewController) {
        return;
    }
    if(![self.view viewWithTag:RIGHT_TAG]){
        [self.view addSubview:_rightSideViewController.view];
    }
    self.isRightShow = closeOrOpen;
    _currentModel = closeOrOpen?TYZSideMenu_RightModel:TYZSideMenu_NoneModel;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint center;
        if(closeOrOpen){
            _coverView.alpha = 1.0f;
            center = CGPointMake((ScreenWidth+ScreenWidth/2)-DefaultLeftVisibleOffset, ScreenHeight/2);
        }else{
            _coverView.alpha = 0.0f;
            center = CGPointMake((ScreenWidth+ScreenWidth/2), ScreenHeight/2);
        }
        
        _rightSideViewController.view.center = center;
    } completion:^(BOOL finished) {
        if(!closeOrOpen){
            [self removeCoverView];
        }
        _currentState = TYZSideMenu_NoneState;
    }];
}



- (void)hiddenAll
{
    
    self.isRightShow = NO;
    self.isLeftShow = NO;
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        _coverView.alpha = 0.0f;
        CGPoint rightCenter = CGPointMake((ScreenWidth+ScreenWidth/2), ScreenHeight/2);
        _rightSideViewController.view.center = rightCenter;
        
        CGPoint leftCenter = CGPointMake(-ScreenWidth/2, ScreenHeight/2);
        _leftSideViewController.view.center = leftCenter;
    } completion:^(BOOL finished) {
        [self removeCoverView];
    }];
}

- (void)leftSideChangeWithXOffset:(CGFloat)pointX withAlphaValue:(CGFloat)alphaValue
{
    [self addCoverView];
    if (!_leftSideViewController) {
        return;
    }
    if(![self.view viewWithTag:LEFT_TAG]){
        [self.view addSubview:_leftSideViewController.view];
    }
    self.isLeftShow = YES;
    _coverView.alpha = alphaValue;
    CGPoint leftCenter = CGPointMake(pointX, ScreenHeight/2);
    _leftSideViewController.view.center = leftCenter;
}

- (void)rightSideChangeWithXOffset:(CGFloat)pointX withAlphaValue:(CGFloat)alphaValue
{
    [self addCoverView];
    if (!_rightSideViewController) {
        return;
    }
    if(![self.view viewWithTag:RIGHT_TAG]){
        [self.view addSubview:_rightSideViewController.view];
    }
    self.isRightShow = YES;
    _coverView.alpha = alphaValue;
    CGPoint rightCenter = CGPointMake(pointX, ScreenHeight/2);
    _rightSideViewController.view.center = rightCenter;
}


- (BOOL)judgePanWithModel:(TYZSideModel)model
{
    BOOL judgeResult = NO;
    if(model == TYZSideMenu_LeftModel){
        if (_leftSideViewController.view.center.x > _leftVisibleOffset-ScreenWidth/2) {
            judgeResult = NO;
        }else{
            judgeResult = YES;
        }
    }else if(model == TYZSideMenu_RightModel){
        if (_rightSideViewController.view.center.x < (ScreenWidth+ScreenWidth/2) - self.rightVisibleOffset) {
            judgeResult = NO;
        }else{
            judgeResult = YES;
        }
    }
    return judgeResult;
}


- (void)handleSwipes:(UIPanGestureRecognizer *)sender
{
    if (!self.showAble) {
        return;
    }
    CGPoint point = [sender locationInView:self.view];
    CGFloat tempPointX = point.x;
    CGFloat tempX = tempPointX-_startPointX;
    CGFloat tempAlpha = fabs(tempX/DefaultLeftVisibleOffset);
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            _startPointX = tempPointX;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if(_currentState != TYZSideMenu_NoneState){
                if(_currentModel == TYZSideMenu_NoneModel){
                    if(_currentState == TYZSideMenu_LeftState){
                        [self leftSideChangeWithXOffset:(-ScreenWidth/2 + tempX) withAlphaValue:tempAlpha];
                    }else{
                        [self rightSideChangeWithXOffset:((ScreenWidth+ScreenWidth/2) + tempX) withAlphaValue:tempAlpha];
                    }
                }else if (_currentModel == TYZSideMenu_LeftModel){
                    if([self judgePanWithModel:_currentModel]){
                        [self leftSideChangeWithXOffset:(DefaultLeftVisibleOffset - ScreenWidth/2 + tempX) withAlphaValue:1.0f - tempAlpha];
                    }
                }else if (_currentModel == TYZSideMenu_RightModel){
                    if([self judgePanWithModel:_currentModel]){
                        [self rightSideChangeWithXOffset:((ScreenWidth+ScreenWidth/2)-DefaultLeftVisibleOffset + tempX) withAlphaValue:1.0f - tempAlpha];
                    }
                }
                
            }else{
                if (tempPointX - _startPointX > 0.01f) {
                    //从左边划起
                    if (_currentModel != TYZSideMenu_LeftModel) {
                        _currentState = TYZSideMenu_LeftState;
                    }
                }
                
                if (tempPointX - _startPointX < 0.01f) {
                    //从右划起
                    if (_currentModel != TYZSideMenu_RightModel) {
                        _currentState = TYZSideMenu_RightState;
                    }
                }
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self gestureRecognizerStateEndAndCancle:tempX];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self gestureRecognizerStateEndAndCancle:tempX];
        }
            break;
        default:
            break;
    }
}

- (void)gestureRecognizerStateEndAndCancle:(CGFloat)tempX
{
    if(_currentModel == TYZSideMenu_NoneModel){
        if(_currentState == TYZSideMenu_LeftState){
            if(tempX >= 50.0f){
                [self leftAnimate:YES];
            }else{
                [self leftAnimate:NO];
            }
        }else{
            if(tempX <= -50.0f){
                [self rightAnimate:YES];
            }else{
                [self rightAnimate:NO];
            }
        }
    }else if (_currentModel == TYZSideMenu_LeftModel){
        if (_currentState != TYZSideMenu_NoneState) {
            if(tempX <= -50.0f){
                [self leftAnimate:NO];
            }else{
                [self leftAnimate:YES];
            }
        }
    }else if (_currentModel == TYZSideMenu_RightModel){
        if (_currentState != TYZSideMenu_NoneState) {
            if(tempX >= 50.0f){
                [self rightAnimate:NO];
            }else{
                [self rightAnimate:YES];
            }
        }
    }
    
    _currentState = TYZSideMenu_NoneState;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
