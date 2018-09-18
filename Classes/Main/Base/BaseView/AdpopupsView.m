//
//  AdpopupsView.m
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/11/10.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import "AdpopupsView.h"
// 角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface AdpopupsView ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIWindow * lastWindow;
/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;
/** 背景层 */
@property (nonatomic, strong) UIView *backgroundView;
/** 自定义视图 */
@property (nonatomic, strong) UIView *customView;
/** 关闭按钮 */
@property (nonatomic, strong) UIButton *dissBtn;
/** 显示时动画弹框样式 */
@property (nonatomic) GSAnimationPopStyle animationPopStyle;
/** 移除时动画弹框样式 */
@property (nonatomic) GSAnimationDismissStyle animationDismissStyle;
/** 显示时背景是否透明，透明度是否为<= 0，默认为NO */
@property (nonatomic) BOOL isTransparent;

@end

@implementation AdpopupsView

- (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView
                                   popStyle:(GSAnimationPopStyle)popStyle
                               dismissStyle:(GSAnimationDismissStyle)dismissStyle
                                   newStyle:(GSPopStyle)newStyle
{
    // 检测自定义视图是否存在(check customView is exist)
    if (!customView) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        
        _isClickBGDismiss = NO;
        _isObserverOrientationChange = NO;
        _popBGAlpha = 0.5f;
        _isTransparent = NO;
        _customView = customView;
        _animationPopStyle = popStyle;
        _animationDismissStyle = dismissStyle;
        _popAnimationDuration = -0.1f;
        _dismissAnimationDuration = -0.1f;
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.0f;
        [self addSubview:_backgroundView];
        
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
//        _contentView.center = self.center;
        
        
        _contentView.userInteractionEnabled = YES;
        _customView.userInteractionEnabled = YES;
        _customView.center = self.center;
        [_contentView addSubview:_customView];
        [self addSubview:_contentView];
        
        switch (newStyle) {
            case GSAnimationPopStyleTapYes:
            {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBGLayer:)];
                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCustomClick)];
                tap.delegate = self;
                tapGestureRecognizer.delegate = self;
                [_customView addGestureRecognizer:tapGestureRecognizer];
                [_contentView addGestureRecognizer:tap];

            }
                break;
            case GSAnimationPopStyledissBtn:
            {
                _dissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _dissBtn.frame = CGRectMake((__kScreenWidth__ - __kNewSize(64))/2, _customView.frame.origin.y+_customView.frame.size.height+__kNewSize(32), __kNewSize(64), __kNewSize(64));
                [_dissBtn setBackgroundImage:[UIImage imageNamed:@"window_close"] forState:UIControlStateNormal];
                [_dissBtn addTarget:self action:@selector(dissClick) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_dissBtn];
            }
                break;
            default:
                break;
        }
        
        
      
        
    }
    return self;
}

- (void)setIsObserverOrientationChange:(BOOL)isObserverOrientationChange
{
    _isObserverOrientationChange = isObserverOrientationChange;
    
    if (_isObserverOrientationChange) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
}

- (void)setPopBGAlpha:(CGFloat)popBGAlpha
{
    _popBGAlpha = (popBGAlpha <= 0.0f) ? 0.0f : ((popBGAlpha > 1.0) ? 1.0 : popBGAlpha);
    _isTransparent = (_popBGAlpha == 0.0f);
}

#pragma mark 点击背景(Click background)
-(void)dissClick{
    if (_isClickBGDismiss) {
        [self dismiss];
    }
}
- (void)tapBGLayer:(UITapGestureRecognizer *)tap
{
    if (_isClickBGDismiss) {
        [self dismiss];
    }
}
-(void)tapCustomClick{
    if ( self.tapComplete) {
        [self dismiss];
        self.tapComplete();
    }
}
#pragma mark UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    NSLog(@"%@",touch.view);
    if ([touch view] == self.customView) {
        return YES;
    }else{
        CGPoint location = [touch locationInView:_contentView];
        location = [_customView.layer convertPoint:location fromLayer:_contentView.layer];
        return ![_customView.layer containsPoint:location];
    }
}

- (void)pop
{
    [self.lastWindow addSubview:self];
    
    __weak typeof(self) ws = self;
    NSTimeInterval defaultDuration = [self getPopDefaultDuration:self.animationPopStyle];
    NSTimeInterval duration = (_popAnimationDuration < 0.0f) ? defaultDuration : _popAnimationDuration;
    if (self.animationPopStyle == GSAnimationPopStyleNO) {
        self.alpha = 0.0;
        if (self.isTransparent) {
            self.backgroundView.backgroundColor = [UIColor clearColor];
        } else {
            self.backgroundView.alpha = 0.0;
        }
        [UIView animateWithDuration:duration animations:^{
            ws.alpha = 1.0;
            if (!ws.isTransparent) {
                ws.backgroundView.alpha = ws.popBGAlpha;
            }
        }];
    } else {
        if (ws.isTransparent) {
            self.backgroundView.backgroundColor = [UIColor clearColor];
        } else {
            self.backgroundView.alpha = 0.0;
            [UIView animateWithDuration:duration * 0.5 animations:^{
                ws.backgroundView.alpha = ws.popBGAlpha;
            }];
        }
        [self hanlePopAnimationWithDuration:duration];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ws.popComplete) {
            ws.popComplete();
        }
    });
}

