//
//  UIDevice+GSDevice.h
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/12/26.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIDevice (GSDevice)
/**
 * @interfaceOrientation 输入要强制转屏的方向
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
