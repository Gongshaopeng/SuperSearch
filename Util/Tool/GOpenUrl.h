//
//  GOpenUrl.h
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/7/13.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOpenUrl : NSObject

//系统通知
+(void)openNotification;
//照片与相机
+(void)openPhotos;
//跳转到设置
+(void)openSetWIFI;
//打开系统设置主界面
+(void)openSetCenter;

+(void)setMaque;

//是否存在
+(BOOL)isAppOpenStr:(NSString *)str;
+(BOOL)isAppOpenURL:(NSURL *)url;

//跳转
+(BOOL)newOpenStr:(NSString *)str;
+(BOOL)newOpenURL:(NSURL *)url;

@end
