//
//  GOpenUrl.m
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/7/13.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import "GOpenUrl.h"

@implementation GOpenUrl


+(void)openNotification
{
//    [KSAlertView showWithTitle:@"通知未开启" message1:@"请在iPhone的\"设置-通知-麻雀浏览器\"中允许通知" cancelButton:@"取消" customButton:@"确定" cancelAction:^(UIButton *cancelBtn) {
//
//    } commitAction:^(UIButton *button) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
            [self newOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else{
            NSURL * rootCenter = [NSURL URLWithString:[self newUrl:@"NOTIFICATIONS_ID"]];
            [self newOpenURL:rootCenter];
        }
//    }];
}
+(void)openPhotos
{
//    [KSAlertView showWithTitle:@"无法使用相册" message1:@"请在iPhone的\"设置-隐私-照片\"中允许访问照片" cancelButton:@"取消" customButton:@"确定" cancelAction:^(UIButton *cancelBtn) {
//
//    } commitAction:^(UIButton *button) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
            [self newOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else{
            NSURL * rootCenter = [NSURL URLWithString:[self newUrl:@"privacy&path=PHOTOS"]];
            [self newOpenURL:rootCenter];
        }
//    }];

   
}

+(void)openSetWIFI
{
    NSURL * rootCenter = [NSURL URLWithString:[self newUrl:@"WIFI"]];
    [self newOpenURL:rootCenter];
}

+(void)openSetCenter{
//    [KSAlertView showWithTitle:@"无法使用权限" message1:@"请在iPhone的\"设置-隐私—\"中允许访问权限" cancelButton:@"取消" customButton:@"确定" cancelAction:^(UIButton *cancelBtn) {
//
//    } commitAction:^(UIButton *button) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
            [self newOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else{
            NSURL * rootCenter = [NSURL URLWithString:[self newUrl:@"INTERNET_TETHERING"]];
            [self newOpenURL:rootCenter];
        }
//    }];

}

+(void)setMaque
{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
        [self newOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }else{
        NSURL * rootCenter = [NSURL URLWithString:[self newUrl:@"NOTIFICATIONS_ID"]];
        [self newOpenURL:rootCenter];
    }
}


+(NSString *)newUrl:(NSString *)url
{
    NSString * str ;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
        str = [NSString stringWithFormat:@"App-Prefs:root=%@",url];
    }else{
        str = [NSString stringWithFormat:@"prefs:root=%@",url];
    }
    return str;
}



+(BOOL)isAppOpenStr:(NSString *)str
{
    return [self isAppOpenURL:[NSURL URLWithString:str]];
}

+(BOOL)newOpenStr:(NSString *)str
{
    return  [self newOpenURL:[NSURL URLWithString:str]];
}

+(BOOL)isAppOpenURL:(NSURL *)url
{
    if( [[UIApplication sharedApplication] canOpenURL:url] ) {
       return YES;
    }
    return NO;
}

+(BOOL)newOpenURL:(NSURL *)url
{
    if( [self isAppOpenURL:url] ) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
        return YES;
    }else{
        return NO;
    }
}
/*
 
 
 About — prefs:root=General&path=About
 
 Accessibility — prefs:root=General&path=ACCESSIBILITY
 
 Airplane Mode On — prefs:root=AIRPLANE_MODE
 
 Auto-Lock — prefs:root=General&path=AUTOLOCK
 
 Brightness — prefs:root=Brightness
 
 Bluetooth — prefs:root=General&path=Bluetooth
 
 Date & Time — prefs:root=General&path=DATE_AND_TIME
 
 FaceTime — prefs:root=FACETIME
 
 General — prefs:root=General
 
 Keyboard — prefs:root=General&path=Keyboard
 
 iCloud — prefs:root=CASTLE
 
 iCloud Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 
 International — prefs:root=General&path=INTERNATIONAL
 
 Location Services — prefs:root=LOCATION_SERVICES
 
 Music — prefs:root=MUSIC
 
 Music Equalizer — prefs:root=MUSIC&path=EQ
 
 Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
 
 Network — prefs:root=General&path=Network
 
 Nike + iPod — prefs:root=NIKE_PLUS_IPOD
 
 Notes — prefs:root=NOTES
 
 Notification — prefs:root=NOTIFICATIONS_ID
 
 Phone — prefs:root=Phone
 
 Photos — prefs:root=Photos
 
 Profile — prefs:root=General&path=ManagedConfigurationList
 
 Reset — prefs:root=General&path=Reset
 
 Safari — prefs:root=Safari
 
 Siri — prefs:root=General&path=Assistant
 
 Sounds — prefs:root=Sounds
 
 Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
 
 Store — prefs:root=STORE
 
 Twitter — prefs:root=TWITTER
 
 Usage — prefs:root=General&path=USAGE
 
 VPN — prefs:root=General&path=Network/VPN
 
 Wallpaper — prefs:root=Wallpaper
 
 Wi-Fi — prefs:root=WIFI
 
 
 @"prefs:root=WIFI",//打开WiFi
 @"prefs:root=Bluetooth", //打开蓝牙设置页
 @"prefs:root=NOTIFICATIONS_ID",//通知设置
 @"prefs:root=General",  //通用
 @"prefs:root=DISPLAY&BRIGHTNESS",//显示与亮度
 @"prefs:root=Wallpaper",//墙纸
 @"prefs:root=Sounds",//声音
 @"prefs:root=Privacy",//隐私
 @"prefs:root=STORE",//存储
 @"prefs:root=NOTES",//备忘录
 @"prefs:root=SAFARI",//Safari
 @"prefs:root=MUSIC",//音乐
 @"prefs:root=Photos",//照片与相机
 @"prefs:root=CASTLE"//iCloud
 @"prefs:root=FACETIME",//FaceTime
 @"prefs:root=LOCATION_SERVICES",//定位服务
 @"prefs:root=Phone",//电话
 */

@end
