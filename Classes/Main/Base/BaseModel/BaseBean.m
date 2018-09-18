//
//  BaseBean.m
//  TestModel
//
//  Created by allen on 16/1/12.
//  Copyright © 2016年 com.juwang.model. All rights reserved.
//

#import "BaseBean.h"

@implementation BaseBean

+(id) instanceFromJSONDictionary:(NSDictionary*) dic{
    
    return nil;
}

//在所有的属性前面添加特殊字段 Optional
//@property(nonatomic,strong)NSString<Optional> *idOne;

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

//使用kvc时，如果代码中的key值不存在，会抛出异常，可以在类中通过重写它提供下面的这个方法来解决这个问题。
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

@end
