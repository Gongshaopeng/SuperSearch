//
//  UIDevice+GSDevice.m
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/12/26.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//
#import "UIDevice+GSDevice.h"

@implementation UIDevice (GSDevice)
/**
 * @interfaceOrientation 输入要强制转屏的方向
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
}

@end
