//
//  BaseBean.h
//  TestModel
//
//  Created by allen on 16/1/12.
//  Copyright © 2016年 com.juwang.model. All rights reserved.
//

#import "JSONModel.h"

@interface BaseBean : JSONModel

+(id) instanceFromJSONDictionary:(NSDictionary*) dic;

@end
