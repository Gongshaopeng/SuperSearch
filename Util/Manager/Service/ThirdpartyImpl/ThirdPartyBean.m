//
//  ThirdPartyBean.m
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/9/22.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import "ThirdPartyBean.h"

@implementation ThirdPartyBean

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)data{
    ThirdPartyBean *model = [ThirdPartyBean new];
    model.data = data?:@{};
    return model;
}
+ (instancetype)standardModel{
    return [ThirdPartyBean modelWithDictionary:nil];
}
@end
