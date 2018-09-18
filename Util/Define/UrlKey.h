//
//  UrlKey.h
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

#ifndef UrlKey_h
#define UrlKey_h

#ifdef IOS_VERSION_10

#else
　　//...demo块2...
#endif


//以下为举例宏
//主要的url宏
#define URL_Tag_  3

//HTTPS请求地址
#define URLHTTPSDEBUG URL_Tag_

//正式环境
#if URLHTTPSDEBUG == 1
#define __kBase_Https_Url__    @"https://eco.taobao.com/router/rest"

//沙箱外网
#elif URLHTTPSDEBUG == 2
//#define __kBase_Https_Url__    @"https://gw.api.tbsandbox.com/router/rest"
#define __kBase_Https_Url__    @"https://testtbk.zhufushuo.com/api/Taobao_Tbk"

//海外环境
#elif URLHTTPSDEBUG == 3
#define __kBase_Https_Url__    @"https://tbk.zhufushuo.com/api/Taobao_Tbk"


#endif

#define __kTEST_IP_Https_Url__    @"http://172.25.40.60:8002/api/Taobao_Tbk"

//=====================================================================================================================

//HTTP请求地址

//基础网络
#define URLHTTPDEBUG URL_Tag_

//正式环境
#if URLHTTPDEBUG == 1
#define __kBase_Http_Url__    @"http://gw.api.taobao.com/router/rest"

//沙箱外网
#elif URLHTTPDEBUG == 2
//#define __kBase_Http_Url__    @"http://gw.api.tbsandbox.com/router/rest"
#define __kBase_Http_Url__    @"http://testtbk.zhufushuo.com"

//海外环境
#elif URLHTTPSDEBUG == 3
#define __kBase_Http_Url__    @"http://api.taobao.com/router/rest"

#endif
//=====================================================================================================================

//基础网络
#define URLAPIBUG 2

//淘宝客API
#if URLAPIBUG == 1

#define __API_Item_get__                   @"taobao.tbk.item.get" //!<淘宝客商品查询
#define __API_itemcats_get__               @"taobao.itemcats.get" //!<cat
#define __API_Item_convert__               @"taobao.tbk.item.convert" //!<淘宝客商品链接转换
#define __API_Item_recommend_get__         @"taobao.tbk.item.recommend.get"//!<淘宝客商品关联推荐查询
#define __API_Item_info_get__              @"taobao.tbk.item.info.get"//!<淘宝客商品详情（简版）
#define __API_shop_get__                   @"taobao.tbk.shop.get"//!<淘宝客店铺查询
#define __API_shop_recommend_get__         @"taobao.tbk.shop.recommend.get"//!<淘宝客店铺关联推荐查询
#define __API_rebate_auth_get__            @"taobao.tbk.rebate.auth.get"//!<淘宝客返利授权查询
#define __API_rebate_order_get__           @"taobao.tbk.rebate.order.get"//!<淘宝客返利订单查询
#define __API_uatm_event_get__             @"taobao.tbk.uatm.event.get"//!<枚举正在进行中的定向招商的活动列表
#define __API_uatm_event_item_get__        @"taobao.tbk.uatm.event.item.get"//!<获取淘宝联盟定向招商的宝贝信息
#define __API_uatm_favorites_item_get__    @"taobao.tbk.uatm.favorites.item.get"//!<获取淘宝联盟选品库的宝贝信息
#define __API_uatm_favorites_get__         @"taobao.tbk.uatm.favorites.get"//!<获取淘宝联盟选品库列表
#define __API_ju_tqg_get__                 @"taobao.tbk.ju.tqg.get"//!<淘抢购api
#define __API_spread_get__                 @"taobao.tbk.spread.get"//!<物料传播方式获取
#define __API_dg_Item_coupon_get__         @"taobao.tbk.dg.item.coupon.get"//!<好券清单API【导购】
#define __API_coupon_get__                 @"taobao.tbk.coupon.get"//!<阿里妈妈推广券信息查询
#define __API_tpwd_create__                @"taobao.tbk.tpwd.create"//!<淘宝客淘口令
#define __API_content_get__                @"taobao.tbk.content.get"//!<淘客媒体内容输出
#define __API_adzone_create__              @"taobao.tbk.adzone.create"//!<淘宝客广告位创建API
#define __API_dg_newuser_order_get__       @"taobao.tbk.dg.newuser.order.get"//!<淘宝客新用户订单API--导购
#define __API_sc_newuser_order_get__       @"taobao.tbk.sc.newuser.order.get"//!<淘宝客新用户订单API--社交

