/*
 * AlibcLinkPartnerBridge.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 AlibcTradeBiz 
 * 发布时间：3.1.1.204
 * 发布时间：2017-09-04
 * 开发团队：阿里巴巴百川商业化团队
 * 阿里巴巴电商SDK答疑群号：1488705339  2071154343(阿里旺旺)
 * Copyright (c) 2016-2019 阿里巴巴-移动事业群-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>

#ifndef AlibcNativeFailMode_Enum
#define AlibcNativeFailMode_Enum

/**
 拉起手淘失败后的处理策略
 
 - AlibcNativeFailModeJumpH5: 当拉起手淘/天猫失败, 则在 webview 中跳转对应 H5 页面; 默认选项
 - AlibcNativeFailModeJumpDownloadPage: 当拉起手淘/天猫失败, 则跳转对应 App 下载页面
 - AlibcNativeFailModeJumpBrowser: 当拉起手淘/天猫失败, 则在浏览器中跳转对应 H5 页面
 - AlibcNativeFailModeNone: 当拉起手淘/天猫失败, 不做额外操作
 */
typedef NS_ENUM(NSInteger, AlibcNativeFailMode) {
    AlibcNativeFailModeJumpH5 = 0,
    AlibcNativeFailModeJumpDownloadPage = 1,
    AlibcNativeFailModeJumpBrowser = 2,
    AlibcNativeFailModeNone = 3,
};

#endif

#ifndef ALiApplinkBridge_h
#define ALiApplinkBridge_h

NS_ASSUME_NONNULL_BEGIN

@class AlibcError;
@class AlibcTradeTaokeParams;

@interface AlibcLinkPartnerBridge : NSObject


/**
 *  初始化

 @param appkey appkey
 */
+ (void)initWithAppkey:(nonnull NSString *)appkey;


/**
 * 尝试跳转详情页

 @param itemID Item ID
 @param params 参数
 @param failMode 跳转失败处理策略
 @param taoKeParams 淘客参数
 @return 跳转错误对象
 */
+ (nullable AlibcError *)tryJumpToDetail:(NSString *)itemID
                                  params:(nullable NSDictionary *)params
                                failMode:(AlibcNativeFailMode)failMode
                             taokeParams:(nullable AlibcTradeTaokeParams *)taoKeParams;


/**
 * 尝试跳转店铺页

 @param shopID shopID
 @param params 参数
 @param failMode 跳转失败处理策略
 @param taoKeParams 淘客参数
 @return 跳转错误对象
 */
+ (nullable AlibcError *)tryJumpToShop:(NSString *)shopID
                                params:(nullable NSDictionary *)params
                              failMode:(AlibcNativeFailMode)failMode
                           taokeParams:(nullable AlibcTradeTaokeParams *)taoKeParams;


/**
 * 尝试跳转指定网页

 @param url URL String
 @param params 参数
 @param failMode 跳转失败处理策略
 @param taoKeParams 淘客参数
 @return 跳转错误对象
 */
+ (nullable AlibcError *)tryJumpToURL:(NSString *)url
                               params:(nullable NSDictionary *)params
                             failMode:(AlibcNativeFailMode)failMode
                          taokeParams:(nullable AlibcTradeTaokeParams *)taoKeParams;


/**
 * 处理 URL 跳转

 @param url url
 @param sourceApplication sourceApplication
 @param options options
 @return handle or not
 */
+ (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(nullable NSString *)sourceApplication
              options:(nullable NSDictionary<NSString *, id> *)options;


/**
 * 在天猫未安装导致天猫打开失败时, 尝试打开手淘

 @param enable enable
 */
+ (void)enableOpenTaobaoWhenTmallNotInstalled:(BOOL)enable;

+ (BOOL)canOpenApp:(nonnull NSString *)linkkey;


@end

NS_ASSUME_NONNULL_END

#endif //ALiApplinkBridge_h
