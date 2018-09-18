//
//  PageGoodsVC.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/21.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "SubViewController.h"
#import "UatmFavoritesModel.h"
@protocol PageGoodsDelegate <NSObject>

//将点击的cell的数据传回控制器
- (void)cellIndexPathPageGoods:(ItemModel *)indexModle;
@end

@interface PageGoodsVC : SubViewController

@property (nonatomic,strong) UatmFavoritesModel *  favoritesOBJ;
@property (nonatomic, assign) id<PageGoodsDelegate> delegate;

@end
