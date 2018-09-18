//
//  ThirdPartyModel.m
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/9/22.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import "ThirdPartyModel.h"

@implementation ThirdPartyModel

//使用kvc时，如果代码中的key值不存在，会抛出异常，可以在类中通过重写它提供下面的这个方法来解决这个问题。
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(id) instanceFromJSONNSArray:(NSArray*)arr
{
    id instance;
    if(arr != nil){

    for (NSDictionary * dict in arr) {
        GSLog(@"%@ \n %@",[dict valueForKey:@"url_short"],[dict valueForKey:@"url_long"]);
    }
//        instance = [[self alloc] initWithDictionary:arr error:nil];

    }
    return instance;
}

+(id) instanceFromJSONDictionary:(NSDictionary*) dic{
    
    id instance;
    //
    if(dic != nil){
       
            instance = [[self alloc] initWithDictionary:dic error:nil];


    

      
//        if (![[dic valueForKey:@"Data"] isEqual:[NSNull null]] || [dic valueForKey:@"Data"] != nil ) {
//            if([[dic valueForKey:@"Data"] isKindOfClass:[NSString class]]){
//                [dic setValue:@[] forKey:@"Data"];
//            }
//            if([[dic valueForKey:@"Data"] isKindOfClass:[NSDictionary class]]){
//                
//                [dic setValue:@[] forKey:@"Data"];
//                
//            }
//        }
        
        
    }
 
    return instance;
}

@end
