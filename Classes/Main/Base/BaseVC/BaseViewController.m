//
//  BaseViewController.m
//  TESTDome
//
//  Created by 巩继鹏 on 16/6/7.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myView];
    GSLog(@"%@",NSStringFromClass([self class]));
   
    if ([NSStringFromClass([self class]) isEqualToString:@"SearchVC"]) {
        
    }else if ([NSStringFromClass([self class]) isEqualToString:@"HomeVC"]){
        
    }else{
        [self.view addSubview:self.baseNavigationBar];
    }

    //消除导航栏的影响,显示的视图不被导航栏覆盖
    self.view.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO,
    [self layoutSubviews];

}


- (void)layoutSubviews {
    //You should set subviews constrainsts or frame here
    _myView.frame = CGRectMake(0, 0, __kScreenWidth__,__kScreenHeight__);
    _baseNavigationBar.frame = CGRectMake(0, 0, __kScreenWidth__, __kNavigationBarHeight__);
}
- (UIView *)myView
{
    if (!_myView) {
        _myView = [[UIView alloc]init];
        _myView.backgroundColor = [UIColor whiteColor];
    }
    return _myView;
}


- (BaseNavigationBar *)baseNavigationBar{
    if (!_baseNavigationBar) {
        _baseNavigationBar = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kNavigationBarHeight__-__kNewSize(1))];
//        GSLog(@"_baseNavigationBar Height %f",__kNavigationBarHeight__);
        _baseNavigationBar.backgroundColor = [UIColor whiteColor];
         [_baseNavigationBar addSubview:self.xian];
           }
    return _baseNavigationBar;
}
-(UIView *)xian{
    if (!_xian) {
        _xian = [[UIView alloc]initWithFrame:CGRectMake(0, __kNavigationBarHeight__, __kScreenWidth__, __kNewSize(1))];
        _xian.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
//        _xian.jsonTheme.backgroundColor(@"ident6");
    }
    return _xian;
}
-(void)hideNavigationBar:(BOOL)isHide{
    if (isHide == YES) {
        _baseNavigationBar.frame = CGRectMake(0, 0, __kScreenWidth__, 0);
        _xian.frame = CGRectMake(0, 0, __kScreenWidth__, 0);

    }else{
        _baseNavigationBar.frame = CGRectMake(0, 0, __kScreenWidth__, __kNavigationBarHeight__);
        _xian.frame = CGRectMake(0,  _baseNavigationBar.frame.size.height-__kNewSize(1), __kScreenWidth__, __kNewSize(1));

    }
}



- (void)createRightBarButtonWithImageName:(NSString *)imageName WithSelector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:imageName forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.frame = CGRectMake(__kScreenWidth__-20, 0, 30, 30);
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.baseNavigationBar.rightBarButtons = @[btn];
    

}

- (void)createLeftBarButtonWithImageName:(NSString *)imageName WithSelector:(SEL)selector
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 44);
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    self.baseNavigationBar.leftBarButtons = @[backBtn];
    
}
- (void)createLeftBarButtonWithImageName:(NSString *)imageName BtnAdjacent:(NSString *)btnAdName WithSelector:(SEL)selector WithBtnAdSelector:(SEL)adSelector
{
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnAdName forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 50, 44);
        btn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(30)];
        [btn addTarget:self action:adSelector forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor redColor];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 30, 44);
        [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [backBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
//    backBtn.backgroundColor = [UIColor redColor];

        self.baseNavigationBar.leftBarButtons = @[backBtn,btn];
    
}


- (void)createRightBarButtonWithRightBarButton:(NSString *)btnName WithSelector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:btnName forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.frame = CGRectMake(__kScreenWidth__-20, 0, 40, 40);
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.baseNavigationBar.rightBarButtons = @[btn];
    
    
}

- (void)createRightBarButtonWithLeftBarButton:(NSString *)btnName WithSelector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:btnName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.frame = CGRectMake(__kScreenWidth__-20, 0, 40, 40);
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.baseNavigationBar.leftBarButtons = @[btn];
    
    
}

