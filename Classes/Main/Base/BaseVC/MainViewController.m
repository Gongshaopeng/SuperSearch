//
//  MainViewController.m
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/10/19.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import "MainViewController.h"

#import "BaseTabBarController.h"

@implementation MainViewController
#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self setUpAcceptNote];
}


#pragma mark - 接受跟换控制
- (void)setUpAcceptNote
{
    __kWeakSelf__;
    [[NSNotificationCenter defaultCenter]addObserverForName:LOGINSELECTCENTERINDEX object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.tabBarController.selectedIndex = SSTabBarControllerUser; //跳转到我的界面
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.baseNavigationBar.titleLabel.textColor =[UIColor blackColor];
    self.baseNavigationBar.backgroundColor = [UIColor whiteColor];
    self.myView.frame = CGRectMake(0, 0, __kScreenWidth__, __kBarHeight__);
    
}
-(void)setIsNavi:(BOOL)isNavi{
    
    if (isNavi == NO) {
        //        self.myView.frame = CGRectMake(0, __kNavigationBarHeight__, __kScreenWidth__, __kOriginalHeight__);
        self.baseNavigationBar.frame = CGRectMake(0, 0, __kScreenWidth__, __kNavigationBarHeight__);
        self.baseNavigationBar.alpha = 1;

        
    }else{
        //        self.myView.frame = CGRectMake(0, 0, __kScreenWidth__, __kOriginalHeight__);
        self.baseNavigationBar.frame = CGRectMake(0, 0, 0, 0);
        self.baseNavigationBar.alpha = 0;
        
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
