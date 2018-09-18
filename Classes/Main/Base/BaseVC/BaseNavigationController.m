//
//  BaseNavigationController.m
//  Product Temp( 工程模版)
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //是否关闭系统导航条的现实
    self.navigationController.navigationBarHidden = YES;
    [self setNavigationBarHidden:YES animated:YES];
    __weak BaseNavigationController *weakSelf = self;

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
        viewController.hidesBottomBarWhenPushed = YES;

    }
    [super pushViewController:viewController animated:animated];
    
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
    
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
//    if ([STCModel stcModel].isPopGesture == 1) {
//
//        navigationController.interactivePopGestureRecognizer.enabled = NO;
//        navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }else{
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
//    }
   
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            return NO;
        }
    }
    
    return YES;
}



//-(void)createSystemNaPage
//{
//    // 获取系统自带滑动手势的target对象
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
//    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    // 设置手势代理，拦截手势触发
//    pan.delegate = self;
//    // 给导航控制器的view添加全屏滑动手势
//    [self.view addGestureRecognizer:pan];
//    // 禁止使用系统自带的滑动手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//
//}
//
//-(void)handleNavigationTransition:(UIPanGestureRecognizer *)pan
//{
//
//}
//
//#pragma mark -UIGestureRecognizerDelegate代理
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
//    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
//    if (self.childViewControllers.count == 1) {
//        // 表示用户在根控制器界面，就不需要触发滑动手势，
//        return NO;
//    }
//    return YES;
//}



@end
