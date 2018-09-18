//
//  ALBCPush.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "MyAlertView.h"
#import <AlibabaAuthSDK/albbsdk.h>
#import "ResponseModel.h"
#import "DetailVC.h"

/**
 *  打开页面的类型
 */
typedef NS_ENUM(NSUInteger, ALBCOpenType) {
    /** 智能判断 */
    ALBCOpenTypeAuto,
    /** 强制跳手淘 */
    ALBCOpenTypeNative,
    /** 强制h5展示 */
    ALBCOpenTypeH5
};
typedef NS_ENUM (NSUInteger, pushALBCType) {
    /** ID跳转到指定页 */
    pushALBCTypeItmeID,
    /** Url跳转到指定页 */
    pushALBCTypeUrl,
    /** 添加到购物车 */
    pushALBCTypeAddCart,
    /** 跳转到商铺 */
    pushALBCTypeShopPage,
    /** 跳转到我的订单 */
    pushALBCTypeMyOrders,
    /** 跳转到我的购物车 */
    pushALBCTypeMyCarts,
    /** 跳转到优惠券页面 */
    pushALBCTypeMyCoupon,
};


@interface ALBCPush : NSObject

+(void)pushALBCSDK:(pushALBCType )pushType openType:(ALBCOpenType)openType data:(ItemModel *_Nullable)model complete:(void (^_Nullable)(UIViewController * _Nonnull vc))complete;


+(void)show:(UIViewController *__nonnull)parentController webView:(nullable UIWebView *)webView url:(NSString *_Nullable)url complete:(void (^_Nullable)(UIViewController * _Nullable vc))complete tradeProcessSuccessCallback:(nullable void (^)(AlibcTradeResult *__nullable result))onSuccess tradeProcessFailedCallback:(nullable void (^)(NSError *__nullable error))onFailure;


+(void)showCustomize:(DetailVC *_Nullable)parentController webView:(nullable UIWebView *)webView page:(id <AlibcTradePage> __nonnull)page
          showParams:(ALBCOpenType)showOpenType
            complete:(void (^_Nullable)(UIViewController * _Nullable vc))complete tradeProcessSuccessCallback:(void (^_Nullable)(AlibcTradeResult * _Nullable))onSuccess tradeProcessFailedCallback:(void (^_Nonnull)(NSError * _Nullable))onFailure;

@end