- (void)dismiss
{
    __weak typeof(self) ws = self;
    NSTimeInterval defaultDuration = [self getDismissDefaultDuration:self.animationDismissStyle];
    NSTimeInterval duration = (_dismissAnimationDuration < 0.0f) ? defaultDuration : _dismissAnimationDuration;
    if (self.animationDismissStyle == GSAnimationPopStyleNO) {
        [UIView animateWithDuration:duration animations:^{
            ws.alpha = 0.0;
            ws.backgroundView.alpha = 0.0;
        }];
    } else {
        if (!ws.isTransparent) {
            [UIView animateWithDuration:duration * 0.5 animations:^{
                ws.backgroundView.alpha = 0.0;
            }];
        }
        [self hanleDismissAnimationWithDuration:duration];
    }
    
    if (ws.isObserverOrientationChange) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ws.dismissComplete) {
            ws.dismissComplete();
        }
        [ws removeFromSuperview];
    });
}

- (void)hanlePopAnimationWithDuration:(NSTimeInterval)duration
{
    __weak typeof(self) ws = self;
    switch (self.animationPopStyle) {
        case GSAnimationPopStyleScale:
        {
            [self animationWithLayer:self.contentView.layer duration:duration values:@[@0.0, @1.2, @1.0]]; // 另外一组动画值(the other animation values) @[@0.0, @1.2, @0.9, @1.0]
        }
            break;
        case GSAnimationPopStyleShakeFromTop:
        case GSAnimationPopStyleShakeFromBottom:
        case GSAnimationPopStyleShakeFromLeft:
        case GSAnimationPopStyleShakeFromRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            if (self.animationPopStyle == GSAnimationPopStyleShakeFromTop) {
                self.contentView.layer.position = CGPointMake(startPosition.x, -startPosition.y);
            } else if (self.animationPopStyle == GSAnimationPopStyleShakeFromBottom) {
                self.contentView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + startPosition.y);
            } else if (self.animationPopStyle == GSAnimationPopStyleShakeFromLeft) {
                self.contentView.layer.position = CGPointMake(-startPosition.x, startPosition.y);
            } else {
                self.contentView.layer.position = CGPointMake(CGRectGetMaxX(self.frame) + startPosition.x, startPosition.y);
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                ws.contentView.layer.position = startPosition;
            } completion:nil];
        }
            break;
        case GSAnimationPopStyleCardDropFromLeft:
        case GSAnimationPopStyleCardDropFromRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            if (self.animationPopStyle == GSAnimationPopStyleCardDropFromLeft) {
                self.contentView.layer.position = CGPointMake(startPosition.x * 1.0, -startPosition.y);
                self.contentView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(15.0));
            } else {
                self.contentView.layer.position = CGPointMake(startPosition.x * 1.0, -startPosition.y);
                self.contentView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-15.0));
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                ws.contentView.layer.position = startPosition;
            } completion:nil];
            
            [UIView animateWithDuration:duration*0.6 animations:^{
                ws.contentView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS((ws.animationPopStyle == GSAnimationPopStyleCardDropFromRight) ? 5.5 : -5.5), 0, 0, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.2 animations:^{
                    ws.contentView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS((ws.animationPopStyle == GSAnimationPopStyleCardDropFromRight) ? -1.0 : 1.0));
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:duration*0.2 animations:^{
                        ws.contentView.transform = CGAffineTransformMakeRotation(0.0);
                    } completion:nil];
                }];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)hanleDismissAnimationWithDuration:(NSTimeInterval)duration
{
    __weak typeof(self) ws = self;
    switch (self.animationDismissStyle) {
        case GSAnimationDismissStyleScale:
        {
            [self animationWithLayer:self.contentView.layer duration:duration values:@[@1.0, @0.66, @0.33, @0.01]];
        }
            break;
        case GSAnimationDismissStyleDropToTop:
        case GSAnimationDismissStyleDropToBottom:
        case GSAnimationDismissStyleDropToLeft:
        case GSAnimationDismissStyleDropToRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            CGPoint endPosition = self.contentView.layer.position;
            if (self.animationDismissStyle == GSAnimationDismissStyleDropToTop) {
                endPosition = CGPointMake(startPosition.x, -startPosition.y);
            } else if (self.animationDismissStyle == GSAnimationDismissStyleDropToBottom) {
                endPosition = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + startPosition.y);
            } else if (self.animationDismissStyle == GSAnimationDismissStyleDropToLeft) {
                endPosition = CGPointMake(-startPosition.x, startPosition.y);
            } else {
                endPosition = CGPointMake(CGRectGetMaxX(self.frame) + startPosition.x, startPosition.y);
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                ws.contentView.layer.position = endPosition;
            } completion:nil];
        }
            break;
        case GSAnimationDismissStyleCardDropToLeft:
        case GSAnimationDismissStyleCardDropToRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            BOOL isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
            __block CGFloat rotateEndY = 0.0f;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                if (self.animationDismissStyle == GSAnimationDismissStyleCardDropToLeft) {
                    ws.contentView.transform = CGAffineTransformMakeRotation(M_1_PI * 0.75);
                    if (isLandscape) rotateEndY = fabs(ws.contentView.frame.origin.y);
                    ws.contentView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(ws.frame) + startPosition.y + rotateEndY);
                } else {
                    ws.contentView.transform = CGAffineTransformMakeRotation(-M_1_PI * 0.75);
                    if (isLandscape) rotateEndY = fabs(ws.contentView.frame.origin.y);
                    ws.contentView.layer.position = CGPointMake(startPosition.x * 1.25, CGRectGetMaxY(ws.frame) + startPosition.y + rotateEndY);
                }
            } completion:nil];
        }
            break;
        case GSAnimationDismissStyleCardDropToTop:
        {
            CGPoint startPosition = self.contentView.layer.position;
            CGPoint endPosition = CGPointMake(startPosition.x, -startPosition.y);
            [UIView animateWithDuration:duration*0.2 animations:^{
                ws.contentView.layer.position = CGPointMake(startPosition.x, startPosition.y + 50.0f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.8 animations:^{
                    ws.contentView.layer.position = endPosition;
                } completion:nil];
            }];
        }
            break;
        default:
            break;
    }
}

