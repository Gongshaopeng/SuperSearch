//
//  NSString+GSString.m
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/12/1.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import "NSString+GSString.h"

@implementation NSString (GSString)

+(NSString *)gsStringFrom:(NSString *)allStr ComponentsSeparatedByString:(NSString *)Str lastOrFirst:(NSInteger)position
{
    NSString * gsString;
    NSArray *array = [allStr componentsSeparatedByString:Str]; //从字符A中分隔成2个元素的数组
    gsString = array[position];
    return gsString;
}

+(float)measureMutilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidthSetup:(float)width{
    
    if (str == nil || width <= 0) return 0;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return ceil(measureSize.height);
    
}

// 传一个字符串和字体大小来返回一个字符串所占的宽度

+(float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont{
    
    if (str == nil) return 0;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return ceil(measureSize.width);
    
}



+(CGSize)measureSinglelineStringSize:(NSString*)str andFont:(UIFont*)wordFont

{
    
    if (str == nil) return CGSizeZero;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return measureSize;
    
}

+ (CGFloat)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width
{
    CGRect rect;
    
    float iosVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (iosVersion >= 7.0) {
        rect = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    }else {
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    return rect.size.height;
}

+ (CGFloat)widthFromString:(NSString*)text withFont:(UIFont*)font constraintToHeight:(CGFloat)height
{
    CGRect rect;
    
    float iosVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (iosVersion >= 7.0) {
        rect = [text boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    }else {
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(1000, height) lineBreakMode:NSLineBreakByWordWrapping];
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    return rect.size.width ;
}

+(NSString *)gsMD5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr,(int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+(NSString *)UserName:(NSString *)name
{
    if(name != nil){
        if(![name isEqualToString:@""]){
            NSMutableString *a = [[NSMutableString  alloc] initWithString:name];
            
            //    NSLog(@" \n a:  %@ \n",a);
            
            [a replaceCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
            return a;

        }
    }
        return @"登录/注册";
    
}
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (BOOL)isPureInt:(NSString*)string
{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
+ (BOOL)isPureFloat:(NSString*)string
{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

+(NSString *)reviseString:(NSString* )string
{
    
    /* 直接传入精度丢失有问题的Double类型*/
    double conversionValue        = (double)[string floatValue];
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
    
}
+(NSMutableAttributedString *)setStringtext:(NSString *)detailStr font:(CGFloat)font MakeRangeLeft:(NSUInteger)rangeleft MakeRangeRight:(NSUInteger)rangeRight
{
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:detailStr];
    [abs beginEditing];
    //  字体大小
    [abs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(rangeleft, rangeRight)];
    //字体颜色
//    [abs addAttribute:NSForegroundColorAttributeName value:color  range:NSMakeRange( rangeleft, rangeRight)];
    //下划线
    // [abs addAttribute:NSUnderlineStyleAttributeName  value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, detailStr.length)];
//        lable.attributedText = abs;
    return abs;
}

+(NSString *)imageWebpInterceptionURL:(NSString *)imgUrl
{
    NSString *str;
    if ([imgUrl rangeOfString:@"&type=webp_270x190"].location != NSNotFound ) {
        str = [imgUrl stringByReplacingOccurrencesOfString:@"&type=webp_270x190" withString:@""];
    }
    else if([imgUrl rangeOfString:@"%26type%3dwebp_270x190"].location != NSNotFound)
    {
        str = [imgUrl stringByReplacingOccurrencesOfString:@"%26type%3dwebp_270x190" withString:@""];
    }else{
        str = imgUrl;
    }
    
    return str;
}

+(NSString *)initWithUrl:(NSString *)url stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
{
    NSString *str;
    if ([url rangeOfString:target].location != NSNotFound ) {
        str = [url stringByReplacingOccurrencesOfString:target withString:replacement];
    }else{
        str = url;
    }
    return str;
    
}



//通过图片Data数据第一个字节 来获取图片扩展名

+ (NSString *)contentTypeForImageData:(NSData *)data
{
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
        case 0x52:
            
            if ([data length] < 12) {
                
                return nil;
                
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                
                return @"webp";
                
            }
            
            return nil;
            
    }
    
    return nil;
    
}
+ (NSString *)decodeFromPercentEscapeString: (NSString *) urlStr
{
    NSMutableString *outputStr = [NSMutableString stringWithString:urlStr];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,
                                                      [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
