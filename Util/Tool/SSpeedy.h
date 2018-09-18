//
//  SSpeedy.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/8.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSpeedy : NSObject
/**
 设置按钮的圆角
 
 @param anyControl 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+(id)ss_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can;


/**
 选取部分数据变色（label）
 
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+(id)ss_setSomeOneChangeColor:(UILabel *)label SetSelectArray:(NSArray *)arrray SetChangeColor:(UIColor *)color;


#pragma mark -  根据传入字体大小计算字体宽高
+ (CGSize)ss_calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW ;

/**
 下划线
 
 @param view 下划线
 */
+ (void)ss_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color;

/**
 竖线线
 
 @param view 竖线线
 */
+ (void)ss_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;


/**
 利用贝塞尔曲线设置圆角
 
 @param control 按钮
 @param size 圆角尺寸
 */
+ (void)ss_setUpBezierPathCircularLayerWithControl:(UIButton *)control size:(CGSize)size;


/**
 label首行缩进
 
 @param label label
 @param emptylen 缩进比
 */
+ (void)ss_setUpLabel:(UILabel *)label Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen;


/**
 字符串加星处理
 
 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)ss_encryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex;



/**
 取随机数
 
 @param StarNum 开始值
 @param endNum 结束值
 @return 从开始值到结束值之间的随机数
 */
+ (NSInteger)ss_GetRandomNumber:(NSInteger)StarNum to:(NSInteger)endNum;


#pragma mark - 图片转base64编码
+ (NSString *)UIImageToBase64Str:(UIImage *) image;

#pragma mark - base64图片转编码
+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;

+ (void)ss_SetUpAlterWithView:(UIViewController *)vc Message:(NSString *)message Sure:(dispatch_block_t)sureBlock Cancel:(dispatch_block_t)cancelBlock;



/**
 触动
 */
+ (void)ss_callFeedback;


/**
 获取当前控制器
 */
+ (UIViewController *)ss_getCurrentVC;


@end