- (NSTimeInterval)getPopDefaultDuration:(GSAnimationPopStyle)animationPopStyle
{
    NSTimeInterval defaultDuration = 0.0f;
    if (animationPopStyle == GSAnimationPopStyleNO) {
        defaultDuration = 0.2f;
    } else if (animationPopStyle == GSAnimationPopStyleScale) {
        defaultDuration = 0.3f;
    } else if (animationPopStyle == GSAnimationPopStyleShakeFromTop ||
               animationPopStyle == GSAnimationPopStyleShakeFromBottom ||
               animationPopStyle == GSAnimationPopStyleShakeFromLeft ||
               animationPopStyle == GSAnimationPopStyleShakeFromRight ||
               animationPopStyle == GSAnimationPopStyleCardDropFromLeft ||
               animationPopStyle == GSAnimationPopStyleCardDropFromRight) {
        defaultDuration = 0.8f;
    }
    return defaultDuration;
}

- (NSTimeInterval)getDismissDefaultDuration:(GSAnimationDismissStyle)animationDismissStyle
{
    NSTimeInterval defaultDuration = 0.0f;
    if (animationDismissStyle == GSAnimationDismissStyleNO) {
        defaultDuration = 0.2f;
    } else if (animationDismissStyle == GSAnimationDismissStyleScale) {
        defaultDuration = 0.2f;
    } else if (animationDismissStyle == GSAnimationDismissStyleDropToTop ||
               animationDismissStyle == GSAnimationDismissStyleDropToBottom ||
               animationDismissStyle == GSAnimationDismissStyleDropToLeft ||
               animationDismissStyle == GSAnimationDismissStyleDropToRight ||
               animationDismissStyle == GSAnimationDismissStyleCardDropToLeft ||
               animationDismissStyle == GSAnimationDismissStyleCardDropToRight ||
               animationDismissStyle == GSAnimationDismissStyleCardDropToTop) {
        defaultDuration = 0.8f;
    }
    return defaultDuration;
}

- (void)animationWithLayer:(CALayer *)layer duration:(CGFloat)duration values:(NSArray *)values
{
    CAKeyframeAnimation *KFAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    KFAnimation.duration = duration;
    KFAnimation.removedOnCompletion = NO;
    KFAnimation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:values.count];
    for (NSUInteger i = 0; i<values.count; i++) {
        CGFloat scaleValue = [values[i] floatValue];
        [valueArr addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleValue, scaleValue, scaleValue)]];
    }
    KFAnimation.values = valueArr;
    KFAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [layer addAnimation:KFAnimation forKey:nil];
}

#pragma mark 监听横竖屏方向改变
- (void)statusBarOrientationChange:(NSNotification *)notification
{
    CGRect startCustomViewRect = self.customView.frame;
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.backgroundView.frame = self.bounds;
    self.contentView.frame = self.bounds;
    self.customView.frame = startCustomViewRect;
    self.customView.center = self.center;
}
- (UIWindow *)lastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator])
    {
        if ([window isKindOfClass:[UIWindow class]] && CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
        
    }
    return [UIApplication sharedApplication].keyWindow;
    
}



@end
