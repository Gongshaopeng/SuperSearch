//
//  Config.h
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

// DEFAULTS key －宏定义
#ifndef Defaults_h
#define Defaults_h


//===========================================================================================================
//是否允许打开外部软件 0:不允许 1:允许一次 2:始终允许
#define __DEF_KEY_OPENAPP @"open_app_def"
//记录上一次的Url 比对是否一致
#define __DEF_KEY_APPSTOREURL @"APPStore_Url"
//头部导航栏字体颜色
#define __DEF_KEY_statusBarStyle @"statusBarStyle"
#define __DEF_KEY_SearchsTatusBarStyle @"SearchsTatusBarStyle"

//隐藏导航头视图
#define __DEF_KEY_NaviHideYES   @"NaviHideYES"

//============================================ 数据库名 Manager ===============================================================

#define __Manager_gsCache__  @"GSCACHEHISTORY.db"
#define __Manager_gsConfig__  @"ConfigManager.db"



//============================================ 设置 KeyChain 密钥 ===============================================================

#define __kKeyChainServer__              @"com.SuperSearch"
#define __kKeyChainUUID__                @"com.SuperSearch.uuid"
#define __kKeyChainAccountToken__        @"com.SuperSearch.token"
#define __kKeyChainAccountPassword__     @"com.SuperSearch.password"


#endif /* Night_h */
