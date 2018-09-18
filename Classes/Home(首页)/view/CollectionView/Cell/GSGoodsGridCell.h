//
//  GSGoodsGridCellCell.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/14.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//
//宽
#define PIC_WIDTH __kNewSize(136)
//高
#define PIC_HEIGHT __kNewSize(136)
//列
#define COL_COUNT 4

#import <UIKit/UIKit.h>
#import "GSGridItem.h"
typedef  void (^MyGoodsGridBlock)(NSInteger index);
@protocol MyGSGoodsGridDelegate <NSObject>

- (void)myGSGoodsGridClicked:(NSInteger)index;

@end
@interface GSGoodsGridCell : UICollectionViewCell

/* 属性数据 */
@property (strong , nonatomic)GSGridItem * gridItem;
@property (strong , nonatomic)NSArray * gridItemArr;
@property (nonatomic,copy) MyGoodsGridBlock  gridBlock;
@property(nonatomic, assign) id<MyGSGoodsGridDelegate>delegate;

@end
