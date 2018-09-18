//
//  RequestModel.m
//  如意夺宝
//
//  Created by allen on 16/4/9.
//  Copyright © 2016年 com.juwang.rydb. All rights reserved.
//

#import "RequestModel.h"

@interface RequestModel()

@end

@implementation RequestModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = @{};
//        self.v = @"2.0";
//        self.app_key = __kAppKey__;
//        self.format = @"json";
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)data appType:(NSString *)apptype{
    RequestModel *model = [RequestModel new];
    model.data = data?:@{};
    model.apptype = apptype;
    return model;
}
+ (instancetype)modelWithDictionary:(NSDictionary *)data{
    RequestModel *model = [RequestModel new];
    model.data = data?:@{};
    model.apptype = @"0";
    return model;
}
+ (instancetype)standardModel{
    return [RequestModel modelWithDictionary:nil];
}
@end
