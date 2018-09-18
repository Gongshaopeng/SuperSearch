//
//  ImageItmeCell.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/5/31.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemModel;
@interface ImageItmeCell : UICollectionViewCell

@property (nonatomic,copy) ItemModel *model;//!<数据
@property (nonatomic,copy) NSArray *imgArr;//!<图片数据
@property (nonatomic,copy) NSString *imgUrl;//!<图片数据

@end
