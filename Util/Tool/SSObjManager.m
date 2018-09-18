//
//  ssObjManager.m
//  CDDKit
//
//  Created by apple on 2017/10/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "SSObjManager.h"

@implementation SSObjManager

#pragma mark - 把对象归档存到沙盒里
+ (void)ss_saveObject:(id)object byFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    
    [NSKeyedArchiver archiveRootObject:object toFile:path];
    
}

#pragma mark - 通过文件名从沙盒中找到归档的对象
+ (id)ss_getObjectByFileName:(NSString*)fileName
{
    
    NSString *path  = [self appendFilePath:fileName];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

#pragma mark - 根据文件名删除沙盒中的 plist 文件
+ (void)ss_removeFileByFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

#pragma mark - 拼接文件路径
+ (NSString*)appendFilePath:(NSString*)fileName
{
    
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *file = [NSString stringWithFormat:@"%@/%@.archiver",documentsPath,fileName];
    
    return file;
}

#pragma mark - NSUserDefults
+ (void)ss_saveUserData:(id)data forKey:(NSString*)key
{
    if (data)
    {
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

#pragma mark - 读取用户偏好设置
+ (id)ss_readUserDataForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
}

#pragma mark - 删除用户偏好设置
+ (void)ss_removeUserDataForkey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
}


@end
