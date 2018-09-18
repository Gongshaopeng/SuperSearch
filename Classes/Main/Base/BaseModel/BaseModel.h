//
//  BaseModel.h
//  如意夺宝
//
//  Created by jianjie on 16/4/13.
//  Copyright © 2016年 com.juwang.rydb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseModel : JSONModel

+(id) instanceFromJSONNSArray:(NSArray*)arr;

+(id) instanceFromJSONDictionary:(NSDictionary*) dic;

@end
