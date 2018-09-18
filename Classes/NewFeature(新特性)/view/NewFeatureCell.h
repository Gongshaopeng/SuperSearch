//
//  NewFeatureCell.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/8.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureCell : UICollectionViewCell
/* imageView */
@property (strong , nonatomic)UIImageView *nfImageView;

/** 隐藏新特性按钮点击回调 */
@property (nonatomic, copy) dispatch_block_t hideButtonClickBlock;

/* 跳过图片素材 */
@property (strong , nonatomic)NSString *hideBtnImg;

/**
 用来获取页码
 
 @param currentIndex 当前index
 @param lastIndex 最后index
 */
- (void)dc_GetCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex;

@end
