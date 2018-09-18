//
//  SSAppversionTool.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/8.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "SSAppversionTool.h"

@implementation SSAppversionTool
// 获取保存的上一个版本信息
+ (NSString *)ss_GetLastOneAppVersion {
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AppVersion"];
}

// 保存新版本信息（偏好设置）
+ (void)ss_SaveNewAppVersion:(NSString *)version {
    
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"AppVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
