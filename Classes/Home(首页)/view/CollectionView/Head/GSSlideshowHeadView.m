//
//  GSSlideshowHeadView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/14.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GSSlideshowHeadView.h"
#import <SDCycleScrollView.h>
@interface GSSlideshowHeadView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;


@end
@implementation GSSlideshowHeadView
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
//    self.backgroundColor = [UIColor whiteColor];
    if (!_cycleScrollView) {
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, __kScreenWidth__, self.dc_height) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
//    _cycleScrollView.layer.cornerRadius = 10;
//    //将多余的部分切掉
//    _cycleScrollView.layer.masksToBounds = YES;
    [self addSubview:_cycleScrollView];
    }
}

- (void)setImageGroupArray:(NSArray *)imageGroupArray
{
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"default_160"];
    if (imageGroupArray.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;
    
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
    if ([self.delegate respondsToSelector:@selector(myGSSlideshowHeadViewClicked:)])
    {
        [self.delegate myGSSlideshowHeadViewClicked:index];
    }
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
