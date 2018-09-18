//
//  KeyboardToolsView.m
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/10/18.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import "KeyboardToolsView.h"

@implementation KeyboardToolsView

-(instancetype)initWithFrame:(CGRect)frame ItmeArr:(NSArray *)itmeArr lableTextColor:(UIColor *)color
{
    if (self = [super initWithFrame:frame]) {
        
        [self p_Init];
        [self p_UI];
        [self p_layoutFrame];
        [self createKeyboardToolsButton:itmeArr LableColor:color];
        
    }
    return self;
    
}
-(void)p_Init{
    
    
}
-(void)p_UI{
    
    [self addSubview:self.keyboardTools];
    
}

-(void)p_layoutFrame{
    
    _keyboardTools.frame = self.bounds;
}

-(void)show:(CGRect)frame {
    UIView *window = [[[UIApplication sharedApplication] delegate] window];
    //    [window addSubview:self];
    [window addSubview:self.keyboardTools];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3 animations:^{
        _keyboardTools.alpha = 1;
        _keyboardTools.frame = frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }];
    [UIView commitAnimations];
}

- (void)dismiss:(CGRect)frame
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.2 animations:^{
        _keyboardTools.frame = frame;
        self.alpha = 0;
        _keyboardTools.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_keyboardTools removeFromSuperview];
            //            [self removeFromSuperview];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }];
    [UIView commitAnimations];
}
-(void)createKeyboardToolsButton:(NSArray *)itmeArr LableColor:(UIColor *)color{
    
    for (NSInteger i = 0; i < itmeArr.count; i++) {
        UIControl * con = (UIControl*)[self viewWithTag:201+i];
        UILabel * lab = (UILabel*)[self viewWithTag:301+i];
        UIImageView * imag = (UIImageView*)[self viewWithTag:701+i];
        if (con) {
            [con removeFromSuperview];
            [lab removeFromSuperview];
            [imag removeFromSuperview];
        }
        
        
    }
    
    for (NSInteger i = 0; i < itmeArr.count; i++) {
        
        UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(__kScreenWidth__/itmeArr.count*i, 0, __kScreenWidth__/itmeArr.count, __kNewSize(88))];
        //        control.backgroundColor = [UIColor greenColor];
        control.tag = 201+i;
        [control addTarget:self action:@selector(keyboardClick:) forControlEvents:UIControlEventTouchUpInside];
        [_keyboardTools addSubview:control];
        
        UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, control.bounds.size.width, __kNewSize(88))];
        titleLable.textColor = color;
        titleLable.text = itmeArr[i];
        titleLable.adjustsFontSizeToFitWidth = YES;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        //        [self sizeToFit];
        titleLable.tag = 301+i;
        [control addSubview:titleLable];
        if (i == itmeArr.count-1) {
            if (![self.imageName isEqualToString:@""]) {
                UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake((control.bounds.size.width-__kNewSize(34))/2, (control.bounds.size.height-__kNewSize(20))/2, __kNewSize(34), __kNewSize(20))];
                img.image = [UIImage imageNamed:_imageName];
                titleLable.tag = 701+i;
                [control addSubview:img];
            }
        }
        
        
    }
}
-(void)keyboardClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(myKeyboardToolsViewBtnClicked:)])
    {
        [self.delegate myKeyboardToolsViewBtnClicked:btn.tag - 201];
    }
    
}


-(UIView *)keyboardTools{
    if (!_keyboardTools) {
        _keyboardTools = [[UIView alloc]init];
        _keyboardTools.backgroundColor = [UIColor whiteColor];
        [_keyboardTools addSubview:self.xianBottom];
    }
    return _keyboardTools;
}
-(UIView *)xianBottom{
    if (!_xianBottom) {
        _xianBottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0,__kScreenWidth__, __kNewSize(1))];
        _xianBottom.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _xianBottom;
}
-(void)setToolBackgroundColor:(UIColor *)backgroundColor{
    
    _keyboardTools.backgroundColor = backgroundColor;
    
}
@end

