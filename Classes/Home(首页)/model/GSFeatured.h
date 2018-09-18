//
//  GSFeatured.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/12.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface GSFeatured : BaseModel
/** 图片  */
@property (nonatomic, copy ) NSString *iconImage;
/** 文字  */
@property (nonatomic, copy ) NSString *gridTitle;
/** tag  */
@property (nonatomic, copy ) NSString *gridTag;
/** tag颜色  */
@property (nonatomic, copy ) NSString *gridColor;

/** 标题  */
@property (nonatomic, copy ) NSString *Title;
/** 图片链接  */
@property (nonatomic, copy ) NSString *Image;
/** 内容，可以是ID或者链接  */
@property (nonatomic, copy ) NSString *Context;
/** 内容类型，1表示链接，2表示分类ID，3表示商品ID  */
@property (nonatomic, copy ) NSString *ContextType;
/** 类型，1表示Banner，2表示热词  */
@property (nonatomic, copy ) NSString *Category;
/** 内容描述   */
@property (nonatomic, copy ) NSString *Desc;
/**   */
@property (nonatomic, copy ) NSString *Id;
/**   */
@property (nonatomic, copy ) NSString *CreateTime;
/**   */
@property (nonatomic, copy ) NSString *UpdateTime;

@end
/*
 "Title": "测试",               //标题
 "Image": "123",             //图片链接
 "Context": "测试123",   //内容，可以是ID或者链接
 "ContextType": 1,         //内容类型，1表示链接，2表示分类ID，3表示商品ID
 "Desc": "测试123描述",//内容描述
 "Category": 1,              //类型，1表示Banner，2表示热词
 "Id": "bce48751-0d48-44f0-b6e0-4a9123f652dc",
 "CreateTime": "2018-03-30T11:02:17",
 "UpdateTime": "2018-03-30T11:02:17"
 */

