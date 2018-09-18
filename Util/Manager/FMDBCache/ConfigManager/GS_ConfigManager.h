//
//  GS_ConfigManager.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/5/15.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "ConfigModel.h"

@interface GS_ConfigManager : NSObject
//非标准单例
+ (GS_ConfigManager *)configManager;



//增加 数据 收藏/浏览/下载记录

//存储类型 favorites downloads browses
- (void)insertConfigModel:(id)model;
//删
- (void)deleteModelForconfigkey:(NSString *)configkey;
//修改
- (void)updataExistConfigModel:(id)model complete:(void (^)(void))complete failed:(void (^)(void))failed;
//查
- (BOOL)isExistAppForconfigkey:(NSString *)configkey;

-(NSString *)readWithRecord:(NSString *)configkey;


@end
