//
//  BaseView.h
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

- (UIViewController *)viewController ;

- (UIViewController *)getCurrentVC;



// 弹出警告框
- (void)showTitle:(NSString *)title
          message:(NSString *)message
      titleButton:(NSString *)titleBth;

- (void)downloadAnimation;

- (void)stopDownloadAnimation;

- (NSMutableAttributedString *)makeString:(NSString *)makeString
                        theFirstLowString:(NSString *)firstLowString
                       theSecondLowString:(NSString *)secondLowString
                               firstIndex:(NSInteger)firstIndex;

-(void)initValueParticipate:(NSString *)str people:(NSString *)people lable:(UILabel *)lable;

/**
 *  创建缓存
 *
 *  @param url 缓存url
 */
- (void)writeToCache:(NSString *)url;
/**
 *  读取缓存
 *
 *  @param url 缓存Url
 *
 *  @return 缓存位置
 */
- (NSString *)readCache:(NSString *)url;
/**
 
 * 删除网页缓存
 
 */

-(void)removeFileManager:(NSString *)url;


-(void)setWebRequestErrorImageView:(CGRect)imageFrame imageNamed:(NSString *)imageName LableFrame:(CGRect)lableFrame Button:(CGRect)btnFrame BtnAction:(SEL)action SearchStr:(NSString *)titleSearch lableTextColor:(UIColor *)textColor view:(UIView*)myView;
-(void)removeWebErrorView:(UIView *)myView;

@end
