//
//  EntireManageMent.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "EntireManageMent.h"

@implementation EntireManageMent

//============================================================================================================
//缓存

+(BOOL)isExisedManager:(NSString *)type
{
    return  [[GS_CacheManager cacheManager] isExistAppForType:type];
}


+(void)addCacheName:(NSString *)type jsonString:(NSString *)json updataTime:(NSString *)time{
    BOOL _isExised;
    GS_CacheModel * model = [[GS_CacheModel alloc]init];
    model.type = type?:@"";
    model.jsonStr = json?:@"";
    model.updateTime = time?:[NewTimeTool getHistorySerctionTimeNow];;
    _isExised = [[GS_CacheManager cacheManager] isExistAppForType:type];
    if (_isExised) {
        GSLog(@"更新");
        [self updataCacheName:type jsonString:json updataTime:time];
    }else{
        GSLog(@"添加Cache");
        [[GS_CacheManager cacheManager] insertModel:model];
    }
}
+(void)removeCacheWithName:(NSString *)name{
  [[GS_CacheManager cacheManager] deleteModelForType:name];
}
+(void)updataCacheName:(NSString *)type jsonString:(NSString *)json updataTime:(NSString *)time{
    GS_CacheModel * model = [[GS_CacheModel alloc]init];
    model.type = type?:@"";
    model.jsonStr = json?:@"";
    model.updateTime = time?:@"";
    [[GS_CacheManager cacheManager] updataExistNewModel:model complete:^{
        GSLog(@"更新成功");
    } failed:^{
        GSLog(@"更新失败");

    }];
}
+(NSString *)readCacheDataWithName:(NSString *)name{
  return  [[GS_CacheManager cacheManager] readWithRecord:name];
}

//============================================================================================================
//配置

+(BOOL)isExisedConfigManager:(NSString *)key
{
    return  [[GS_ConfigManager configManager] isExistAppForconfigkey:key];
}

+(void)addConfigKey:(NSString *)configKey configvalue:(NSString *)configvalue updataTime:(NSString *)time{
    BOOL _isExised;
    ConfigModel * model = [[ConfigModel alloc]init];
    model.configkey = configKey?:@"";
    model.configvalue = configvalue?:@"";
    model.updateTime = time?:[NewTimeTool getHistorySerctionTimeNow];;
    _isExised = [[GS_ConfigManager configManager]  isExistAppForconfigkey:configKey];
    if (_isExised) {
        GSLog(@"更新");
        [self updataConfigModel:model];
    }else{
        GSLog(@"添加Cache");
        [[GS_ConfigManager configManager] insertConfigModel:model];
    }
}

+(void)removeConfigWithKey:(NSString *)key{
    [[GS_ConfigManager configManager]  deleteModelForconfigkey:key];
}

+(void)updataConfigKey:(NSString *)configKey configvalue:(NSString *)configvalue updataTime:(NSString *)time{
    ConfigModel * model = [[ConfigModel alloc]init];
    model.configkey = configKey?:@"";
    model.configvalue = configvalue?:@"";
    model.updateTime = time?:@"";
    [self updataConfigModel:model];
}
+(void)updataConfigModel:(id)model{
    ConfigModel *appModel = (ConfigModel *)model;

    [[GS_ConfigManager configManager]  updataExistConfigModel:appModel complete:^{
        GSLog(@"更新成功");
    } failed:^{
        GSLog(@"更新失败");
        
    }];
}
+(NSString *)readConfigDataWithConfigKey:(NSString *)configKey{
    return  [[GS_ConfigManager configManager]  readWithRecord:configKey];
}


@end
