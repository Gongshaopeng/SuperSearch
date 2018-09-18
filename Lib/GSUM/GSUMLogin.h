//
//  GSUMLogin.h
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/4/26.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <UMShare/UMShare.h>
#import "WXApi.h"


@interface GSUMLogin : NSObject

+(GSUMLogin *)setLogin;

@property (nonatomic,assign) BOOL isQQ;
@property (nonatomic,assign) BOOL isWx;
@property (nonatomic,assign) BOOL isTB;

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType;

@end
