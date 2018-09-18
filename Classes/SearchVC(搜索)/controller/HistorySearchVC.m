//
//  HistorySearchVC.m
//  LLSearchViewController
//
//  Created by 李龙 on 2017/8/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HistorySearchVC.h"
#import "HistorySearchHistroyViewP.h"
#import "LLSearchVCConst.h"
#import "GoodsSetVC.h"

@interface HistorySearchVC ()

@end


@implementation HistorySearchVC


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    // 添加通知观察者
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clipbosrdSearchPop:) name:CLIPBOARDREQUESTPOPSearch object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clipbosrdGoodsPop:) name:CLIPBOARDREQUESTPOPGoods object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLIPBOARDREQUESTPOPSearch object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLIPBOARDREQUESTPOPGoods object:nil];
    
}
- (void)viewDidLoad {
    
    //告诉父类你的prestenter是什么
    self.shopHistoryP = [HistorySearchHistroyViewP new];
    //告诉只显示历史搜索界面
    self.isOnlyShowHistoryView = YES;
    
    [super viewDidLoad];
}


- (void)setSearchMethod
{
    //FIXME:也可以在这里实现搜索页面相关方法!!!
//    @LLWeakObj(self);
//    [self searchbarDidChange:^(NaviBarSearchType searchType, LLSearchBar *searchBar, NSString *searchText) {
//        @LLStrongObj(self);
//        //FIXME:这里是用的模拟数据!!!
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.resultListArray = @[@"春天", @"秋田", @"夏天-C", @"冬天"];
//        });
//    }];
}




//- (void)clipbosrdSearchPop:(NSNotification *)notification
//{
//    GSLog(@"通知中心");
//    NSDictionary * dict = notification.userInfo;
//    TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
//    GoodsSetVC * gSetVc = [[GoodsSetVC alloc]init];
//    gSetVc.searchStr = iModel.Title;
//    gSetVc.isCouponOrUatm = YES;
//    [[SSpeedy ss_getCurrentVC].navigationController pushViewController:gSetVc animated:YES];
//}
//- (void)clipbosrdGoodsPop:(NSNotification *)notification
//{
//    NSDictionary * dict = notification.userInfo;
//    ItemModel * iModel = [[ItemModel alloc]initWithDictionary:dict error:nil];
//    [ALBCPush pushALBCSDK:pushALBCTypeMyCoupon openType:ALBCOpenTypeNative data:iModel complete:^(UIViewController *vc) {
//        DetailVC * dvc = (DetailVC *)vc;
////        dvc.delegate = self;
//        [[SSpeedy ss_getCurrentVC].navigationController pushViewController:dvc animated:YES];
//    }];
//    GSLog(@"通知中心");
//}


-(void)dealloc
{
    NSLog(@"HistorySearchVC 页面销毁");
}

@end
