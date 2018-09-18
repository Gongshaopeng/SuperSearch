//
//  ImgQRView.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/6/1.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "BaseView.h"
@class ItemModel;
@interface ImgQRView : BaseView
/* 推荐数据 */
@property (strong , nonatomic)ItemModel *itemM;
@property (strong , nonatomic)NSString *imageUrl;

@end
