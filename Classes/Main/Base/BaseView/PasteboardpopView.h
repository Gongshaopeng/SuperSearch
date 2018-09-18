//
//  PasteboardpopView.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/28.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestModel.h"
@interface PasteboardpopView : UIView

/* 推荐数据 */
@property (strong , nonatomic)TBKCouponModel * couponModel;

/** 去购买回调 */
@property (nullable, nonatomic, copy) void(^GoodsComplete)(void);
/** 搜同款回调 */
@property (nullable, nonatomic, copy) void(^SearchComplete)(void);

@end
