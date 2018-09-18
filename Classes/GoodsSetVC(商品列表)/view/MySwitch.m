//
//  MySwitch.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/5/15.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "MySwitch.h"

@implementation MySwitch
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //默认选中On状态
        _OnStatus=YES;
        _Width=frame.size.width;
        _Height=frame.size.height;
        _CircleR=(_Height-2*_Gap)/2;
        self.backgroundColor=[UIColor whiteColor];
        //设置背景
        UIImageViewBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _Width, _Height)];
        UIImageViewBack.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:UIImageViewBack];
        //设置 滑块图片
        UIImageViewBlock=[[UIImageView alloc]initWithFrame:CGRectMake(_Width-_Height+_Gap, _Gap, 2*_CircleR, 2*_CircleR)];
        UIImageViewBlock.backgroundColor=[UIColor whiteColor];
        [self addSubview:UIImageViewBlock];
        
        self.userInteractionEnabled=YES;
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]; tap.numberOfTapsRequired =1;
        tap.numberOfTouchesRequired =1;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame withGap:(CGFloat)gap{
    self = [super initWithFrame:frame];
    if(self){
        //默认选中On状态
        _OnStatus=YES;
        _Gap=gap;
        _Width=frame.size.width;
        _Height=frame.size.height;
        _CircleR=(_Height-2*_Gap)/2;
        self.backgroundColor=[UIColor whiteColor];
        //设置背景
        UIImageViewBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _Width, _Height)];
        UIImageViewBack.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:UIImageViewBack];
        //设置 滑块图片
        UIImageViewBlock=[[UIImageView alloc]initWithFrame:CGRectMake(_Width-_Height+_Gap, _Gap, 2*_CircleR, 2*_CircleR)];
        UIImageViewBlock.backgroundColor=[UIColor whiteColor];
        [self addSubview:UIImageViewBlock];
        
        self.userInteractionEnabled=YES;
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]; tap.numberOfTapsRequired =1;
            tap.numberOfTouchesRequired =1;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame withGap:(CGFloat)gap statusChange:(MyBlock)block{
    self = [super initWithFrame:frame];
    if(self){
        _myBlock=block;
        //默认选中On状态
        _OnStatus=YES;
        _Gap=gap;
        _Width=frame.size.width;
        _Height=frame.size.height;
        _CircleR=(_Height-2*_Gap)/2;
        self.backgroundColor=[UIColor whiteColor];
        
        //设置背景
        UIImageViewBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _Width, _Height)];
        UIImageViewBack.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:UIImageViewBack];
        //设置 滑块图片
        UIImageViewBlock=[[UIImageView alloc]initWithFrame:CGRectMake(_Width-_Height+_Gap, _Gap, 2*_CircleR, 2*_CircleR)];
        UIImageViewBlock.backgroundColor=[UIColor whiteColor];
        [self addSubview:UIImageViewBlock];
        
        self.userInteractionEnabled=YES;
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]; tap.numberOfTapsRequired =1;
        tap.numberOfTouchesRequired =1;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}



-(void)tapAction:(UITapGestureRecognizer *)tap{
    //图片切换
    if(_OnStatus){
        _OnStatus=NO;
        //滑块关闭动画
        CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"position"];
        ani.toValue = [NSValue valueWithCGPoint:CGPointMake(_CircleR+_Gap, _CircleR+_Gap)];
        ani.removedOnCompletion = NO;
        ani.fillMode = kCAFillModeForwards;
        ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [UIImageViewBlock.layer addAnimation:ani forKey:@"PostionToLeft"];
        if(UIImageSliderLeft){
            UIImageViewBlock.image=UIImageSliderLeft;
        }else{
            UIImageViewBlock.backgroundColor=[UIColor grayColor];
        }
    }else{
        _OnStatus=YES;
        //滑块打开动画
        CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"position"];
        ani.toValue = [NSValue valueWithCGPoint:CGPointMake(_Width-_CircleR-_Gap, _CircleR+_Gap)];
        ani.removedOnCompletion = NO;
        ani.fillMode = kCAFillModeForwards;
        ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [UIImageViewBlock.layer addAnimation:ani forKey:@"PostionToRight"];
        
        if(UIImageSliderRight){
            UIImageViewBlock.image=UIImageSliderRight;
        }else{
            UIImageViewBlock.backgroundColor=[UIColor whiteColor];
        }
    }
    if(_myBlock) _myBlock(_OnStatus);
    [_delegate onStatusDelegate];
}
        
        
//设置背景图片
-(void)setBackgroundImage:(UIImage *)image{
    UIImageViewBack.backgroundColor=[UIColor clearColor];
    UIImageBack=image;
    UIImageViewBack.image=image;
}
    //设置左滑块图片
-(void)setLeftBlockImage:(UIImage *)image{
    UIImageViewBlock.backgroundColor=[UIColor clearColor];
    UIImageSliderLeft=image;
    UIImageViewBlock.image=image;
    
}
//设置右滑块图片
-(void)setRightBlockImage:(UIImage *)image{
    UIImageViewBlock.backgroundColor=[UIColor clearColor];
    UIImageSliderRight=image;
    UIImageViewBlock.image=image;
    
}
        
        
       
@end
