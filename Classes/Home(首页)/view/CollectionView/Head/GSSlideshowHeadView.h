//
//  GSSlideshowHeadView.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/14.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyGSSlideshowHeadViewDelegate <NSObject>

- (void)myGSSlideshowHeadViewClicked:(NSInteger)index;

@end
@interface GSSlideshowHeadView : UICollectionReusableView
/* 轮播图数组 */
@property (copy , nonatomic)NSArray *imageGroupArray;
@property(nonatomic, assign) id<MyGSSlideshowHeadViewDelegate>delegate;

@end
