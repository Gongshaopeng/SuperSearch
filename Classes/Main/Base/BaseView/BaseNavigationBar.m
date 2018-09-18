//
//  BaseNavigationBar.m
//  YMSP
//
//  Created by allen on 15/4/28.
//  Copyright (c) 2015年 Youmei. All rights reserved.
//

#import "BaseNavigationBar.h"
@interface BaseNavigationBar()
@property (nonatomic, copy) NSArray* leftButtonArr;
@property (nonatomic, copy) NSArray* righButtonArr;
@end
@implementation BaseNavigationBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftBarButtons = [[NSArray alloc] init];
        _rightBarButtons = [[NSArray alloc] init];
        _titleLabel = [[BaseLabel alloc] initWithFrame:CGRectMake(30, 0, __kScreenWidth__-60, frame.size.height-20)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.center = CGPointMake(__kScreenWidth__/2, 20+(frame.size.height-20)/2);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
//        _titleLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_titleLabel];
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __kScreenWidth__-220, frame.size.height-20)];
        _centerView.center = CGPointMake(__kScreenWidth__/2, 20+(frame.size.height-20)/2);
        [self addSubview:_centerView];
        
    }
    return self;
}
-(void)setLeftBarButtons:(NSArray *)leftBarButtons{
    if (self.leftBarButtons.count > 0) {
        for (UIButton* button in self.leftBarButtons) {
            [button removeFromSuperview];
        }
    }
    int i=0;
    for (UIButton* button in leftBarButtons) {
        button.frame = CGRectMake(0, 0, __kNewSize(80), button.frame.size.height);
        button.center = CGPointMake(10+button.frame.size.width/2+i*(button.frame.size.width/2+10), 20+(self.frame.size.height-20)/2);
//        button.backgroundColor = [UIColor greenColor];
        [self addSubview:button];
        i++;
    }
    _leftBarButtons = leftBarButtons;
}

-(void)setRightBarButtons:(NSArray *)rightBarButtons{
    if (self.rightBarButtons.count > 0) {
        for (UIButton* button in self.rightBarButtons) {
            [button removeFromSuperview];
        }
    }
    int i=0;
    for (UIButton* button in rightBarButtons) {
        button.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
        button.center = CGPointMake(__kScreenWidth__-20-button.frame.size.width/2-i*(10+button.frame.size.width), 20+(self.frame.size.height-20)/2);
        [self addSubview:button];
        i++;
    }
    _rightBarButtons = rightBarButtons;
}
- (void)setBarHidden:(BOOL)isHidden{
    CGSize size = self.frame.size;
    if (isHidden) {
//        [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, -size.height, size.width, size.height);
//        }];
    }else{
//        [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 0, size.width, size.height);
//        }];
    }
}


@end
