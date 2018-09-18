//
//  UIImage+ImageCornerRadius.h
//  LaiZhuan
//
//  Created by allen on 16/3/8.
//  Copyright © 2016年 jianjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreGraphics/CoreGraphics.h"

@interface UIImage (ImageCornerRadius)

- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;
- (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr;
+ (UIImage *)imageWithScreenshotView:(UIView *)view Frame:(CGRect)frame SHWidth:(CGFloat)width SHHeight:(CGFloat)height;
+ (UIImage *)imageWithScreenshotView:(UIView *)view SHWidth:(CGFloat)width SHHeight:(CGFloat)height;
//直接调用这个方法进行压缩体积,减小大小
- (UIImage *)compressToByte:(NSUInteger)maxLength;
- (UIImage *)zip;
- (UIImage *)zipGIF;
- (NSData *)zipGIFWithData:(NSData *)data;
- (UIImage *)gifChangeToImageWithData:(NSData *)data;

//截屏
- (UIImage *)imageWithScreenshot;
+ (UIImage *)imageWithScreenshotGS;
+(UIImage *)snapshotScreenInView:(UIView *)contentView;

//合并图片
+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
// 1.将文字添加到图片上;imageName 图片名字， text 需画的字体
+ (UIImage *)createShareImage:(UIImage *)tImage Context:(NSString *)text;
//拉伸图片
+ (UIImage *)resizeWithImage:(UIImage *)image;

@end
