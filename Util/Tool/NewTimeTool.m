//
//  NewTimeTool.m
//  Esou
//
//  Created by 巩小鹏 on 16/9/20.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import "NewTimeTool.h"

@implementation NewTimeTool

+(NSString *)getTimeInterval
{
    NSDate *senddate = [NSDate date];

    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]*1000];
    
    GSLog(@"date2时间戳 = %@",date2);
    
    return date2;
}

+(NSString *)getDetailedTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatterDetailedTime = [[NSDateFormatter alloc ] init];
    [formatterDetailedTime setDateFormat:@"YYYY.MM.dd.HH.mm.ss"];
//    [formatterDetailedTime setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

    //    [formatter setDateFormat:@"YYYY-MM-dd"];
    //        [formatter setDateFormat:@" hh:mm:ss -- SSS"];
    date = [formatterDetailedTime stringFromDate:[NSDate date]];
    NSString * detailedTime = [[NSString alloc] initWithFormat:@"%@", date];
    //    NSLog(@"%@", timeNow);
    return detailedTime;
}
+(NSString *)getHistorySerctionTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //    [formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //    [formatter setDateFormat:@" hh:mm:ss -- SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString * timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    //    NSLog(@"%@", timeNow);
    return timeNow;
}
//获取系统当前时间
+ (NSString *)getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //    [formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [formatter setDateFormat:@" hh:mm:ss -- SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString * timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    //    NSLog(@"%@", timeNow);
    return timeNow;
}

+ (NSString *)getTime
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //    [formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"yyyyMMdd"];
    //    [formatter setDateFormat:@" hh:mm:ss -- SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString * timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    //    NSLog(@"%@", timeNow);
    return timeNow;
}



//换算时差
+(NSDate *)dateStr:(NSString *)time{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *dateTime = [dateFormatter dateFromString:time];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: dateTime];
    NSDate *date = [dateTime  dateByAddingTimeInterval: interval];
    return date;
    
}
+(NSInteger)setDay:(NSString *)time
{

    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate*inputDate = [inputFormatter dateFromString:time];
    
    //    NSLog(@"now date is: %@", inputDate);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:inputDate];
    
    //    NSInteger year = [dateComponent year];
//    NSInteger month =  [dateComponent month];
    NSInteger day = [dateComponent day];
    return day;
}
+(NSString *)setMonthAndDay:(NSString *)time{
    
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate*inputDate = [inputFormatter dateFromString:time];
   
//    NSLog(@"now date is: %@", inputDate);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:inputDate];
    
//    NSInteger year = [dateComponent year];
    NSInteger month =  [dateComponent month];
    NSInteger day = [dateComponent day];
//    NSInteger hour =  [dateComponent hour];
//    NSInteger minute =  [dateComponent minute];
//    NSInteger second = [dateComponent second];
    
    NSString * timeNew = [NSString stringWithFormat:@"%ld-%ld",(long)month,(long)day];
    return timeNew;
}

