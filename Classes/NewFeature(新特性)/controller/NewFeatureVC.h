//
//  NewFeatureVC.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/8.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureVC : UIViewController
/**
 新特性属性设置
 *imageArray   图片数组
 *showSkip  是否展示跳过
 *selColor    选择小圆点的颜色
 *showPageCount 是否展示小圆点
 
 @param BaseSettingBlock 基础设置
 */
- (void)setUpFeatureAttribute:(void(^)(NSArray **imageArray,UIColor **selColor,BOOL *showSkip,BOOL *showPageCount))BaseSettingBlock;
@end
