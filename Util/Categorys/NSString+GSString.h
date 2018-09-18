//
//  NSString+GSString.h
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/12/1.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonDigest.h>

@interface NSString (GSString)
//分割字符串
+(NSString *)gsStringFrom:(NSString *)allStr ComponentsSeparatedByString:(NSString *)Str lastOrFirst:(NSInteger)position;
//获取字符串宽
+(CGSize)measureSinglelineStringSize:(NSString*)str andFont:(UIFont*)wordFont;

//获取字符串宽 // 传一个字符串和字体大小来返回一个字符串所占的宽度
+(float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont;

//获取字符串高 // 传一个字符串和字体大小来返回一个字符串所占的高度
+(float)measureMutilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidthSetup:(float)width;

+ (CGFloat)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width;
+ (CGFloat)widthFromString:(NSString*)text  withFont:(UIFont*)font constraintToHeight:(CGFloat)height;
//MD5加密
+(NSString *)gsMD5:(NSString *)input;
+ (NSString *)UserName:(NSString *)name;

//字典转json字符串
+(NSString *)convertToJsonData:(NSDictionary *)dict;

//判断是否是整型
+ (BOOL)isPureInt:(NSString*)string;
//判断是否是浮点型
+ (BOOL)isPureFloat:(NSString*)string;

+(NSString *)reviseString:(NSString* )string;

+(NSMutableAttributedString *)setStringtext:(NSString *)detailStr font:(CGFloat)font MakeRangeLeft:(NSUInteger)rangeleft MakeRangeRight:(NSUInteger)rangeRight;

//过滤WebP 图片
+(NSString *)imageWebpInterceptionURL:(NSString *)imgUrl;
//字符串替换
+(NSString *)initWithUrl:(NSString *)url stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;
//通过图片Data数据第一个字节 来获取图片扩展名

+ (NSString *)contentTypeForImageData:(NSData *)data;
//url解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) urlStr;
//清空字符串中的空格换行
+ (NSString *)removeSpaceAndNewline:(NSString *)str;


@end
