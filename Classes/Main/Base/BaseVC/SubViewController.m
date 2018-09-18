//
//  SubViewController.m
//  TESTDome
//
//  Created by 巩继鹏 on 16/6/10.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.myView.frame = CGRectMake(0, __kNavigationBarHeight__, __kScreenWidth__, __kOriginalHeight__);
    self.baseNavigationBar.titleLabel.textColor =[UIColor colorWithHexString:@"#333333"];
    self.baseNavigationBar.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self createLeftBarButtonWithImageName:@"history_1" WithSelector:@selector(backAction:)];
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 30, 44);
//    UIImage *image;
//    if (_isNaivBackColor == NO) {
//        image = [UIImage imageNamed:@"history_1"];
//#ifdef IOS_VERSION_10
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//#endif
////        [backBtn setImage:[UIImage imageNamed:@"history_1"] forState:UIControlStateNormal];
////        [backBtn setImage:[UIImage imageNamed:@"arrow_white"] forState:UIControlStateNormal];
//      
//    }else{
////        [backBtn setImage:[UIImage imageNamed:@"arrow_white"] forState:UIControlStateNormal];
//        image = [UIImage imageNamed:@"arrow_white"];
//#ifdef IOS_VERSION_10
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//
//
//#endif
//
//    }
//    UIImageView *iconView = [[UIImageView alloc]initWithImage:image];
//    iconView.frame = CGRectMake(__kNewSize(10), __kNewSize((88-40)/2), __kNewSize(22), __kNewSize(40));
//    [backBtn addSubview:iconView];
//
//    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.baseNavigationBar.leftBarButtons = @[backBtn];
//    [self myViewFrameIsNavi:_isNaivBackColor];
}
-(void)myViewFrameIsNavi:(BOOL)isNavi
{
    if (isNavi == YES) {
        self.myView.frame = CGRectMake(0, __kNavigationBarHeight__, __kScreenWidth__, __kOriginalHeight__);
        self.baseNavigationBar.alpha = 1;

    }else{
        self.myView.frame = CGRectMake(0, 0, __kScreenWidth__, __kOriginalHeight__);
        self.baseNavigationBar.alpha = 0;

    }
}

- (void)backAction:(UIButton *)sender{
    
    if (self.navigationController != nil) {
        switch (self.popVCType) {
            case RootControllerType:
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }
                break;
            case popControllerType:
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            default:
                break;
        }
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
  
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
