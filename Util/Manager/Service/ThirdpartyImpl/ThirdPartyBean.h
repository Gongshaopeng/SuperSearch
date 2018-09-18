//
//  ThirdPartyBean.h
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/9/22.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdPartyBean : JSONModel
+ (instancetype)modelWithDictionary:(NSDictionary *)data;
+ (instancetype)standardBean;

@property (nonatomic,strong) NSDictionary *data;
@end
