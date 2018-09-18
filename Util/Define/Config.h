//
//  Config.h
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

//为主要的ui宏定义
#ifndef Config_h
#define Config_h

#define IS_IOS_8 (([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8) ? YES : NO)

#define IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define IOS8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define IOS9_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending)
#define IOS10_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"10.0"] != NSOrderedAscending)

//判断 iOS 9 或更高的系统版本
#define IOS_VERSION_9_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=9.0)? (YES):(NO))
#define IOS_VERSION_11_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=11.0)? (YES):(NO))

#define IOS_VERSION_10 (NSFoundationVersionNumber >= NSFoundationVersionNumber10_0)?YES:NO

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

/// 高度系数 812.0 是iPhoneX的高度尺寸，667.0表示是iPhone 8 的高度，如果你觉的它会变化，那我也很无奈
#define kWJHeightCoefficient (kScreenHeight == 812.0 ? 667.0/667.0 : kScreenHeight/667.0)

#define SafeAreaTopHeight (kScreenHeight == 812.0 ? 88 : 64)
/// 底部宏，吃一见长一智吧，别写数字了
#define SafeAreaBottomHeight (kScreenHeight == 812.0 ? 34 : 0)

#define topCenterY_y (kScreenHeight == 812.0 ? __kNewSize(32) : __kNewSize(12))

//获取系统版本
#define IOS_VERSION ［[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ［UIDevice currentDevice] systemVersion]
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]


#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define NavigationBarHeight (kScreenHeight == 812.0 ? __kNewSize(88*2) : __kNewSize(64*2))
#define __TabBarH__ (kScreenHeight == 812.0 ?__kNewSize(108) :__kNewSize(88))



#define __kScreenHeight__ [[UIScreen mainScreen] bounds].size.height
#define __kScreenWidth__ [[UIScreen mainScreen] bounds].size.width

#define __kNavigationBarHeight__ NavigationBarHeight
#define __kContentHeight__ (__kScreenHeight__-__kNavigationBarHeight__-__kTabBarHeight__)
#define __kOriginalHeight__ (__kScreenHeight__-__kNavigationBarHeight__)
#define __kBarHeight__ (__kScreenHeight__-__kTabBarHeight__)
#define __kTabBarFrame__ CGRectMake(0, __kScreenHeight__-__kTabBarHeight__, __kScreenWidth__, __kTabBarHeight__)
#define __kTabBarHeight__ __TabBarH__
#define __kTopViewHeight__ __kNewSize(330-16)
#define __kTopNaviBtnHeight__ __kNewSize(300)
#define __kTopHeight__ (__kTopViewHeight__+__kTopNaviBtnHeight__)

// print size
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

// get color
#define UIColorFromRGB(R,G,B)		[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#define UIAlplaColorFromRGB(R,G,B,A)		[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#define __colorTopHome__  @"@#de3031"


// get font
#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define UIFontOfSize(__PARA)    [UIFont systemFontOfSize:__PARA]
#define UIBoldFontOfSize(__PARA)    [UIFont boldSystemFontOfSize:__PARA]
#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];


//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock); 
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"
//===========================================================================================================

#define HomeTopScrollHeight __kNewSize(336)

#define HomeSection_one_Height __kNewSize(192)

#define HomeFoot_Height __kNewSize(76)


//===========================================================================================================

#define __DEFLoginTimeKey__ @"LoginTimeKey"//!<登陆时间
//#define __DEFLoginTimeKey__ @"LoginTimeKey"//!<登陆时间

#endif /* Config_h */
