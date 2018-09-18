//
//  UIImageView+Action.h
//  iPresale
//
//  Created by ChenQiuLiang on 15/8/20.
//  Copyright (c) 2015年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Action)

//快捷的给UIImageView添加手势事件
- (void)touchedInImageViewWithTarget:(id)delegate Action:(SEL)action;

@end
