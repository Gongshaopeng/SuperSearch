//
//  CustomRequestManager.h
//
//  Created by allen on 15/6/12.
//  Copyright (c) 2015年 Youmei. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CacheManager.h"
#import "NSDictionary+CRCParam.h"

#define REQUESTDEBUG

#ifdef REQUESTDEBUG
#define RequestLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define RequestLog(format, ...)
#endif

typedef void (^RequestCompleted) (NSDictionary* dic); //!< 请求成功block
typedef void (^RequestFailed) (NSString* errorStr); //!< 请求失败block

typedef NS_ENUM(NSInteger,RequestMethod) {
    RequestMethodPost,
    RequestMethodGet
};
typedef NS_ENUM(NSInteger,RequestSignature) {
    RequestDonotsignType,//!<不要签名
    RequestTosignType,//!<要签名
    RequestTosignAddKeyType,//!<要签名+key
    RequestDefaultType//!<默认
};

@class FileModel;

@interface CustomRequestManager : NSObject

@property (nonatomic,assign) NSTimeInterval timeoutInterval;

/**
 *  @author allen, 15-09-26 16:09:18
 *
 *  @brief  请求管理类单例
 *
 *  @return 返回管理类单例
 */
+(CustomRequestManager*)sharedManager;
/**
 *  @author allen, 15-09-26 16:09:45
 *
 *  @brief  网络post请求.
 *
 *  @param url           请求的url.
 *  @param parameters    字典.
 *  @param completed     请求成功block.
 *  @param failed        请求失败block.
 *  @param cacheStrategy 缓存策略CacheStrategyNone, CacheStrategyDisk, CacheStrategyMemory.
 */
- (void)startRequestWithUrl:(NSString*) url parameters:(id)parameters completed:(RequestCompleted)completed failed:(RequestFailed)failed cacheStrategy:(CacheStrategy)cacheStrategy;

-(void)startRequestWithUrl:(NSString*) url parameters:(id)parameters completed:(RequestCompleted)completed failed:(RequestFailed)failed method:(RequestMethod) method;

/**
 *  @author allen, 15-11-04 10:11:17
 *
 *  @brief  网络请求
 *
 *  @param url           请求的url.
 *  @param parameters    参数,字典形式.
 *  @param completed     请求成功block.
 *  @param failed        请求失败block.
 *  @param method        请求方式RequestMethodPost RequestMethodGet.
 *  @param cacheStrategy 缓存策略CacheStrategyNone, CacheStrategyDisk, CacheStrategyMemory.
 */
- (void)startRequestWithUrl:(NSString*) url parameters:(id)parameters completed:(RequestCompleted)completed failed:(RequestFailed)failed method:(RequestMethod) method cacheStrategy:(CacheStrategy)cacheStrategy;
/**
 *  @author Allen, 15-12-08 09:12:05
 *
 *  @brief 表单提交
 *
 *  @param url        请求的url.
 *  @param parameters 参数,字典形式.
 *  @param files      文件model集合.
 *  @param completed  请求成功block.
 *  @param failed     请求方式RequestMethodPost RequestMethodGet.
 */
- (void)startUploadWithUrl:(NSString *)url parameters:(id)parameters files:(NSArray<FileModel*>*)files completed:(RequestCompleted)completed failed:(RequestFailed)failed;


/**
 *  @author Allen, 15-12-08 09:12:05
 *
 *  @brief 网络请求 + 签名
 *
 *  @param url        请求的url.
 *  @param parameters 参数,字典形式.
 *  @param files      文件model集合.
 *  @param completed  请求成功block.
 *  @param failed     请求失败block.
 *  @param method     请求方式RequestMethodPost RequestMethodGet.
 *  @param signature  请求方式RequestDonotsignType RequestTosignType RequestTosignAddKeyType.
 
 */
-(void)startRequestWithUrl:(NSString*) url parameters:(id)parameters completed:(RequestCompleted)completed failed:(RequestFailed)failed method:(RequestMethod) method Signature:(RequestSignature)signature;
@end

@interface FileModel:NSObject
@property (nonatomic,strong) NSString *path;
@property (nonatomic,strong) NSString *name;//!< file
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) NSString *mimeType;
@property (nonatomic,strong) NSData* data;
@end

