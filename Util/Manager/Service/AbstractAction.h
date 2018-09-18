//
//  AbstractAction.h
//  JWBox
//
//  Created by allen on 15/12/21.
//  Copyright © 2015年 com.juwang.box. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractAction : NSObject

/**
 *  @author Allen, 15-12-22 14:12:51
 *
 *  @brief 生成带Sign参数的请求对象.
 *
 *  @param param 请求对象.
 *
 *  @return 返回带Sign参数的请求对象.
 */
- (NSDictionary *)SignParam:(NSDictionary*) param;

@end
