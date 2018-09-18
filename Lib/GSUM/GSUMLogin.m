//
//  GSUMLogin.m
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/4/26.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import "GSUMLogin.h"

@implementation GSUMLogin

+(GSUMLogin *)setLogin
{
    static GSUMLogin *Share=nil;
    static dispatch_once_t once;
    dispatch_once(&once ,^
                  {
                      if (Share==nil)
                      {
                          Share=[[GSUMLogin alloc]init];
                      }
                  });
    return Share;
}
-(id)init{
    if (self = [super init]) {
        [self setIsQQ:NO];
        [self setIsWx:NO];
        [self setIsTB:NO];

    }
    return self;
}

-(void)setIsQQ:(BOOL)isQQ{
    if ([QQApiInterface isQQInstalled]) {
        _isQQ = YES;
    }else{
        _isQQ = NO;
    }
}
-(void)setIsWx:(BOOL)isWx{
    if ([WXApi isWXAppInstalled]) {
        _isWx = YES;
    }else{
        _isWx = NO;
    }
}
-(void)setIsTB:(BOOL)isTB{
    if ([GOpenUrl isAppOpenStr:@"tbopen://"]) {
        _isTB = YES;
    }else{
        _isTB = NO;
    }
}
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType{

    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {

        if(result != nil){

            UMSocialUserInfoResponse *resp = result;

            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            NSLog(@" uid: %@", resp.uid);
            NSLog(@" openid: %@", resp.openid);
            NSLog(@" accessToken: %@", resp.accessToken);
            NSLog(@" refreshToken: %@", resp.refreshToken);
            NSLog(@" expiration: %@", resp.expiration);

            // 用户数据
            NSLog(@" name: %@", resp.name);
            NSLog(@" iconurl: %@", resp.iconurl);
            NSLog(@" gender: %@", resp.gender);

        }
    }];

}

@end
