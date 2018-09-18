//
//  GoodsToolsView.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/24.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "MySwitch.h"

typedef enum : NSUInteger
{
    //展示优惠券
    CouponYESType,
    //不展示优惠券
    CouponNOType,
    //好券
    SearchCouponType,
    //超级搜
    SearchSuperType
}
GoodsToolsType;



@protocol MyGoodsToolsDelegate <NSObject>

- (void)myGoodsToolsClicked:(GoodsToolsType)type;

@end


@interface GoodsToolsView : BaseView
/*
 * 条件筛选工具
 */

/*
 *优惠券商品是否展示工具
 */
@property (nonatomic ,strong) UIImageView * imageView;
@property (nonatomic ,strong) UILabel * lableTitle;
@property (nonatomic ,strong) UISwitch * switchBtn;
@property (nonatomic ,strong) MySwitch * mySwitch;
@property (nonatomic ,strong) UIButton * searchBtn;//!<搜索选项 好券 或 超级搜

@property(nonatomic, assign) id<MyGoodsToolsDelegate>delegate;
@property (nonatomic, assign) GoodsToolsType goodsToolsType;//!<功能枚举

@end
