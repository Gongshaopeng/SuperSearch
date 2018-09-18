//
//  ConfigModel.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/5/15.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigModel : NSObject

@property (nonatomic,copy) NSString * configvalue;//!<数据
@property (nonatomic,copy) NSString * configkey;//!<类型
@property (nonatomic,copy) NSString * updateTime;//!<更新时间

@end
