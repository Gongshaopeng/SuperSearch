//
//  SSTabBadgeView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/8.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "SSTabBadgeView.h"

@implementation SSTabBadgeView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpBase];
    }
    return self;
}

#pragma mark - base
- (void)setUpBase
{
    self.userInteractionEnabled = NO;
    self.titleLabel.font = PFR11Font;
    
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backgroundColor = UIColorFromRGB(226, 70, 157);
    
    __kWeakSelf__;
    [[NSNotificationCenter defaultCenter]addObserverForName:@"jump" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.values = @[@1.0,@1.1,@0.9,@1.0];
        animation.duration = 0.3;
        animation.calculationMode = kCAAnimationCubic;
        //添加动画
        [weakSelf.layer addAnimation:animation forKey:nil];
    }];
}

#pragma mark - 赋值
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    [self setBadgeViewWithbadgeValue:badgeValue];
}

#pragma mark - 设置
- (void)setBadgeViewWithbadgeValue:(NSString *)badgeValue {
    // 设置文字内容
    [self setTitle:badgeValue forState:UIControlStateNormal];
    // 判断是否有内容,设置隐藏属性
    self.hidden = (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) ? YES : NO;
    NSInteger badgeNumber = [badgeValue integerValue];
    // 如果文字尺寸大于控件宽度
    
    if (badgeNumber > 99) {
        [self setTitle:@"99+" forState:UIControlStateNormal];
    }
    CGRect dcFrame = self.frame;
    dcFrame.size = CGSizeMake(22, 22);
    self.frame = dcFrame;
    
    [SSpeedy ss_chageControlCircularWith:self AndSetCornerRadius:11 SetBorderWidth:1 SetBorderColor:UIColorFromRGB(245,245,245) canMasksToBounds:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
