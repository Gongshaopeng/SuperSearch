//
//  PanLoad.m
//  PanGestureTEST
//
//  Created by 巩小鹏 on 16/9/18.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "PanLoad.h"
@interface PanLoad ()
@end;
@implementation PanLoad

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_UI];
    }
    return self;
}

-(void)p_UI{
    
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];

}


-(UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, (HEIGHT-46)/2, 0, 46)];
        _leftView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        
    }
    return _leftView;
}
-(UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]initWithFrame:CGRectMake(0, (HEIGHT-46)/2, 0, 46)];
        _rightView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    }
    return _rightView;
}
-(UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Limg"]];
    }
    return _leftImageView;
}
-(UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Rimg"]];
    }
    return _rightImageView;
}

-(void)setPanGestureRecognizer:(UIView *)view{
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
    _pan.minimumNumberOfTouches = 0.5;  //拖动的最短距离默认是0.5一般不要改
    _pan.maximumNumberOfTouches = WIDTH;//拖动的最长距离
    _pan.delegate = self;
    [view addGestureRecognizer:_pan];
    [view addSubview:self.leftView];
    [view addSubview:self.rightView];
    
}
-(void)panClick:(UIPanGestureRecognizer*)pan{
    //    CGPoint pingers=[pan locationInView:self.view];//得到手指的当前位置
    
    CGPoint point = [pan translationInView:self];//得到手指的位移
//    NSLog(@"%f,%f",point.x,point.y);
    
        if (point.x < 0) {
            if (_isHideRight == YES) {
                if (pan.state == UIGestureRecognizerStateChanged)
                {//            NSLog(@"1--------   %f",point.x);
                    if (point.x > -60) {
                        if (point.x < -48) {
                            [_rightView addSubview:self.rightImageView];
                        }
                        _rightImageView.frame = CGRectMake((point.x+(48*2))/2, (48/2)/2,(48/2), 48/2);
                        _rightView.frame = CGRectMake(WIDTH+point.x, (HEIGHT-48)/2,-point.x, 48);
                    }
                    [self viewFrameRectZeroType:SwipeLeftType];
                }
                if (pan.state == UIGestureRecognizerStateEnded)
                {
                    [pan setTranslation:CGPointZero inView:pan.view];

                    if (point.x < -60) {
                        [self GestureLeftOrRightTyp:SwipeRightType];
                    }
                    [self viewFrameRectZeroType:SwipeRightType];
                }
        }
//        [self setHideLeftOrRightIs:YES];
    }else{
        if (_isHideLeft == YES) {
            if (pan.state == UIGestureRecognizerStateChanged)
            {
                if (point.x < 60) {
                    if (point.x <48) {
                        [_leftView addSubview:self.leftImageView];
                    }
                    _leftImageView.frame = CGRectMake((point.x-24)/2,(48/2)/2,48/2, 48/2);
                    _leftView.frame = CGRectMake(0, (HEIGHT-48)/2,point.x, 48);
                }
                [self viewFrameRectZeroType:SwipeRightType];
            }
            if (pan.state == UIGestureRecognizerStateEnded)
            {
                [pan setTranslation:CGPointZero inView:pan.view];

                if (point.x > 60) {
                    [self GestureLeftOrRightTyp:SwipeLeftType];
                }
                [self viewFrameRectZeroType:SwipeLeftType];
            }
//            [self setHideLeftOrRightIs:NO];
        }
    }
    
    if ([self.slideDelegate respondsToSelector:@selector(swipePoint:pan:)]) {
        [self.slideDelegate swipePoint:point pan:pan];
    }
    
}

-(void)setHideLeftOrRightIs:(BOOL)isHide{

    if (isHide == YES) {
        [self viewFrameRectZeroType:SwipeRightType];
    }else{
        [self viewFrameRectZeroType:SwipeLeftType];
    }

}



-(void)viewFrameRectZeroType:(SwipeType)type{
    switch (type) {
        case SwipeLeftType:
        {
            _leftImageView.frame = CGRectZero;
            [_leftImageView removeFromSuperview];
            _leftView.frame = CGRectMake(0, (HEIGHT-48)/2, 0, 48);
        }
            break;
        case SwipeRightType:
        {
            _rightImageView.frame = CGRectZero;
            [_rightImageView removeFromSuperview];
            _rightView.frame = CGRectMake(0, (HEIGHT-48)/2, 0, 48);
        }
            break;
        default:
            break;
    }
    
}

-(void)GestureLeftOrRightTyp:(SwipeType)type{
    switch (type) {
        case SwipeLeftType:
        {
//            NSLog(@"往左跑");
            [self.slideDelegate swipeLeft];
            [self viewFrameRectZeroType:SwipeLeftType];
        }
            break;
        case SwipeRightType:
        {
//            NSLog(@"往右跑");
            
            [self.slideDelegate swipeRight];
            [self viewFrameRectZeroType:SwipeRightType];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)removeGestureRecognizer:(UIView *)view{
    [view removeGestureRecognizer:_pan];
}
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL _isClass = YES;
    
     _isClass = [self.slideDelegate swipeIsClass];
    
    
    return _isClass;
}
@end
