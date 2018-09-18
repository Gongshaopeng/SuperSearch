//
//  RequestModel.h
//  如意夺宝
//
//  Created by allen on 16/4/9.
//  Copyright © 2016年 com.juwang.rydb. All rights reserved.
//

#import "JSONModel.h"

@interface RequestModel : JSONModel

+ (instancetype)modelWithDictionary:(NSDictionary *)data appType:(NSString *)apptype;
+ (instancetype)modelWithDictionary:(NSDictionary *)data;
+ (instancetype)standardModel;

@property (nonatomic,strong) NSDictionary *data;


//公共请求参数
@property (nonatomic,strong) NSString *method;//!<API接口
@property (nonatomic,strong) NSString *app_key;
@property (nonatomic,strong) NSString *target_app_key;
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *session;
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) NSString *format;
@property(nonatomic, strong) NSString *v;
@property (nonatomic,strong) NSString *partner_id;
@property (nonatomic,strong) NSString *simplify;
@property (nonatomic,strong) NSString *apptype;


//请求参数
@property(nonatomic, strong) NSString *fields;//!<必填
@property(nonatomic, strong) NSString *q;//!<查询词
@property(nonatomic, strong) NSString *cat;


@end
