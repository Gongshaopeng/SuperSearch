//
//  IndexProtocol.h
//  LaiZhuan
//
//  Created by allen on 16/1/12.
//  Copyright © 2016年 jianjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestModel;
@class ResponseModel;
@class resultsModel;
@class TBKItemModel;
@class TBKCouponModel;

@protocol tbkProtocol <NSObject>

@optional
//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 搜索商品
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_ItmeGet:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘宝客商品链接转换
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_ItemConvert:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘宝客返利授权查询
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_RebateAuthGet:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘宝客返利订单查询
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_RebateOrderGet:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed;


//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘宝客淘口令
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_TpwdCreate:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed;
//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘客媒体内容输出
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_ContentGet:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 淘抢购
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_JuTqgGet:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 好券清单API【导购】
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_DgItemCouponGet:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 获取淘宝联盟选品库列表
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_UatmFavoritesGet:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed;
//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 获取淘宝联盟选品库的宝贝信息
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_UatmFavoritesItemGet:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 查询解析淘口令
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_WirelessShareTpwdQuery:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed;

//**
// *  @author gongxiaopeng, 16-01-13 15:01:26
// *
// *  @brief 短连接
// *
// *  @param paramDto 请求参数
// *  @param complete 返回数据
// *  @param failed   失败的回调
// */
- (void)r_tb_TaobaoTbkSpreadGet:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed;

@end

