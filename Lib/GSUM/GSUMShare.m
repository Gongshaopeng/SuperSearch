//
//  GSUMShare.m
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/11/24.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import "GSUMShare.h"

@implementation GSUMShare

+(GSUMShare *)setShare
{
    static GSUMShare *Share=nil;
    static dispatch_once_t once;
    dispatch_once(&once ,^
                  {
                      if (Share==nil)
                      {
                          Share=[[GSUMShare alloc]init];
                      }
                  });
    return Share;
}
-(id)init{
if (self = [super init]) {
    //打开调试日志
//    UMSocialManager * share = [UMSocialManager defaultManager];
    [[UMSocialManager defaultManager] openLog:YES];

    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:__UMID_APP_KEY__];

    // 获取友盟social版本号
    //    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);

    //各平台的详细配置
    //设置微信的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:__UMID_WX_KEY__ appSecret:__UMID_WX_SECRET__ redirectURL:__UMID_WX_REDIRECTURL__];

    //设置分享到QQ互联的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:__UMID_QQ_KEY__  appSecret:__UMID_QQ_SECRET__ redirectURL:__UMID_QQ_REDIRECTURL__];

    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"KEYb5GF54nvapZjYiyB"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
//    //设置新浪的appId和appKey
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:__UMID_SINA_KEY__  appSecret:__UMID_SINA_SECRET__ redirectURL:__UMID_SINA_REDIRECTURL__];
//
    }
    return self;
}

@end
