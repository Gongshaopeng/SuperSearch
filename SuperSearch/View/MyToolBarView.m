//
//  MyToolBarView.m
//  Esou
//
//  Created by 巩小鹏 on 16/8/26.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import "MyToolBarView.h"
@interface MyToolBarView ()
{
    NSArray *_arrImage;
}

@end

@implementation MyToolBarView




//初始化方法
#pragma mark - InitView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //        [self p_UI];
    }
    return self;
}

-(void)p_UI{
    
    
}

-(void)p_layoutFrame{
    
    
}

-(void)createToolBarImagerArr:(NSArray *)imageTBArr title:(NSArray *)titleTBArr titleColor:(UIColor *)color
{
//    [self addSubview:self.topXianView];
    [self boomLayerToolBar:self];

    static NSInteger _itme = 0;
    if (imageTBArr.count != 0) {
        _itme= imageTBArr.count;
        
    }
    if (titleTBArr.count !=0) {
        _itme= titleTBArr.count;
        
    }
    
    for (NSInteger i = 0; i < _itme; i++) {
        
        UIControl *control = [[UIControl alloc]init];
        UIImageView *imageView = [[UIImageView alloc]init];
        if (_itme > 3) {
            
//            if (imageTBArr.count != 0) {
//                if (i != 2) {
//                    control.frame = CGRectMake(__kScreenWidth__/_itme*i, 0, __kScreenWidth__/_itme, __kNewSize(88));
//                    imageView.frame = CGRectMake((control.frame.size.width-__kNewSize(66))/2, (control.frame.size.height - __kNewSize(66))/2, __kNewSize(66), __kNewSize(66));
//                }else{
//                    
//                    control.frame = CGRectMake((__kScreenWidth__-__kNewSize(118))/2, __kNewSize(88-118), __kNewSize(118), __kNewSize(118));
//                    UIImageView * backimag = [[UIImageView alloc]initWithFrame:control.bounds];
//                    backimag.image =[UIImage imageNamed:@"circle_shadow"];
//                    [control addSubview:backimag];
//                    //                        control.backgroundColor = [UIColor colorWithPatte rnImage:[UIImage imageNamed:@"circle_shadow"]];
//                    imageView.frame = CGRectMake((control.frame.size.width-__kNewSize(66))/2, (control.frame.size.height - __kNewSize(66))/2, __kNewSize(66), __kNewSize(66));
//                    
//                }
//            }else{
                control.frame = CGRectMake(__kScreenWidth__/_itme*i, 0, __kScreenWidth__/_itme, __kNewSize(88));
                imageView.frame = CGRectMake((control.frame.size.width-__kNewSize(66))/2, (control.frame.size.height - __kNewSize(66))/2, __kNewSize(66), __kNewSize(66));
//            }
           
        }else{
            control.frame = CGRectMake(__kScreenWidth__/_itme*i, 0, __kScreenWidth__/_itme, __kNewSize(88));
            imageView.frame = CGRectMake((control.frame.size.width-__kNewSize(66))/2, (control.frame.size.height - __kNewSize(66))/2, __kNewSize(66), __kNewSize(66));
        }
        control.tag = i;
//        [self buttonLayerBorder:control];
        [control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        if (imageTBArr.count != 0) {
            imageView.tag = 33333+i;
            control.backgroundColor = [UIColor clearColor];
            [control addSubview:imageView];
            imageView.image = [UIImage imageNamed:imageTBArr[i]];
      
        }
        
        if (titleTBArr.count != 0) {
            UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.bounds.size.height-42)/2, __kScreenWidth__/_itme, 21*2)];
//            UILabel * titleLable = [[UILabel alloc]initWithFrame:control.frame];
            titleLable.textColor = color;
            titleLable.text = titleTBArr[i];
            titleLable.textAlignment = NSTextAlignmentCenter;
            [control addSubview:titleLable];
        }
    }
}

-(void)buttonLayerBorder:(UIControl *)btn{
    [btn.layer setMasksToBounds:YES];
    
//    [btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    
    [btn.layer setBorderWidth:1.0];   //边框宽度

    [btn.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor blackColor])];//边框颜色
}

-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(myToolBarViewBtnClicked:)])
    {
        [self.delegate myToolBarViewBtnClicked:btn.tag];
    }
}

- (void)setToolBarHidden:(BOOL)isHidden{
    
    CGSize size = self.frame.size;
    if (isHidden) {
        self.frame = CGRectMake(0, -size.height, size.width, size.height);
    }else{
        self.frame = __kTabBarFrame__;
    }
}

-(UIView *)topXianView{
    if (!_topXianView) {
        _topXianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kNewSize(1))];
        _topXianView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _topXianView;
}

-(void)maqueAnimate
{
    UIControl *control = [self viewWithTag:103];
    UIImageView *imageView = [control viewWithTag:33335];

    [UIView animateWithDuration:0.3 animations:^{
         imageView.frame = CGRectMake((control.frame.size.width-__kNewSize(66))/2, (control.frame.size.height - __kNewSize(0))/2, __kNewSize(66), __kNewSize(66));
    } completion:^(BOOL finished) {
         imageView.frame = CGRectMake((control.frame.size.width-__kNewSize(66))/2, (control.frame.size.height - __kNewSize(66))/2, __kNewSize(66), __kNewSize(66));
    }];
}

-(void)boomLayerToolBar:(UIView *)tfd{
    
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0,__kNewSize(0),__kScreenWidth__, __kNewSize(1));
    leftBorder.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
    [tfd.layer addSublayer:leftBorder];
    
}

@end
