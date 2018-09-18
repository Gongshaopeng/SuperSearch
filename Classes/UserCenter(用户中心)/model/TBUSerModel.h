//
//  TBUSerModel.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/2.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBUSerModel : NSObject
+ (instancetype)userModel;

@property (nonatomic, copy) NSString *login;//!<登录状态 0:未登录 1:登录

/** 昵称 */
@property (nonatomic, copy, readonly) NSString *nick;
/** 头像地址 */
@property (nonatomic, copy, readonly) NSString *avatarUrl;

@property (nonatomic, copy, readonly) NSString *openId;
@property (nonatomic, copy, readonly) NSString *openSid;
@property (nonatomic, copy, readonly) NSString *topAccessToken;
@property (nonatomic, copy, readonly) NSString *topAuthCode;

@end
