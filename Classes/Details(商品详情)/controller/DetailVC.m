//
//  DetailVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/7.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "DetailVC.h"
#import "ShareImageVC.h"
#import "searchProtocolLmpl.h"
#import "Tpwd.h"

#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "MyAlertView.h"
#import <AlibabaAuthSDK/albbsdk.h>
#import "ShareNewView.h"
#import "TKLView.h"
#import "AdpopupsView.h"
#import "HNPopMenuManager.h"
#import "HNPopMenuModel.h"

@interface DetailVC()<HNPopMenuViewDelegate>
{
    BOOL _isAlbcSDK;//锁定调起sdk
    NSString * pasteStrText;//剪切板文本
}
@property (nonatomic,strong) PanLoad * pan;//!<滑动返回
@property (nonatomic,strong) TKLView * tklView;//!<淘口令
@property (nonatomic,strong) AdpopupsView * adpopupsView;
@property (nonatomic,strong) NSMutableArray * popMenuArr;

@property (nonatomic,strong)id<searchProtocol>searchImpl;

@end

@implementation DetailVC


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_openUrl != nil) {
//        [self createRightBarButton:@". . ." WithSelector:@selector(tklClick:)];
        [self createRightBarButtonWithImageName:@"more_light" WithSelector:@selector(tklClick:)];
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    // 添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clipbosrdSearchPop:) name:CLIPBOARDREQUESTPOPSearch object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clipbosrdGoodsPop:) name:CLIPBOARDREQUESTPOPGoods object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackgroundPop:) name:ENTERBACKGRUOUND object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLIPBOARDREQUESTPOPSearch object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLIPBOARDREQUESTPOPGoods object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ENTERBACKGRUOUND object:nil];


}

