//
//  Header.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/13.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestModel;
@class ResponseModel;
@class resultsModel;
@class TBKItemModel;
@class TBKCouponModel;



typedef NS_ENUM(NSInteger,RequestFailedError) {
    RequestFailedDefaultType,//!<默认
    RequestFailedNoDataType,//!<无数据
    RequestFailedNoNetworkType,//!<无网络
};




@protocol searchProtocol <NSObject>

@optional

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 好券清单API【导购】
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_DgItemCouponGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;


//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 获取淘宝联盟选品库列表
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_UatmFavoritesGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;


//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 获取淘宝联盟选品库的宝贝信息
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_UatmFavoritesItemGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;


//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘宝客淘口令
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_TpwdCreate:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 搜索商品
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_ItmeGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 热门词或者滚动广告 传参 cate: 1 Banner 2 热词
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_EditConfig:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;
//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 首页数据 传递参数为cate 1:顶部导航，2:精选专题，3:底部推荐
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_UatmFavorites:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘宝客返利订单查询
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_RebateOrderGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;
//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘宝客商品猜你喜欢
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_ItemGuessLike:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;
//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 物料传播方式获取接口(短链接)
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_SpreadGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;
//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 查询解析淘口令
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_WirelessShareTpwdQuery:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;
//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 创建淘口令
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_Search_WirelessShareTpwdCreate:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed;
@end


