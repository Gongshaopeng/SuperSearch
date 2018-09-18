//
//  GS_ConfigManager.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/5/15.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GS_ConfigManager.h"

static  FMDatabase * _database;
@implementation GS_ConfigManager
{
    
}

+(GS_ConfigManager *)configManager
{
    static GS_ConfigManager *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once ,^
                  {
                      if (manager==nil)
                      {
                          manager=[[GS_ConfigManager alloc]init];
                      }
                  });
    return manager;
}
- (id)init {
    if (self = [super init]) {
        //1.获取数据库文件app.db的路径
        //        NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Documents/HistoryBrowser.db"];
        
        NSString *filePath = [self getFileFullPathWithFileName:__Manager_gsConfig__];
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
    NSString *sql = @"CREATE TABLE IF NOT EXISTS GS_ConfigManager( configkey TEXT NOT NULL, configvalue TEXT NOT NULL, updateTime TEXT NOT NULL)";
    
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
- (void)insertConfigModel:(id)model  {
    ConfigModel *appModel = (ConfigModel *)model;
    
    if ([self isExistAppForconfigkey:appModel.configkey]==YES) {
        
        //        NSLog(@"this app has recorded");
        return;
    }
    NSString *sql = @"REPLACE INTO GS_ConfigManager (configkey,configvalue,updateTime) values (?,?,?)";
    
    BOOL isSuccess = [_database executeUpdate:sql,appModel.configkey,appModel.configvalue,appModel.updateTime];
    
    if (!isSuccess) {
        //        NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
    //    [_database close];
}
//根据指定的类型 返回 这条记录在数据库中是否存在
- (BOOL)isExistAppForconfigkey:(NSString *)configkey
{
    NSString *sql = @"SELECT * from GS_ConfigManager where configkey = ?";
    //      [_database open];
    FMResultSet *rs = [_database executeQuery:sql,configkey];
    NSLog(@"%@-----------MusModel--------",rs);
    if ([rs next]) {//查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        return YES;
    }else{
        return NO;
    }
}
//删除指定的应用数据 根据指定的类型
- (void)deleteModelForconfigkey:(NSString *)configkey {
    //    [_database open];
    NSString *sql = @"DELETE from GS_ConfigManager where configkey = ? ";
    BOOL isSuccess = [_database executeUpdate:sql,configkey];
    if (!isSuccess) {
        //        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
    //      [_database close];
}
//修改
- (void)updataExistConfigModel:(id)model complete:(void (^)(void))complete failed:(void (^)(void))failed
{
    ConfigModel *appModel = (ConfigModel *)model;
    
    //    [_database open];
    NSString * str = [NSString stringWithFormat:@"UPDATE GS_ConfigManager set configvalue ='%@'  where configkey ='%@'",appModel.configvalue,appModel.configkey];
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
-(NSString *)readWithRecord:(NSString *)configkey{
    NSString * configvalue;
    //    [_database open];
    NSString *selSQL=@"SELECT * from GS_ConfigManager where configkey = ?";
    FMResultSet *set=[_database executeQuery:selSQL,configkey];
    //遍历集合
    while ([set next]) {
        ConfigModel * model = [[ConfigModel alloc]init];
        model.configvalue = [set stringForColumn:@"configvalue"];
        configvalue = model.configvalue;
    }
    //      [_database close];
    return configvalue?:@"";
}
@end
