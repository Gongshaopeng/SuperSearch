//
//  MyToolBarView.h
//  Esou
//
//  Created by 巩小鹏 on 16/8/26.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "toolBarLable.h"
@protocol MyToolBarViewBtnClickedDelegate <NSObject>

- (void)myToolBarViewBtnClicked:(NSInteger)index;

@end
@interface MyToolBarView : UIView
@property (nonatomic,strong) NSMutableArray * btnImage;//底部工具栏图片
@property (nonatomic,strong) UIView * topXianView;//!<头部线

@property(nonatomic, assign) id<MyToolBarViewBtnClickedDelegate>delegate;

@property (nonatomic,strong) UILabel * numLable;
-(void)createToolBarImagerArr:(NSArray *)imageTBArr title:(NSArray *)titleTBArr titleColor:(UIColor *)color;//工具栏数据

- (void)setToolBarHidden:(BOOL)isHidden;//隐藏工具栏

@end
