//
//  BaseModel.m
//  如意夺宝
//
//  Created by jianjie on 16/4/13.
//  Copyright © 2016年 com.juwang.rydb. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

//使用kvc时，如果代码中的key值不存在，会抛出异常，可以在类中通过重写它提供下面的这个方法来解决这个问题。
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(id) instanceFromJSONDictionary:(NSDictionary*) dic{
    
    id instance;
//
    if(dic != nil){
//        GSLog(@"%@ %@\n%@",dic,[dic valueForKey:@"Data"],[dic valueForKey:@"Message"]);

        if (![[dic valueForKey:@"Datas"] isEqual:[NSNull null]] || [dic valueForKey:@"Datas"] != nil ) {
            if([[dic valueForKey:@"Datas"] isKindOfClass:[NSString class]]){
                [dic setValue:@[] forKey:@"Datas"];
                }
            if([[dic valueForKey:@"Datas"] isKindOfClass:[NSDictionary class]]){
                GSLog(@"%@ ----",[dic valueForKey:@"Datas"] );
                NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
                for (NSString* dicKey in [[dic valueForKey:@"Datas"] allKeys]) {
                    NSString* dicValue = [[dic valueForKey:@"Datas"] valueForKey:dicKey];
                  
                        [userDic setObject:dicValue forKey:dicKey];
                    
                }

                [dic setValue:@[userDic] forKey:@"Datas"];

            }
        }
//        if([[dic valueForKey:@"Data"] integerValue] != 0){
            instance = [[self alloc] initWithDictionary:dic error:nil];
//        }
        
    }

//    }
    return instance;
}

//+(id) instanceFromJSONSArray:(NSArray *) arr{
//    id instance;
//    if(![arr isKindOfClass:[NSArray class]])
//    {
//        
//    }
//    instance = [[self alloc] initWithDictionary:arr error:nil];
//
//    return instance;
//
//}
@end
