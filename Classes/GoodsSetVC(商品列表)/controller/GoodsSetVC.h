//
//  GoodsSetVC.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "SubViewController.h"

@interface GoodsSetVC : SubViewController
@property (nonatomic,strong) NSString * searchStr;//!<搜索字段
@property (nonatomic,strong) NSString * favoritesId;//!<选品库ID
@property (nonatomic,assign)    BOOL  isCouponOrUatm;//yes:好券 NO:选品库

@end
