//
//  DirectionsCell.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/26.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectionsCell : UICollectionViewCell
/* 标题图片 */
@property (strong , nonatomic)UIImageView *directionImageView;
/* 小标题 */
@property (strong , nonatomic)UIImageView *numImageView;
/* 数字 */
@property (strong , nonatomic)UILabel *numLabel;
@end
