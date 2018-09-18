//
//  DCNotificationCenterName.h
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSNotificationCenterName : NSObject

#pragma mark - 项目中所有通知

/** 登录成功选择控制器通知 */
UIKIT_EXTERN NSString *const LOGINSELECTCENTERINDEX;

/** 添加购物车或者立即购买通知 */
UIKIT_EXTERN NSString *const SELECTCARTORBUY;

/** 展现顶部自定义工具条View通知 */
UIKIT_EXTERN NSString *const SHOWTOPTOOLVIEW;
/** 隐藏顶部自定义工具条View通知 */
UIKIT_EXTERN NSString *const HIDETOPTOOLVIEW;


/** 分享弹出通知 */
UIKIT_EXTERN NSString *const SHAREALTERVIEW;



/** 监听剪切板弹窗通知_展示弹窗 */
UIKIT_EXTERN NSString *const CLIPBOARDREQUESTPOP;
/** 监听剪切板弹窗通知_弹窗消失 */
UIKIT_EXTERN NSString *const CLIPBOARDREQUESTPOPDismiss;
/** 监听剪切板弹窗通知_搜同款 */
UIKIT_EXTERN NSString *const CLIPBOARDREQUESTPOPSearch ;
/** 监听剪切板弹窗通知_去购买 */
UIKIT_EXTERN NSString *const CLIPBOARDREQUESTPOPGoods ;

/** 监听退出到后台通知 */
UIKIT_EXTERN NSString *const ENTERBACKGRUOUND;



@end



