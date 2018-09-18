//
//  Product Define.h
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

#ifndef Product_Define_h
#define Product_Define_h

//通知宏定义

//cell重用标志宏定义

//其他宏定义
//#define DEBUG


//#ifdef DEBUG
//#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#else
//#define NSLog(format, ...)
//#endif

#ifdef DEBUG
#define GSLog(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define GSLog(format, ...)
#endif

//#ifdef DEBUG
//#define GSLog(format, ...)
//#else
//#define GSLog(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#endif



#define APPDELE ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define DEFAULTS ((NSUserDefaults *)[NSUserDefaults standardUserDefaults])
#define NOTIFCATIONCENTER ((NSNotificationCenter *)[NSNotificationCenter defaultCenter])

// block self
#define __kWeakSelf__ __weak typeof(self) weakSelf = self;
#define __kStrongSelf__ __weak typeof(self) StrongSelf = self;

// device system verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define __kSearchText__ @"searchText"

// HUD remind content
#define kRequestFailedHUD @"网络不给力"

//取view的坐标及长宽
#define W(view)    view.frame.size.width
#define H(view)    view.frame.size.height
#define X(view)    view.frame.origin.x
#define Y(view)    view.frame.origin.y

// RGB颜色
#define RGBA_COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

//window的宽度
#define APP_WIDTH [UIScreen mainScreen].bounds.size.width

//window的高度
#define APP_HEIGHT [UIScreen mainScreen].bounds.size.height

//验证邮箱
#define PREDICATE_EMAIL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}"
//验证用户名
#define PREDICATE_USERNAME @"^[u4e00-u9fa5A-Za-z]{6,16}"
//验证密码(?!^\\d+$)不能全是数字(?!^[a-zA-Z]+$)不能全是字母(?!^[_#@]+$)不能全是符号（这里只列出了部分符号，可自己增加，有的符号可能需要转义）.{8,}长度不能少于8位
#define PREDICATE_USERPASS @"(?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$).{8,16}"

//userDefaults取值
#define USER_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

//userDefaults存值
#define USER_SETOBJ(obj,key) [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];\
[[NSUserDefaults standardUserDefaults]synchronize]

//播放音乐
#define __palyer(name,count) [[UUAVAudioPlayer sharedInstance] playSongWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"m4a"]]];\
[[UUAVAudioPlayer sharedInstance] setRest:count]

//停止播放音乐
#define __stopSounds [[UUAVAudioPlayer sharedInstaznce] stopSound]

#define __kRegExNumber__ @"^[0-9]*$"//纯数字

#define SCREEN_KEY_WINDOW [UIApplication sharedApplication].keyWindow



//字符串是否为空

#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//数组是否为空

#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//字典是否为空

#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//是否是空对象

#define kObjectIsEmpty(_object) (_object == nil \|| [_object isKindOfClass:[NSNull class]] \|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



#endif /* Product_Define_h */
