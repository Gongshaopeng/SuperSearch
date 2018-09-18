//
//  NSDictionary+GSDictionary.h
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/6/8.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GSDictionary)
/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;
+ (NSDictionary *)dicFromObject:(NSObject *)object ;
+ (NSMutableDictionary *)returnToDictionaryWithModel:(NSObject *)object;

@end