+(NSDate *)dateTimeStr:(NSString *)time{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//    NSDate *dateTime = [dateFormatter dateFromString:time];
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate*inputDate = [inputFormatter dateFromString:time];
    return inputDate;
}
+(NSDate *)dateTimeGStr:(NSString *)timeStr{
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //    NSDate *dateTime = [dateFormatter dateFromString:time];
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
//    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate*inputDate = [inputFormatter dateFromString:timeStr];
    return [self worldTimeToChinaTime:inputDate];
}
//将世界时间转化为中国区时间
+(NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}
+(NSInteger)getUTCFormateDate:(NSString *)newsDate
{
    NSInteger ci;
//    NSLog(@"第一次记录时间 = %@",newsDate);
    NSDate *time = [self dateStr:newsDate];
    NSDate *date = [self dateStr:self.getTimeNow];
    time = [[NSDate alloc] initWithTimeInterval:3600 sinceDate:time];
//    NSLog(@"一个小时后时间 localDate = %@",time);
//    NSLog(@"现在时间 localDate = %@",date);
    
    NSComparisonResult resultt = [date compare:time];
    switch (resultt)
    {
            //一个小时后比现在当前时间 大
        case NSOrderedAscending: ci=1; break;
            //一个小时后比现在当前时间 小
        case NSOrderedDescending: ci=-1; break;
            //一个小时后比现在当前时间 相等
        case NSOrderedSame: ci=0; break;
        default:
            break;
    }
    
    return ci;
}
+(NSInteger)getUTCFormateDate:(NSString *)newsDate TimeInterval:(NSTimeInterval)timeNumber
{
    NSInteger ci;
//    NSLog(@"第一次记录时间 = %@",newsDate);
    NSDate *time = [NewTimeTool dateStr:newsDate];
    NSDate *date = [NewTimeTool dateStr:[NewTimeTool getTimeNow]];
    NSDate* time1 = [[NSDate alloc] initWithTimeInterval:timeNumber sinceDate:time];
//    NSLog(@"多少小时后时间 localDate = %@",time);
//    NSLog(@"现在时间 localDate = %@",date);
    
    NSComparisonResult resultt = [date compare:time1];
    switch (resultt)
    {
            //一个小时后比现在当前时间 大
        case NSOrderedAscending: ci=1; break;
            //一个小时后比现在当前时间 小
        case NSOrderedDescending: ci=2; break;
            //一个小时后比现在当前时间 相等
        case NSOrderedSame: ci=0; break;
        default:
            break;
    }
    
    return ci;
}

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    int second = (int)value %60;//秒
    
    int minute = (int)value /60%60;
    
    int house = (int)value / (24 * 3600)%3600;
    
    int day = (int)value / (24 * 3600);
    
    NSString *str;
    
    if (day != 0) {
        
        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
        
    }else if (day==0 && house != 0) {
        
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
        
    }else if (day== 0 && house== 0 && minute!=0) {
        
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
        
    }else{
        
        str = [NSString stringWithFormat:@"耗时%d秒",second];
        
    }
    
    return str;
    
}
+ (BOOL)isDateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime minute:(int)min{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
//    int second = (int)value %60;//秒
    
    int minute = (int)value /60%60;
    
//    int house = (int)value / (24 * 3600)%3600;
//    
//    int day = (int)value / (24 * 3600);
    
//    NSString *str;
//    
//    if (day != 0) {
//        
//        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
//        
//    }else if (day==0 && house != 0) {
//        
//        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
//        
//    }else if (day== 0 && house== 0 && minute!=0) {
//        
//        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
//        
//    }else{
//        
//        str = [NSString stringWithFormat:@"耗时%d秒",second];
//        
//    }
    if (minute > min ) {
        return YES;
    }
    return NO;
    
}

//传入 秒  得到  xx时xx分钟xx秒
+(NSString *)getHHMMSSFromSS:(NSString *)totalTime
{
    
    NSInteger seconds = [totalTime integerValue];
    NSInteger minute = seconds/60;
    NSInteger second = seconds%60;
    NSString *str_minute;
    NSString *str_second;
    NSString *format_time;
    
    NSString *str_hour = [NSString stringWithFormat:@"%0ld",seconds/3600];
    if (second<10) {
        str_second = [NSString stringWithFormat:@"0%ld",seconds%60];
    }else{
        str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    }
    
    if ([str_hour integerValue]!= 0) {
        if (minute<10) {
            str_minute = [NSString stringWithFormat:@"0%ld",(seconds%3600)/60];
        }else{
            str_minute = [NSString stringWithFormat:@"%ld",(seconds%3600)/60];
        }
        
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
        
    }else{
        if (minute<10) {
            str_minute = [NSString stringWithFormat:@"0%ld",seconds/60];
        }else{
            str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
        }
        
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
        
    }
    //    NSLog(@"format_time : %@",format_time);
    
    return format_time;
    
}
//传入 秒  得到  xx分钟xx秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime
{
    
    NSInteger seconds = [totalTime integerValue];
    NSInteger minute = seconds/60;
    NSInteger second = seconds%60;
    NSString *str_minute;
    NSString *str_second;
    NSString *format_time;
    
    NSString *str_hour = [NSString stringWithFormat:@"%0ld",seconds/3600];
    if (second<10) {
        str_second = [NSString stringWithFormat:@"0%ld",seconds%60];
    }else{
        str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    }
    
    if ([str_hour integerValue]!= 0) {
        if (minute<10) {
            str_minute = [NSString stringWithFormat:@"0%ld",seconds/60];
        }else{
            str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
        }
        
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
        
    }else{
        if (minute<10) {
            str_minute = [NSString stringWithFormat:@"0%ld",seconds/60];
        }else{
            str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
        }
        
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
        
    }
//    //    NSLog(@"format_time : %@",format_time);
//    NSInteger seconds = [totalTime integerValue];
//    
//    //format of minute
//    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
//    //format of second
//    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
//    //format of time
//    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];

    
    return format_time;
    
}

@end
