//
//  SubViewController.h
//  TESTDome
//
//  Created by 巩继鹏 on 16/6/10.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import "BaseViewController.h"

@interface SubViewController : BaseViewController
@property (nonatomic, assign) BOOL isNaivBackColor; //!< yes：是白色 NO：是黑色
-(void)myViewFrameIsNavi:(BOOL)isNavi;

@end
