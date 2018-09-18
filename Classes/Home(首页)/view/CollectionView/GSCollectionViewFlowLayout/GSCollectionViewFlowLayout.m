//
//  GSCollectionViewFlowLayout.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/17.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GSCollectionViewFlowLayout.h"

@interface GSCollectionViewFlowLayout()

@end
@implementation GSCollectionViewFlowLayout

#pragma mark - 初始化layout的结构和初始需要的参数
- (void)prepareLayout
{
    [super prepareLayout];
    

}

//#pragma mark - cell的左右间距

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {

    NSMutableArray * answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

    /* 处理左右间距 */

    for(int i = 1; i < [answer count]; ++i) {
      
            UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];

            UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];

        if (currentLayoutAttributes.indexPath.section == 0) {
       
            NSInteger maximumSpacing = 0;

            NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);

            if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {

                CGRect frame = currentLayoutAttributes.frame;

                frame.origin.x = origin + maximumSpacing;

                currentLayoutAttributes.frame = frame;

            }
         }


    }

    return answer;

}

@end