#define __API_wireless_share_tpwd_query__  @"taobao.wireless.share.tpwd.query"//!<查询解析淘口令


//鹏瑶API
#elif URLAPIBUG == 2

#define __API_EditConfig__                   @"Tbk_EditConfig" //!<热门词或者滚动广告 传参 cate: 1 Banner 2 热词
#define __API_UatmFavorites__                @"Tbk_UatmFavorites" //!<首页数据 传递参数为cate 1:顶部导航，2:精选专题，3:底部推荐


#define __API_Item_get__                   @"Item_Get" //!<淘宝客商品查询
#define __API_Item_info_get__              @"Info_Get" //!<淘宝客商品详情（简版）
#define __API_uatm_favorites_item_get__    @"Uatm_Favorites_Item_Get"//!<获取淘宝联盟选品库的宝贝信息
#define __API_uatm_favorites_get__         @"Uatm_Favorites_Get"//!<获取淘宝联盟选品库列表
#define __API_dg_Item_coupon_get__         @"Dg_Item_Coupon_Get"//!<好券清单API【导购】
#define __API_tpwd_create__                @"Tpwd_Create"//!<淘宝客淘口令
#define __API_rebate_order_get__           @"Rebate_Order_Get"//!<淘宝客返利订单查询
#define __API_Item_recommend_get__         @"Item_Recommend_Get"//!<淘宝客商品关联推荐查询
#define __API_Item_guess_like__            @"Item_Guess_Like"//!<淘宝客商品猜你喜欢
#define __API_spread_get__                 @"Spread_Get"//!<物料传播方式获取
#define __API_Wireless_Share_Tpwd_Query__  @"Share_Tpwd_Query"//!<解析淘口令
#define __API_Wireless_Share_Tpwd_Create__ @"Share_Tpwd_Create"//!<生成淘口令



#define __API_itemcats_get__               @"taobao.itemcats.get" //!<cat
#define __API_Item_convert__               @"taobao.tbk.item.convert" //!<淘宝客商品链接转换
#define __API_shop_get__                   @"taobao.tbk.shop.get"//!<淘宝客店铺查询
#define __API_shop_recommend_get__         @"taobao.tbk.shop.recommend.get"//!<淘宝客店铺关联推荐查询
#define __API_rebate_auth_get__            @"taobao.tbk.rebate.auth.get"//!<淘宝客返利授权查询
#define __API_uatm_event_get__             @"taobao.tbk.uatm.event.get"//!<枚举正在进行中的定向招商的活动列表
#define __API_uatm_event_item_get__        @"taobao.tbk.uatm.event.item.get"//!<获取淘宝联盟定向招商的宝贝信息
#define __API_ju_tqg_get__                 @"taobao.tbk.ju.tqg.get"//!<淘抢购api
#define __API_coupon_get__                 @"taobao.tbk.coupon.get"//!<阿里妈妈推广券信息查询
#define __API_content_get__                @"taobao.tbk.content.get"//!<淘客媒体内容输出
#define __API_adzone_create__              @"taobao.tbk.adzone.create"//!<淘宝客广告位创建API
#define __API_dg_newuser_order_get__       @"taobao.tbk.dg.newuser.order.get"//!<淘宝客新用户订单API--导购
#define __API_sc_newuser_order_get__       @"taobao.tbk.sc.newuser.order.get"//!<淘宝客新用户订单API--社交

#endif




//=====================================================================================================================



//=====================================================================================================================

//淘宝客商品查询
#define _Fields_Item_get_ @"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick,coupon_click_url"

