//
//  STool.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/1.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STool : NSObject
//// 调整行间距
+(void)newParagraphStyle:(UILabel *)lable str:(NSString *)textStr LineSpacing:(CGFloat)LineSpacing;
+(NSMutableAttributedString *)attributedPlaceholderText:(NSString *)holderText colorStr:(NSString *)color;
+(NSString *)getDocIdFromWhichToObtainUrl:(NSString *)URL objectForKey:(NSString *)key;
+(BOOL)judgeDivisibleWithFirstNumber:(CGFloat)firstNumber andSecondNumber:(CGFloat)secondNumber;
+(NSInteger)returnCountFirstNumber:(CGFloat)firstNumber andSecondNumber:(CGFloat)secondNumber;

+(NSString *)returnCouponInfo:(NSString *)couponInfo price:(NSString *)price;//券后价
+(NSString *)returnCouponInfo:(NSString *)couponInfo;//优惠券

+(BOOL)isLogin;

//json字符串转数组
+(NSArray *)strTransformArr:(NSString *)str;
//数组转json字符串
+(NSString *)arrTransformString:(NSArray *)arr;

+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect;

+(UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size;

@end
