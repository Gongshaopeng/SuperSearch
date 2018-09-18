//
//  GSFeaturedCell.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/15.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSGridItem.h"
@protocol MyGSFeaturedDelegate <NSObject>

- (void)myGSFeaturedClicked:(NSInteger)index;

@end
@interface GSFeaturedCell : UICollectionViewCell
/* 属性数据 */
@property (strong , nonatomic)GSGridItem * gridItem;
@property (nonatomic,strong) NSArray * featArr;
@property(nonatomic, assign) id<MyGSFeaturedDelegate>delegate;

@end