- (void)createLeftBarButton:(NSString *)btnName img:(NSString *)leftImg rightBtn:(NSString *)rName WithSelector:(SEL)selector WithRightSelector:(SEL)selectorR
{
    UIButton * remLBtn = (UIButton *)[self.baseNavigationBar viewWithTag:77988];
    UIButton * remRBtn = (UIButton *)[self.baseNavigationBar viewWithTag:88799];

    if (remLBtn != nil) {
        if (remRBtn == nil) {
            
            if (rName != nil || ![rName isEqualToString:@""]) {
                
                UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                backBtn.frame = CGRectMake(__kNewSize(20+20+100), __kNewSize(40), __kNewSize(100), __kNewSize(88));
                backBtn.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(30)];
                [backBtn setTitle:rName forState:UIControlStateNormal];
                //    btn.titleEdgeInsets = UIEdgeInsetsMake(0,__kNewSize((88-40)/2), 0, 0);
                [backBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
                [backBtn addTarget:self action:selectorR forControlEvents:UIControlEventTouchUpInside];
                backBtn.tag = 88799;
                [self.baseNavigationBar addSubview:backBtn];
                
            }

        }

    }else{
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(__kNewSize(20+20), __kNewSize(40), __kNewSize(100), __kNewSize(88));
        btn.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(30)];
        [btn setTitle:btnName forState:UIControlStateNormal];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0,__kNewSize(16), 0, 0);
        [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        //    btn.jsonTheme.titleColorWithState(@"ident2", UIControlStateNormal);
        
//        UIImage *image = [UIImage imageNamed:leftImg];
//        UIImageView *iconView = [[UIImageView alloc]initWithImage:image];
//        iconView.frame = CGRectMake(0, __kNewSize((88-40)/2), __kNewSize(22), __kNewSize(40));
//        [btn addSubview:iconView];
//        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        //    self.baseNavigationBar.leftBarButtons = @[btn];
        btn.tag = 77988;
        [self.baseNavigationBar addSubview:btn];
        
        
    }
}

- (void)createRightBarButton:(NSString *)btnName WithSelector:(SEL)selector
{
    [self createRightBarButton:btnName textColor:[UIColor colorWithHexString:@"#333333"] WithSelector:selector];
}
- (void)createRightBarButton:(NSString *)btnName textColor:(UIColor *)textColor WithSelector:(SEL)selector
{
    [self createRightBarButton:btnName textColor:textColor font:0 WithSelector:selector];
}
- (void)createRightBarButton:(NSString *)btnName textColor:(UIColor *)textColor font:(CGFloat)font WithSelector:(SEL)selector
{
    [self createRightBarButton:btnName textColor:textColor font:font frame:CGRectMake(__kScreenWidth__-__kNewSize(170), (__kNavigationBarHeight__+22-__kNewSize(45))/2, __kNewSize(130), __kNewSize(45)) WithSelector:selector];
}
- (void)createRightBarButton:(NSString *)btnName textColor:(UIColor *)textColor font:(CGFloat)font frame:(CGRect)frame WithSelector:(SEL)selector
{
    UIButton *tton = (UIButton *)[self.baseNavigationBar viewWithTag:911];
    [tton removeFromSuperview];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    [btn setTitle:btnName forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //    self.baseNavigationBar.rightBarButtons = @[btn];
    //    btn.jsonTheme.titleColorWithState(@"ident2", UIControlStateNormal);
    btn.tag = 911;
    if (font > 0) {
        btn.titleLabel.font = [UIFont systemFontOfSize:font];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.numberOfLines = 2;
    }else{
        btn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(30)];
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
  
    [self.baseNavigationBar addSubview:btn];
}
- (void)createRightBarButton:(NSString *)btnName colorWithHexString:(NSString *)colorStr WithSelector:(SEL)selector
{
    UIButton *tton = (UIButton *)[self.baseNavigationBar viewWithTag:911];
    [tton removeFromSuperview];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(__kScreenWidth__-__kNewSize(130), (__kNavigationBarHeight__+22-__kNewSize(45))/2, __kNewSize(120), __kNewSize(45));
    
    [btn setTitle:btnName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:colorStr] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //    self.baseNavigationBar.rightBarButtons = @[btn];
    //    btn.jsonTheme.titleColorWithState(@"ident2", UIControlStateNormal);
    btn.tag = 912;
    btn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(30)];
    [self.baseNavigationBar addSubview:btn];
    
    
}




@end
