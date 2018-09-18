//
//  GS_CacheManager.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GS_CacheModel.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface GS_CacheManager : NSObject
//非标准单例
+ (GS_CacheManager *)cacheManager;



//增加 数据 收藏/浏览/下载记录

//存储类型 favorites downloads browses
- (void)insertModel:(id)model;
//删
- (void)deleteModelForType:(NSString *)type;
//修改
- (void)updataExistNewModel:(id)model complete:(void (^)(void))complete failed:(void (^)(void))failed;
//查
- (BOOL)isExistAppForType:(NSString *)type;

-(NSString *)readWithRecord:(NSString *)type;






@end