-(void)dealloc
{
    NSLog(@"dealloc  view");
    [_pan removeFromSuperview];
    _pan = nil;
    [_tklView removeFromSuperview];
    _tklView = nil;
    ( _webView).scrollView.delegate = nil;
//    [( _webView) loadHTMLString:@"" baseURL:nil];
    [( _webView) stopLoading];
    [( _webView) removeFromSuperview];
    _webView =  nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [EasyLodingView hidenLoding];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.scrollView.scrollEnabled = YES;
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
        _webView.frame = CGRectMake(0, 0,self.view.bounds.size.width , self.view.bounds.size.height-__kNavigationBarHeight__);
        [self.myView addSubview:_webView];
        [self.pan setPanGestureRecognizer:_webView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isAlbcSDK = NO;

    self.baseNavigationBar.titleLabel.text = @"麻雀优惠券";
    self.searchImpl = [[searchProtocolLmpl alloc]init];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
    //                                                         forBarMetrics:UIBarMetricsDefault];
}


-(NSMutableArray *)popMenuArr{
    if(!_popMenuArr){
        NSMutableArray *tempArr = [NSMutableArray array];
        NSArray *titleArr = @[@"消息",@"首页" ,@"客服小蜜",@"我要反馈",@"合成图片",@"分享"];
        NSArray *imgArr = @[@"message_light",@"home_light" ,@"service_light",@"edit_light",@"my_light",@"share"];

        for (int i = 0; i < titleArr.count; i++) {
            HNPopMenuModel *model = [[HNPopMenuModel alloc] init];
            model.title = titleArr[i];
            model.imageName = imgArr[i];
            [tempArr addObject:model];
        }
        _popMenuArr = [tempArr mutableCopy];
    }
    return _popMenuArr;
}
#pragma mark - click响应
- (void)canceTKLlClick{
     [self.adpopupsView dismiss];
}
- (void)shareTKLClick{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = pasteStrText;
    
        [ShareNewView newShare].shareType = ShareViewType;
        [ShareNewView newShare].sharePlatform = ShareTextPlatformType;
        [ShareNewView newShare].titleShare = __ShareTitle__;
        [ShareNewView newShare].urlShare = __ShareUrl__;
        [ShareNewView newShare].bodyShare = pasteStrText;
        [[ShareNewView newShare] show];
        [self.adpopupsView dismiss];
    
}
- (void)tklClick:(UIButton *)btn{

     [HNPopMenuManager showPopMenuWithView:btn items:self.popMenuArr delegate:self dismissAutomatically:YES];
}


-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 公开方法
-(void)requestloadWeb:(NSString *)url
{
    self.openUrl = url;
//    [self albc:url];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}


-(UIWebView *)getWebView{
    return  _webView;
}


-(PanLoad *)pan{
    if (!_pan) {
        _pan = [[PanLoad alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__)];
        _pan.slideDelegate =self;
    }
    return _pan;
}
-(TKLView *)tklView{
    if (!_tklView) {
        _tklView = [[TKLView alloc]init];

        _tklView.backgroundColor = [UIColor whiteColor];
        _tklView.layer.masksToBounds = YES;
        _tklView.layer.cornerRadius = __kNewSize(20);
        [_tklView.cancelButton addTarget:self action:@selector(canceTKLlClick) forControlEvents:UIControlEventTouchUpInside];
        [_tklView.goButton addTarget:self action:@selector(shareTKLClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _tklView;
}
-(AdpopupsView *)adpopupsView{
    if (!_adpopupsView) {
        
        _adpopupsView = [[AdpopupsView alloc] initWithCustomView:self.tklView popStyle:GSAnimationPopStyleScale dismissStyle:GSAnimationDismissStyleScale newStyle:GSAnimationPopStyleNoNew];
        _adpopupsView.popBGAlpha = 0.5f;
        _adpopupsView.isClickBGDismiss = YES;
//        __kWeakSelf__;
//        _adpopupsView.popComplete = ^{
//            NSLog(@"显示完成");
//        };
//        // 2.7 移除完成回调
//        _adpopupsView.dismissComplete = ^{
//            NSLog(@"移除完成");
//
//        };
//        _adpopupsView.tapComplete = ^{
//            NSLog(@"点击图片");
//
//        };
        
    }
    return _adpopupsView;
}
#pragma mark - 通知处理
-(void)didEnterBackgroundPop:(NSNotification *)notification{
//    [[ShareNewView newShare] myBlockcompletion:^{
//
//    }];
}

- (void)clipbosrdSearchPop:(NSNotification *)notification
{
    GSLog(@"通知中心");
//    [self.navigationController popToRootViewControllerAnimated:NO];

    if ([self.delegate respondsToSelector:@selector(myDetailVCpop:)])
    {
        [self.navigationController popViewControllerAnimated:NO];
        [[ShareNewView newShare] dismiss];
        [self.delegate myDetailVCpop:notification.userInfo];
    }
//    TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
    //    GoodsSetVC * gSetVc = [[GoodsSetVC alloc]init];
    //    gSetVc.searchStr = iModel.Title;
    //    gSetVc.isCouponOrUatm = YES;
    //    [[SSpeedy ss_getCurrentVC].navigationController pushViewController:gSetVc animated:YES];
    
}
- (void)clipbosrdGoodsPop:(NSNotification *)notification
{
    NSDictionary * dict = notification.userInfo;
    ItemModel * model = [[ItemModel alloc]initWithDictionary:dict error:nil];
    NSString * url;
    if (model.CouponClickUrl != nil) {
        url = model.CouponClickUrl;
    }else{
        url = model.ItemUrl;
    }
    self.shopTitle = model.Title;
    self.openUrl = url;
    self.num_iid = model.NumIid;
    self.CouponInfo = model.CouponInfo;
    self.ZkFinalPrice = model.ZkFinalPrice;
    self.PictUrl = model.PictUrl;
    [self requestloadWeb:url];
    [[ShareNewView newShare] dismiss];
    GSLog(@"通知中心");
}
#pragma mark - 请求淘口令
-(void)requestTpwdCreate:(NSDictionary *)dic{

    __kWeakSelf__;
    [self.searchImpl r_Search_TpwdCreate:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
        
        for (NSDictionary *dict in model.Datas) {
            Tpwd * tpModle = [[Tpwd alloc] initWithDictionary:dict error:nil];
            GSLog(@"%@",tpModle.Model );
           
            //【麻雀优惠券--您的省钱好帮手】5元优惠券！券后仅需123.00元！
           // 浪莎春秋瑜伽服2018新款速干衣宽松长袖专业健身房跑步运动套装女，复制这条信息￥iekB0qpxcuK￥后打开手淘
//            pasteStrText = [NSString stringWithFormat:@"【麻雀优惠券-您的省钱好帮手】 %@优惠券!券后仅需%@元！\n （%@）\n复制这条信息\n%@\n后打开👉手淘👈 \n",[STool returnCouponInfo:self.CouponInfo],[STool returnCouponInfo:self.CouponInfo price:self.ZkFinalPrice],_shopTitle,tpModle.Model];
            
            pasteStrText = [NSString stringWithFormat:@"【%@】，复制这条信息%@后打开👉手淘👈",_shopTitle,tpModle.Model];
//          pasteStrText = @"【黑色连衣裙春装女2018新款韩版气质长袖收腰显瘦单排扣赫本长裙H】，复制这条信息￥I6VC0unKBFR￥后打开👉手淘👈";
//            pasteStrText = @"￥rd4k0unIlyQ￥";
            [weakSelf.adpopupsView pop];
            CGFloat height = [NSString measureMutilineStringHeight:[NSString removeSpaceAndNewline:pasteStrText] andFont:[UIFont systemFontOfSize:__kNewSize(28)] andWidthSetup:(__kNewSize(600))];
            _tklView.frame = CGRectMake((__kScreenWidth__-__kNewSize(654))/2, (__kScreenHeight__-(height+__kNewSize(64+64+64+92)))/2, __kNewSize(654), height+__kNewSize(64+64+64+92));
//            pasteStrText = tpModle.Model;
            _tklView.bodyStr = [NSString removeSpaceAndNewline:pasteStrText];
            
        }
       

    } failed:^(RequestFailedError error) {

    }];
}

-(void)requestWirelessShareTpwdCreate:(NSDictionary *)dic
{
    [self.searchImpl r_Search_WirelessShareTpwdCreate:[RequestModel modelWithDictionary:dic appType:@"1"] complete:^(ResponseModel *model) {
        GSLog(@"%@",model );

    } failed:^(RequestFailedError error) {
        
    }];
}
#pragma  mark - 添加左划右划手势

-(BOOL)swipeIsClass{
    if (_webView.canGoBack == YES) {
        return YES;
        
    }else{
        return NO;
        
    }
}
-(void)swipePoint:(CGPoint)point pan:(UIPanGestureRecognizer *)pan{
    NSLog(@"point:%f",point.x);
    
}
-(void)swipeLeft{
    GSLog(@"swipeLeft");
    [_webView goBack];
}
-(void)swipeRight{
    GSLog(@"swipeRight");
    [_webView goForward];
}
static NSString * const kWebKitCacheModelPreferenceKey = @"WebKitCacheModelPreferenceKey";
static NSString * const kWebKitDiskImageCacheEnabled = @"WebKitDiskImageCacheEnabled";
static NSString * const kWebKitOfflineWebApplicationCacheEnabled = @"WebKitOfflineWebApplicationCacheEnabled";

- (void)cleanWebCacheValues
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kWebKitCacheModelPreferenceKey];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kWebKitDiskImageCacheEnabled];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kWebKitOfflineWebApplicationCacheEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - PopMenuVDelegate
- (void)QQPopMenuView:(HNPopMenuView *)menuView didSelectRow:(NSInteger)row{
    NSLog(@"第%ld行被点击了",row);

    switch (row) {
        case 4:
            {
            //
                ShareImageVC * shareImgVC = [[ShareImageVC alloc]init];
                shareImgVC.model  = self.model;
                [self.navigationController pushViewController:shareImgVC animated:YES];
            }
            break;
        case 5:
            {
            //
            [self requestTpwdCreate:@{@"user_id":__al_MM_UserID__,@"text":self.shopTitle,@"url":self.openUrl,@"logo":self.PictUrl}];
//                [self requestWirelessShareTpwdCreate:@{@"user_id":__al_MM_UserID__,@"text":self.shopTitle,@"url":self.model.ItemUrl,@"logo":self.PictUrl}];
            }
            break;
        case 2:
            {
            //
                
            }
            break;
        default:
            break;
    }
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    GSLog(@"webViewshouldStartLoadWithRequest %@",request.URL);
    NSString *url = [request.URL absoluteString];
    NSDictionary * dict = [NSDictionary getURLParameters:url];
    GSLog(@"\n getURLParameters %@ ",dict);

   
    //防止天猫商品拉起手淘
    if([url hasPrefix:@"tbopen://"]||[url hasPrefix:@"tmall://"]||[url containsString:@"b.mashort.cn"]||[url containsString:@"mobile.tmall.com"]){
        
        return NO;
    }
        if ([url hasPrefix:@"https://detail.m.tmall.com"]||[url hasPrefix:@"https://s.click.taobao.com"]) {
            if (_isAlbcSDK == NO) {
                [self albc:url];
                _isAlbcSDK = YES;
                return NO;
            }
            return YES;
        }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [EasyLodingView showLodingText:@"正在加载..." config:^EasyLodingConfig *{
        return [EasyLodingConfig shared].setLodingType(LodingShowTypeIndicator).setBgColor([UIColor colorWithHexString:@"#000000"] ).setTintColor([UIColor colorWithHexString:@"#ffffff"]).setBgAlpha(0.7);
    }];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [EasyLodingView hidenLoding];
    [self cleanWebCacheValues];
    if (webView.canGoBack) {
        _pan.isHideLeft = YES;
    }else{
        _pan.isHideLeft = NO;
    }
    if (webView.canGoForward) {
        _pan.isHideRight = YES;
    }else{
        _pan.isHideRight = NO;
    }
    
    
    
    GSLog(@"webUrl %@",webView.request.URL);
    
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('_2IjaJJcGLxfhZizlEvNf6I')[0].style.display = 'none'"];
    
    NSString *url = [webView.request.URL absoluteString];
//    NSDictionary * dict = [NSDictionary getURLParameters:url];
//    GSLog(@"\n getURLParameters %@ ",dict);
//    if ([url containsString:@"cart/order"] || [url containsString:@"order/confirmOrderWap"]) {
//         [self albc:url];
//    }
//    if ([url hasPrefix:@"https://detail.m.tmall.com"]||[url hasPrefix:@"https://s.click.taobao.com"]) {
        NSString * bizOrderId = [STool getDocIdFromWhichToObtainUrl:url objectForKey:@"bizOrderId"];
        if (![bizOrderId isEqualToString:@""]) {
            [EasyTextView showSuccessText:bizOrderId];

//            self.num_iid = itmeId;
//            if (![[STCModel stcModel].lastItmeID isEqualToString:self.num_iid]) {
//                if (![self.num_iid isEqualToString:@""]) {
//                    [STCModel stcModel].lastItmeID = self.num_iid;
//                    [self albc:url];
//                }
//            }
        }
//    }
    
//    if (![url containsString:@"https://uland.taobao.com/coupon/edetail"]) {
//
//
//    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [EasyTextView showErrorText:@"网络错误！试试再刷新一下吧！"];

}

-(void)albc:(NSString *)url{
    [STCModel stcModel].openUrlType = 1;
    [ALBCPush show:self webView:self.webView url:url complete:^(UIViewController * _Nullable vc) {
        
    } tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        if(result.result == AlibcTradeResultTypePaySuccess){
            GSLog(@"%@",[result payResult].paySuccessOrders);
            NSString *tip=[NSString stringWithFormat:@"交易成功:成功的订单%@\n，失败的订单%@\n",[result payResult].paySuccessOrders,[result payResult].payFailedOrders];
            [[MyAlertView alertViewWithTitle:@"交易成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }else if(result.result == AlibcTradeResultTypeAddCard){
            
            [[MyAlertView alertViewWithTitle:@"加入购物车" message:@"加入成功" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        if (error.code==AlibcErrorCancelled) {
            return ;
        }
        NSDictionary *infor=[error userInfo];
        NSArray*  orderid=[infor objectForKey:@"orderIdList"];
        NSString *tip=[NSString stringWithFormat:@"交易失败:\n订单号\n%@",orderid];
        [[MyAlertView alertViewWithTitle:@"交易失败" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }];
}

@end