//淘宝客返利订单查询
#define _Fields_rebate_order_get_ @"tb_trade_parent_id,tb_trade_id,num_iid,item_title,item_num,price,pay_price,seller_nick,seller_shop_title,commission,commission_rate,unid,create_time,earning_time"

//淘宝客商品链接转换
#define _Fields_Item_convert_ @"num_iid,click_url"

//淘宝客商品关联推荐查询
#define __Fields_Item_recommend_get__ @"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url "
//获取淘宝联盟选品库列表
#define __Fields_uatm_favorites_get__ @"favorites_title,favorites_id,type"
//获取淘宝联盟选品库的宝贝信息
#define __Fields_uatm_favorites_item_get__  @"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick,shop_title,zk_final_price_wap,event_start_time,event_end_time,tk_rate,status,type,coupon_click_url"

//=====================================================================================================================

//详情页分享任务 http://news.91maque.com/news/ShareNewsView?tid=123456,docid

#define __URL_Details_Task__  @"http://news.91maque.com/news/ShareNewsView"
#define __URL_Details_Look__  @"http://m.91maque.com/guide/index.html"


//=====================================================================================================================




#define __FeaturedArr__  @[@"https://img.alicdn.com/tps/TB1fztJOXXXXXcfXpXXXXXXXXXX-794-320.png",@"https://img.alicdn.com/tps/TB1gKlIOXXXXXcJXpXXXXXXXXXX-794-320.png",@"https://img.alicdn.com/tps/TB1JQ9gKFXXXXX.XFXXXXXXXXXX-592-236.jpg",@"https://img.alicdn.com/tps/TB1EdnZKpXXXXc9XpXXXXXXXXXX-592-236.png",@"https://img.alicdn.com/tps/TB10R6.KpXXXXceXXXXXXXXXXXX-592-236.png",@"https://img.alicdn.com/tps/TB1sGn9KpXXXXXPXpXXXXXXXXXX-592-236.png",@"https://img.alicdn.com/tps/TB1W.6YKpXXXXbBXFXXXXXXXXXX-592-236.png",@"https://img.alicdn.com/tps/TB1oyxZNpXXXXbdXVXXXXXXXXXX-594-236.png"];




















//api/Config.ashx //!<系统更新配置 certificate
//http://api.91maque.com/api/GetVersionsData.ashx?type=android//版本更新

//图片素材
#define __Picture_Advertising_ @"start_1"//!<启动页广告图

//阿里妈妈
#define __al_MM_UserID__                      @"121007035"//阿里妈妈帐户
#define __al_MM_APPID__                       @"43378303"//阿里妈妈推广appId
#define __al_MM_AppKey__                      @"24822866" //阿里妈妈推广appkey
#define __al_MM_AppSecret__                   @"9ef7c4a3efc58c0312b9b3f6e8d974db"//阿里妈妈推广AppSecret
#define __al_MM_Pid__                         @"mm_121007035_43378303_585394909"//阿里妈妈推广Pid
#define __al_MM_Adzone_Id__                   @"585394909"
/*
 阿里妈妈淘宝客最新采用的是三段式的PID：mm_memberid_siteid_adzoneid。Memberid对应推广者，Siteid对应媒体，Adzoneid对应推广位
 */
//阿里百川
#define __al_BC_AppKey__                      @"24823046"
#define __al_BC_AppSecret__                   @"458835a9643406ddde4df18ffd38aee1"//阿里百川推广AppSecret
#define __al_BC_URLSchemes__                  @"tbopen24823046"






//淘客基本配置

#define __kAppKey__                      __al_MM_AppKey__
#define __kInterfaceVer__                @"2.0"
#define __kAppSecret__                   __al_MM_AppSecret__
#define __kAppStoreVersions__            @"1.0.0"




//Share分享
#define __ShareTitle__      @"麻雀优惠券-您的省钱好帮手！"
#define __ShareBody__       @"一应俱全的浏览器新玩法，更快更省更全面！"
#define __ShareUrl__        @"http://m.91maque.com"



#endif /* UrlKey_h */

