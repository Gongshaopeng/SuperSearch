//
//  UIImageView+Action.m
//  iPresale
//
//  Created by ChenQiuLiang on 15/8/20.
//  Copyright (c) 2015年 YS. All rights reserved.
//

#import "UIImageView+Action.h"

@implementation UIImageView (Action)

- (void)touchedInImageViewWithTarget:(id)delegate Action:(SEL)action;
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:delegate action:action];
    [self addGestureRecognizer:tap];
}

@end
