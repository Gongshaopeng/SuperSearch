//
//  GSHomeRefreshGifHeader.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/14.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GSHomeRefreshGifHeader.h"



// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface GSHomeRefreshGifHeader ()

@property (nonatomic , strong) UIImageView *refreshImage;

@end

@implementation GSHomeRefreshGifHeader

#pragma mark - 重写方法
- (void)prepare{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSInteger i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"comm_loading_0%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"comm_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //隐藏状态时间
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字
    [self setTitle:@"下拉松手刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松手刷新数据" forState:MJRefreshStatePulling];
    [self setTitle:@"帮您更新数据" forState:MJRefreshStateRefreshing];
    self.stateLabel.textColor = [UIColor lightGrayColor];
    
}

#pragma mark - 重新设置子控件
- (void)placeSubviews{
    [super placeSubviews];
    self.labelLeftInset = 5;
    self.mj_h = 55;
    
    //设置图片大小
    UIImage *gif = [UIImage imageNamed:@"comm_loading_01"];
    self.gifView.mj_size = gif.size;
    
    self.gifView.mj_h = self.mj_h;
    self.gifView.mj_w = gif.size.width * self.gifView.mj_h / gif.size.height;
    self.gifView.mj_x = self.mj_w / 2 - self.gifView.mj_w;
    
    self.stateLabel.mj_w = self.mj_w / 2;
    self.stateLabel.mj_x = CGRectGetMaxX(self.gifView.frame)+self.labelLeftInset;
    self.stateLabel.mj_h = 30;
    
    if (self.state == MJRefreshStateRefreshing) {
        self.gifView.mj_y = 5;
    }else{
        self.gifView.mj_y = (self.mj_h - self.gifView.mj_size.height)/2 - 10;
    }
    
    self.stateLabel.mj_y = self.mj_h - self.stateLabel.mj_h;
    self.stateLabel.textAlignment = NSTextAlignmentLeft;
    NSLog(@"重新设置控件位置");
}

@end

