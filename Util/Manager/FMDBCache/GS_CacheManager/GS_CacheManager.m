//
//  GS_CacheManager.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GS_CacheManager.h"

static  FMDatabase * _database;
@implementation GS_CacheManager
{
   
}

+(GS_CacheManager *)cacheManager
{
    static GS_CacheManager *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once ,^
                  {
                      if (manager==nil)
                      {
                          manager=[[GS_CacheManager alloc]init];
                      }
                  });
    return manager;
}
- (id)init {
    if (self = [super init]) {
        //1.获取数据库文件app.db的路径
        //        NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Documents/HistoryBrowser.db"];
        
        NSString *filePath = [self getFileFullPathWithFileName:__Manager_gsCache__];
        //2.创建database
        FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
//                _database = [FMDatabase databaseWithPath:filePath];
        [queue inDatabase:^(FMDatabase *db) {
            _database = db;
        }];
        //3.open
        //第一次 数据库文件如果不存在那么 会创建并且打开
        //如果存在 那么直接打开
        if ([_database open]) {
                NSLog(@"数据库打开成功");
            //创建表 不存在 则创建
            [self creatTable];
        }else {
                NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
//        [_database close];

    }
    return self;
}
#pragma mark - 创建表
- (void)creatTable {
    //字段: 名字 图片 音乐地址
    NSString *sql = @"CREATE TABLE IF NOT EXISTS GSCACHEHISTORY( type TEXT NOT NULL, jsonStr TEXT NOT NULL, updateTime TEXT NOT NULL)";
    
    //创建表 如果不存在则创建新的表
    BOOL isSuccees = [_database executeUpdate:sql];
    if (!isSuccees) {
        //        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
}
#pragma mark - 获取文件的全路径

//获取文件在沙盒中的 Documents中的路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    NSString *docPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:docPath]) {
        //文件的全路径
        return [docPath stringByAppendingFormat:@"/%@",fileName];
    }else {
        //如果不存在可以创建一个新的
        //        NSLog(@"Documents不存在");
        return nil;
    }
}


//增加 数据 收藏/浏览/下载记录
//存储类型 favorites downloads browses
- (void)insertModel:(id)model  {
    GS_CacheModel *appModel = (GS_CacheModel *)model;
  
    if ([self isExistAppForType:appModel.type]==YES) {
        
        //        NSLog(@"this app has recorded");
        return;
    }
    NSString *sql = @"REPLACE INTO GSCACHEHISTORY (type,jsonStr,updateTime) values (?,?,?)";
    
    BOOL isSuccess = [_database executeUpdate:sql,appModel.type,appModel.jsonStr,appModel.updateTime];
    
    if (!isSuccess) {
        //        NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
//    [_database close];
}
//根据指定的类型 返回 这条记录在数据库中是否存在
- (BOOL)isExistAppForType:(NSString *)type
{
    NSString *sql = @"SELECT * from GSCACHEHISTORY where type = ?";
//      [_database open];
    FMResultSet *rs = [_database executeQuery:sql,type];
     NSLog(@"%@-----------MusModel--------",rs);
    if ([rs next]) {//查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        return YES;
    }else{
        return NO;
    }
}
//删除指定的应用数据 根据指定的类型
- (void)deleteModelForType:(NSString *)type {
//    [_database open];
    NSString *sql = @"DELETE from GSCACHEHISTORY where type = ? ";
    BOOL isSuccess = [_database executeUpdate:sql,type];
    if (!isSuccess) {
        //        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
//      [_database close];
}
//修改
- (void)updataExistNewModel:(id)model complete:(void (^)(void))complete failed:(void (^)(void))failed
{
    GS_CacheModel *appModel = (GS_CacheModel *)model;
    
//    [_database open];
    NSString * str = [NSString stringWithFormat:@"UPDATE GSCACHEHISTORY set type ='%@'  where jsonStr ='%@'",appModel.type,appModel.jsonStr];
    //    NSString *sql = @"updata COLLECTION set  where title = ?";
    BOOL isSuccess = [_database executeUpdate:str];
    // NSLog(@"%@-----------MusModel--------",rs);
    if (isSuccess) {//查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        NSLog(@"修改成功");
        complete();
    }else{
        NSLog(@"修改失败");
        failed();
    }
//    [_database close];
}
//查
-(NSString *)readWithRecord:(NSString *)type{
    NSString * dataArr;
//    [_database open];
    NSString *selSQL=@"SELECT * from GSCACHEHISTORY where type = ?";
    FMResultSet *set=[_database executeQuery:selSQL,type];
    //遍历集合
    while ([set next]) {
        GS_CacheModel * model = [[GS_CacheModel alloc]init];
        model.jsonStr = [set stringForColumn:@"jsonStr"];
        dataArr = model.jsonStr;
    }
//      [_database close];
    return dataArr?:@"";
}

@end
