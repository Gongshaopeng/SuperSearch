//
//  GSGridItem.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/14.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

//#import <Foundation/Foundation.h>

#import "BaseModel.h"

@interface GSGridItem : BaseModel
/** 分类  */
@property (nonatomic, copy ) NSString <Optional>*Category;
/** id  */
@property (nonatomic, copy ) NSString <Optional>*Id;
/** 详情  */
@property (nonatomic, copy ) NSString <Optional>*Desc;
/** 选品库ID  */
@property (nonatomic, copy ) NSString <Optional>*FavoritesId;
/** 选品库名  */
@property (nonatomic, copy ) NSString <Optional>*FavoritesTitle;
/** 选品库类型  */
@property (nonatomic, copy ) NSString <Optional>*FavoritesType;
/** 图片  */
@property (nonatomic, copy ) NSString <Optional>*Image;
/** 自定义名  */
@property (nonatomic, copy ) NSString <Optional>*Title;
/** 更新时间  */
@property (nonatomic, copy ) NSString <Optional>*UpdateTime;
/** 创建时间  */
@property (nonatomic, copy ) NSString <Optional>*CreateTime;

@end
/*
 Category = 1;
 CreateTime = "2018-04-12T16:29:45";
 Desc = "\U5973\U88c5\U5c16\U8d27\Uff0c\U5c31\U662f\U4fbf\U5b9c";
 FavoritesId = 16878597;
 FavoritesTitle = "\U5973\U88c5\U5c16\U8d27";
 FavoritesType = 1;
 Id = "4fa12a9b-acf8-4877-b530-aca38efb62b8";
 Image = "<null>";
 Title = "\U5973\U88c5\U5c16\U8d27";
 UpdateTime = "2018-04-12T16:29:45";
 
 */
