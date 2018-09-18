//
//  MyGoodsCartsVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/27.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "MyGoodsCartsVC.h"
#import "LoginVC.h"

#import "ALBCPush.h"

#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "MyAlertView.h"
#import <AlibabaAuthSDK/albbsdk.h>


@interface MyGoodsCartsVC ()
{
    
}
@property (nonatomic,strong) PanLoad * pan;//!<滑动返回

@end

@implementation MyGoodsCartsVC


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
   
    if ([[TBUSerModel userModel].login integerValue] == 1) {
        [self albc:@""];
    }else{
        [self loginPushVC];
    }
    
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
        _webView.frame = CGRectMake(0, __kNavigationBarHeight__,__kScreenWidth__ , __kContentHeight__);
        [self.myView addSubview:_webView];
        [self.pan setPanGestureRecognizer:_webView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.baseNavigationBar.titleLabel.text = @"我的购物车";

}

-(void)dealloc
{
    NSLog(@"dealloc  view");
    _webView =  nil;
}
-(void)loginPushVC{
    LoginVC  * log = [[LoginVC alloc]init];
    [self presentViewController:log animated:YES completion:nil];
//    [self.navigationController pushViewController:log animated:YES];
}

-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)requestloadWeb:(NSString *)url
{
    self.openUrl = url;
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

//-(void)requestTpwdCreate:(NSDictionary *)dic{
//    [self.searchImpl r_Search_TpwdCreate:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
//        for (NSDictionary *dict in model.Datas) {
//            Tpwd * tpModle = [[Tpwd alloc] initWithDictionary:dict error:nil];
//            GSLog(@"%@",tpModle.Model );
//            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//
//            pasteboard.string = [NSString stringWithFormat:@"%@ \n%@ \n",_shopTitle,tpModle.Model];
//            [[MyAlertView alertViewWithTitle:@"淘口令" message:tpModle.Model oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
//        }
//    } failed:^(RequestFailedError error) {
//
//    }];
//}

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

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    GSLog(@"webViewshouldStartLoadWithRequest %@",request.URL);
    NSString *url = [request.URL absoluteString];
    NSDictionary * dict = [NSDictionary getURLParameters:url];
    GSLog(@"\n getURLParameters %@ ",dict);
    
    if ([url containsString:@"maliprod.alipay"]) {
        
        return YES;
    }
    //防止天猫商品拉起手淘
    if([url hasPrefix:@"tbopen://"]||[url hasPrefix:@"tmall://"]||[url containsString:@"b.mashort.cn"]||[url containsString:@"mobile.tmall.com"]){
        
        return NO;
    }
    
    if (![url containsString:@"mlapp/cart"]) {
        __kWeakSelf__;
        DetailVC * view = [[DetailVC alloc]init];
        [ALBCPush show:view webView:view.webView url:url complete:^(UIViewController * _Nullable vc) {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
            
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
            
        }];
        return NO;

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
    
    NSString *url = [webView.request.URL absoluteString];
    NSDictionary * dict = [NSDictionary getURLParameters:url];
    GSLog(@"\n getURLParameters %@ ",dict);

}
-(void)albc:(NSString *)url{
    if(![[ALBBSession sharedInstance] isLogin]){
        GSLog(@"未登录");
    }else{
        GSLog(@"已登陆");
   
    [ALBCPush showCustomize:self webView:self.webView page:[AlibcTradePageFactory myCartsPage] showParams:ALBCOpenTypeH5 complete:^(UIViewController * _Nullable vc) {

    } tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        if(result.result == AlibcTradeResultTypePaySuccess){

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
 
}
@end
