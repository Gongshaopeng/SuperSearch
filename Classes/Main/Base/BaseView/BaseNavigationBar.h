//
//  BaseNavigationBar.h
//  YMSP
//
//  Created by allen on 15/4/28.
//  Copyright (c) 2015年 Youmei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabel.h"

@interface BaseNavigationBar : UIView
@property (nonatomic,strong) NSArray* leftBarButtons;
@property (nonatomic,strong) NSArray* rightBarButtons;
@property (nonatomic,strong) UIView* centerView;
@property (nonatomic,strong) BaseLabel* titleLabel;
@property (nonatomic,strong) BaseLabel* subTitleLabel;
@property (nonatomic,assign) BOOL isHidden;
- (void)setBarHidden:(BOOL)isHidden;
@end
