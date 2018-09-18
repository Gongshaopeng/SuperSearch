//
//  ALBCPush.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "ALBCPush.h"

@class ItemModel;
@implementation ALBCPush


+(void)pushALBCSDK:(pushALBCType )pushType openType:(ALBCOpenType)openType data:(ItemModel *)model complete:(void (^)(UIViewController * vc))complete
{
    BOOL isWeb ;
    NSString *url ;

    DetailVC * view;
    view = [self detailVC];
    id<AlibcTradePage> page;
  
    GSLog(@"%@",model);
    if (model.CouponClickUrl != nil) {
        url = model.CouponClickUrl;
        isWeb = YES;
    }else{
        url = model.ItemUrl;
        isWeb = NO;
    }
    
    switch (pushType) {
        case pushALBCTypeItmeID:
        {
            //打开商品详情页
            page = [AlibcTradePageFactory itemDetailPage: model.NumIid];
            isWeb = NO;
        }
            break;
        case pushALBCTypeUrl:
        {
            //    //根据链接打开页面
       
            page = [AlibcTradePageFactory page:url];
            
        }
            break;
        case pushALBCTypeAddCart:
        {
            //添加商品到购物车
            isWeb = YES;
            page = [AlibcTradePageFactory addCartPage:model.NumIid];
            
        }
            break;
        case pushALBCTypeShopPage:
        {
            //    //打开店铺
            isWeb = YES;
            page = [AlibcTradePageFactory shopPage:model.SellerId];
            //
        }
            break;
        case pushALBCTypeMyOrders:
        {
            //    //打开我的订单页
            isWeb = YES;
            page = [AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
            //
        }
            break;
        case pushALBCTypeMyCarts:
        {
            //    //打开我的购物车
            isWeb = YES;
            page = [AlibcTradePageFactory myCartsPage];
            
        }
            break;
        case pushALBCTypeMyCoupon:
        {
            view.shopTitle = model.Title;
            view.openUrl = url;
            view.num_iid = model.NumIid;
            view.CouponInfo = model.CouponInfo;
            view.ZkFinalPrice = model.ZkFinalPrice;
            view.PictUrl = model.PictUrl;
            view.model  = model;
            [view requestloadWeb:url];
             complete(view);
            return;
        }
            break;
        default:
            break;
    }
    
    
        isWeb = YES;
    if (isWeb == YES) {
        
        [self showCustomize:view webView:view.webView page:page showParams:openType complete:complete tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {

        } tradeProcessFailedCallback:^(NSError * _Nullable error) {

        }];

        
    }else{
        
        [[AlibcTradeSDK sharedInstance].tradeService show:[SSpeedy ss_getCurrentVC] page:page showParams:[self showParam:openType] taoKeParams:[self taoKeParams] trackParam:[self trackParams] tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
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

+ (NSDictionary *)trackParams {
    return @{@"track_key": @"track_value"};
}

+(DetailVC *)detailVC{
    DetailVC * view = [[DetailVC alloc]init];
    return view;
}
+(AlibcTradeTaokeParams *)taoKeParams{
    
    AlibcTradeTaokeParams *taoKeParams = [[AlibcTradeTaokeParams alloc] init];
    taoKeParams.adzoneId = __al_MM_Adzone_Id__;
    taoKeParams.pid = __al_MM_Pid__;
    taoKeParams.extParams = @{@"taokeAppkey":__al_MM_AppKey__};
    return taoKeParams;
}

+(AlibcTradeShowParams *)showParam:(ALBCOpenType)showOpenType{
      //淘客信息
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    switch (showOpenType) {
        case ALBCOpenTypeAuto:
            showParam.openType = AlibcOpenTypeAuto;
            
            break;
        case ALBCOpenTypeNative:
            showParam.openType = AlibcOpenTypeNative;
            
            break;
        case ALBCOpenTypeH5:
            showParam.openType = AlibcOpenTypeH5;
            
            break;
        default:
            break;
    }
    showParam.isNeedPush = NO;
    showParam.nativeFailMode = AlibcNativeFailModeNone;
    showParam.linkKey = @"taobao";
    showParam.backUrl = __al_BC_URLSchemes__;
    return showParam;
}


+(void)showCustomize:(UIViewController *)parentController webView:(nullable UIWebView *)webView  page:(id <AlibcTradePage> __nonnull)page
 showParams:(ALBCOpenType)showOpenType
 complete:(void (^)(UIViewController * vc))complete tradeProcessSuccessCallback:(void (^)(AlibcTradeResult * _Nullable))onSuccess tradeProcessFailedCallback:(void (^)(NSError * _Nullable))onFailure{
    

    
    NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:parentController webView:webView page:page showParams:[self showParam:showOpenType] taoKeParams:[self taoKeParams] trackParam:[self trackParams] tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
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
    if (res == 1) {
        
        complete(parentController);
    }
    
}



+(void)show:(UIViewController *)parentController webView:(UIWebView *)webView url:(NSString *)url complete:(void (^)(UIViewController * vc))complete tradeProcessSuccessCallback:(void (^)(AlibcTradeResult * _Nullable))onSuccess tradeProcessFailedCallback:(void (^)(NSError * _Nullable))onFailure{

  NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:parentController webView:webView page:[AlibcTradePageFactory page:url] showParams:[self showParam:ALBCOpenTypeH5] taoKeParams:[self taoKeParams] trackParam:[self trackParams] tradeProcessSuccessCallback:onSuccess tradeProcessFailedCallback:onFailure];
    if (res == 1) {
        
        complete(parentController);
    }
}

@end
