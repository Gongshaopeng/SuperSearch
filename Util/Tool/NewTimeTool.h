//
//  NewTimeTool.h
//  Esou
//
//  Created by 巩小鹏 on 16/9/20.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewTimeTool : NSObject
+(NSString *)getTimeInterval;

+(NSString *)getDetailedTimeNow;
+(NSString *)getHistorySerctionTimeNow;

//获取系统当前时间
+ (NSString *)getTime;

+ (NSString *)getTimeNow;
//换算时差
+(NSDate *)dateStr:(NSString *)time;
+(NSDate *)dateTimeStr:(NSString *)time;
+(NSDate *)dateTimeGStr:(NSString *)timeStr;

//对比时间
+(NSInteger)getUTCFormateDate:(NSString *)newsDate;
+(NSInteger)getUTCFormateDate:(NSString *)newsDate TimeInterval:(NSTimeInterval)timeNumber;
+(NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
+ (BOOL)isDateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime minute:(int)min;

//月——日
+(NSString *)setMonthAndDay:(NSString *)time;
//Day
+(NSInteger)setDay:(NSString *)time;
//秒转分秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime;
+(NSString *)getHHMMSSFromSS:(NSString *)totalTime;

@end
