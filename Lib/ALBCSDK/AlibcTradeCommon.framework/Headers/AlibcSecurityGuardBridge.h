/*
 * AlibcSecurityGuardBridge.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 AlibcTradeCommon 
 * 版本号：3.1.1.200
 * 发布时间：2017-08-21
 * 开发团队：阿里巴巴百川商业化团队
 * 阿里巴巴电商SDK答疑群号：1488705339  2071154343(阿里旺旺)
 * Copyright (c) 2016-2019 阿里巴巴-移动事业群-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>

#ifndef AlibcSecurityGuardBridge_h
#define AlibcSecurityGuardBridge_h

@interface AlibcSecurityGuardBridge : NSObject

#pragma mark - Life Cycle


/**
 安全模块初始化

 @param handler callback
 */
+ (void)asyncInit:(void (^)(NSError *))handler;

#pragma mark - Info


/**
 安全是否可用

 @return 安全是否可用
 */
+ (BOOL)isSecurityGuardAvaleable;


/**
 authCode

 @return auth code
 */
+ (NSString *)authCode;


/**
 获取AppKey

 @return AppKey
 */
+ (NSString *)getAppKey;

#pragma mark - Encryption & Decryption


/**
 解析混淆ID

 @param itemId 混淆ID
 @return 明文ID
 */
+ (NSNumber *)analyzeItemId:(NSString *)itemId;


#pragma mark - Storage

+ (NSString *)getString:(NSString *)key;

+ (int)putString:(NSString *)value forKey:(NSString *)key;

+ (NSData *)getData:(NSString *)key;

+ (int)putData:(NSData *)value forKey:(NSString *)key;

@end


/**
 Security Adapter 协议
 */
@protocol AlibcSecurityAdapter <NSObject>

- (void)asyncInit:(void (^)(NSError *))handler;

#pragma mark - Info

- (NSString *)getAppKey;

#pragma mark - Encryption & Decryption

- (NSNumber *)analyzeItemId:(NSString *)itemId;

#pragma mark - Storage

- (NSString *)getString:(NSString *)key;

- (int)putString:(NSString *)value forKey:(NSString *)key;

- (NSData *)getData:(NSString *)key;

- (int)putData:(NSData *)value forKey:(NSString *)key;


@end

#endif
