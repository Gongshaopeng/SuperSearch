//
//  NSDictionary+GSDictionary.m
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/6/8.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import "NSDictionary+GSDictionary.h"

@implementation NSDictionary (GSDictionary)
/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+(NSMutableDictionary *)getURLParameters:(NSString *)urlStr
{
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}


+ (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
            
        } else {
            //model
            if (![name isEqualToString:@"data"]) {
                [dic setObject:value forKey:name];
            }
        }
    }
    free(propertyList);

    return [dic copy];
}

+(NSMutableDictionary *)returnToDictionaryWithModel:(NSObject *)object
{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; i++) {
        const char *name = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [object valueForKey:propertyName];
        if (propertyValue) {
            if (![propertyName isEqualToString:@"data"]) {
            [userDic setObject:propertyValue forKey:propertyName];
            }
        }
    }
    free(properties);
    
    return userDic;
    
}



@end
