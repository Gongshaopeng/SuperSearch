//
//  SSAppversionTool.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/8.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSAppversionTool : NSObject
/**
 *  获取之前保存的版本
 *
 *  @return NSString类型的AppVersion
 */
+ (NSString *)ss_GetLastOneAppVersion;
/**
 *  保存新版本
 */
+ (void)ss_SaveNewAppVersion:(NSString *)version;

@end
