//
//  GS_CacheModel.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GS_CacheModel : NSObject

/** 首页头部滚动广告 */
UIKIT_EXTERN NSString *const EditConfig_ONE ;
/** 热门词 */
UIKIT_EXTERN NSString *const EditConfig_TWO ;
/** 首页频道按钮 */
UIKIT_EXTERN NSString *const UatmFavorites_ONE ;
/** 首页推荐专题 featured*/
UIKIT_EXTERN NSString *const UatmFavorites_TWO ;
/** 首页推荐热销*/
UIKIT_EXTERN NSString *const UatmFavorites_THREE ;
/** 推荐底部数据 */
UIKIT_EXTERN NSString *const FavoritesItem ;


//=============================  FMDB_Model   =========================================

@property (nonatomic,copy) NSString * type;//!<类型
@property (nonatomic,copy) NSString * jsonStr;//!<数据
@property (nonatomic,copy) NSString * updateTime;//!<更新时间

@end
