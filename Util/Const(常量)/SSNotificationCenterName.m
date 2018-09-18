
//
//  DCNotificationCenterName.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "SSNotificationCenterName.h"

@implementation SSNotificationCenterName


/** 登录成功选择控制器通知 */
NSString *const LOGINSELECTCENTERINDEX = @"LOGINSELECTCENTERINDEX";

/** 展现顶部自定义工具条View通知 */
NSString *const SHOWTOPTOOLVIEW = @"SHOWTOPTOOLVIEW";
/** 隐藏顶部自定义工具条View通知 */
NSString *const HIDETOPTOOLVIEW = @"HIDETOPTOOLVIEW";


/** 监听剪切板弹窗通知_展示弹窗 */
NSString *const CLIPBOARDREQUESTPOP = @"CLIPBOARDREQUESTPOP";
/** 监听剪切板弹窗通知_弹窗消失 */
NSString *const CLIPBOARDREQUESTPOPDismiss = @"CLIPBOARDREQUESTPOPDismiss";
/** 监听剪切板弹窗通知_搜同款 */
NSString *const CLIPBOARDREQUESTPOPSearch = @"CLIPBOARDREQUESTPOPSearch";
/** 监听剪切板弹窗通知_去购买 */
NSString *const CLIPBOARDREQUESTPOPGoods = @"CLIPBOARDREQUESTPOPGoods";

/** 监听退出到后台通知 */
NSString *const ENTERBACKGRUOUND = @"ENTERBACKGRUOUND";
@end
