//
//  AbstractAction.m
//  JWBox
//
//  Created by allen on 15/12/21.
//  Copyright © 2015年 com.juwang.box. All rights reserved.
//

#import "AbstractAction.h"
#import "NSString+SHA1Addiction.h"
//#import "ResponseDto.h"

@implementation AbstractAction

- (NSDictionary *)SignParam:(NSDictionary*) param{
    //加入系统参数
    NSMutableDictionary* mDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [mDic setObject:__kInterfaceVer__ forKey:@"v"];
    [mDic setObject:__kAppKey__ forKey:@"app_key"];
    [mDic setObject:[NewTimeTool getTimeNow] forKey:@"timestamp"];
    [mDic setObject:@"md5" forKey:@"sign_method"];
    [mDic setObject:@"json" forKey:@"format"];

    #ifdef URLDEBUG
//    [mDic setObject:@"" forKey:@"debug"];
    #else
    #endif
    
    //key排序
    NSMutableArray* dicKeyMArr = [[mDic allKeys] mutableCopy];
    NSArray* sortedDicKeyMArr = [dicKeyMArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString* objStr1 = (NSString*) obj1;
        NSString* objStr2 = (NSString*) obj2;
        return [objStr1 compare:objStr2];
    }];
    //拼接字符串
    NSMutableString* CRCStr = [NSMutableString new];
    for (NSString* dicKey in sortedDicKeyMArr) {
            NSString* keyValueStr = [NSString stringWithFormat:@"%@%@",dicKey,[mDic valueForKey:dicKey]];
            [CRCStr appendFormat:@"%@",keyValueStr];
    }
    NSString * secret = [NSString stringWithFormat:@"%@%@%@",__kAppSecret__,CRCStr,__kAppSecret__];

    NSString* SHA1Str = [NSString gsMD5:secret];
    
    [mDic setValue:[SHA1Str uppercaseString] forKey:@"sign"];
    
    return mDic;
}

@end
