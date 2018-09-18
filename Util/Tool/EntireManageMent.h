//
//  EntireManageMent.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
//模型
#import "GS_CacheModel.h"
#import "ConfigModel.h"
//SQL
#import "GS_CacheManager.h"
#import "GS_ConfigManager.h"

@interface EntireManageMent : NSObject
/**
 * 数据缓存操作
 */
//是否有缓存
+(BOOL)isExisedManager:(NSString *)type;
//增加
+(void)addCacheName:(NSString *)type jsonString:(NSString *)json updataTime:(NSString *)time;
//读取
+(NSString *)readCacheDataWithName:(NSString *)name;
//修改
+(void)updataCacheName:(NSString *)type jsonString:(NSString *)json updataTime:(NSString *)time;
//删除
+(void)removeCacheWithName:(NSString *)name;

/**
 * 配置缓存操作
 */
+(BOOL)isExisedConfigManager:(NSString *)key;
+(void)addConfigKey:(NSString *)configKey configvalue:(NSString *)configvalue updataTime:(NSString *)time;
+(void)removeConfigWithKey:(NSString *)key;
+(void)updataConfigKey:(NSString *)configKey configvalue:(NSString *)configvalue updataTime:(NSString *)time;
+(NSString *)readConfigDataWithConfigKey:(NSString *)configKey;


@end
