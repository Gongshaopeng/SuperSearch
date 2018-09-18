//
//  IphoneType.h
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/11/16.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//


#define isiPhone2Gor3Gor3Gs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone4or4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone5or5sor5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6or6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6plusor6splus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
//首先导入头文件信息
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <sys/sysctl.h>
#include <net/if_dl.h>

#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface IphoneType : NSObject

+ (instancetype)phone;

#define mark - 类方法

//!<手机型号
+(NSString *)iphoneType;
//设备唯一标识符
+(NSString *)identifierStr;
+(NSString *)getUUID;
+(NSString *)IDFA;
+(BOOL)isIdfa;
//唯一每次不相同的Id
+(NSString *)getTid;

//手机别名： 用户定义的名称
+(NSString *)userPhoneName;
//设备名称
+(NSString*)deviceName;
//手机系统版本
+(NSString *)phoneVersion;
//手机型号
+(NSString *)phoneModel;
//地方型号  （国际化区域名称）
+(NSString *)localPhoneModel;
//info配置文件
+(NSDictionary *)infoDictionary;
// 当前应用软件版本  比如：1.0.1
+(NSString *)appCurVersion;
// 当前应用版本号码   int类型
+(NSString *)appCurVersionNum;
//自定义设置UserAgent
+ (NSString *)defaultUserAgentString;
//获取IPV4 地址
+(NSString *)getIPAddress:(BOOL)preferIPv4;
//获取Mac 地址
+ (NSString *)getMacAddress;
//获取运营商名称
+(NSString *)getcarrierName;
//获取展示像素PPI
+(NSString *)IphonePPI;
//判断是否是IphoneX
+(NSInteger)isPhoneX;

+(NSDictionary *)getInFoSchemes;

//http://itunes.apple.com/cn/lookup?id=
@end
