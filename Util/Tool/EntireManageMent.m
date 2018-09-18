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


//生成json文件

+ (void)onjson:(NSDictionary *)dict fileName:(NSString *)fileName

{
    
//    //    如果数组或者字典中存储了  NSString, NSNumber, NSArray, NSDictionary, or NSNull 之外的其他对象,就不能直接保存成文件了.也不能序列化成 JSON 数据.
//    
////    NSDictionary *dict = @{@"name" : @"me", @"do" : @"something", @"with" : @"her", @"address" : @"home"};
//    
//    
//    
//    // 1.判断当前对象是否能够转换成JSON数据.
//    
//    // YES if obj can be converted to JSON data, otherwise NO
//    
//    BOOL isYes = [NSJSONSerialization isValidJSONObject:dict];
//    
//    
//    
//    if (isYes) {
//        
//        NSLog(@"可以转换");
//        
//        
//        
//        /* JSON data for obj, or nil if an internal error occurs. The resulting data is a encoded in UTF-8.
//         
//         */
//        
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
//        
//        
//        
//        /*
//         
//         Writes the bytes in the receiver to the file specified by a given path.
//         
//         YES if the operation succeeds, otherwise NO
//         
//         */
//        
//        // 将JSON数据写成文件
//        
//        // 文件添加后缀名: 告诉别人当前文件的类型.
//        
//        // 注意: AFN是通过文件类型来确定数据类型的!如果不添加类型,有可能识别不了! 自己最好添加文件类型.
//        
//        //        [jsonData writeToFile:@"/Users/xyios/Desktop/dict.json" atomically:YES];
//        
//        //存入NSDocumentDirectory
//        
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//        
//        
//        
//        //创建文件夹
//        
//        NSString *patientPhotoFolder = [path stringByAppendingPathComponent:fileName];
//        
//        NSFileManager *fileManager = [[NSFileManager alloc] init];
//        
//        [fileManager createDirectoryAtPath:patientPhotoFolder
//         
//               withIntermediateDirectories:NO
//         
//                                attributes:nil
//         
//                                     error:nil];
//        
//        //储存文件名称+格式
//        NSString * jsonName =[NSString stringWithFormat:@"%@.json",fileName];
//        NSString *savePath = [patientPhotoFolder stringByAppendingPathComponent:jsonName];
//        
//        NSLog(@"savePath is SY:%@",savePath);
//        
//        [jsonData writeToFile:savePath atomically:YES];
//        
//        
//        
//        NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
//        
//        
//        
//    } else {
//        
//        
//        
//        NSLog(@"JSON数据生成失败，请检查数据格式");
//        
//        
//        
//    }
    
    
    
}
@end
