//
//  UIImage+ImageCornerRadius.m
//  LaiZhuan
//
//  Created by allen on 16/3/8.
//  Copyright © 2016年 jianjie. All rights reserved.
//
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define screenScale ([UIScreen mainScreen].scale)

#import "UIImage+ImageCornerRadius.h"

@implementation UIImage (ImageCornerRadius)

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)imageWithScreenshotView:(UIView *)view Frame:(CGRect)frame SHWidth:(CGFloat)width SHHeight:(CGFloat)height
{
    
    CGImageRef imageRef =[UIImage imageWithScreenshotView:view SHWidth:width SHHeight:height].CGImage;
    CGRect rect = frame;//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage =[[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);

    return sendImage;
}
+ (UIImage *)imageWithScreenshotView:(UIView *)view SHWidth:(CGFloat)width SHHeight:(CGFloat)height
{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO,0.0);//设置截屏大小
    
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}


- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}
- (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr
{
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLStr]];
    NSData *newImageData = imageData;
    // 压缩图片data大小
    newImageData = UIImageJPEGRepresentation([UIImage imageWithData:newImageData scale:0.1], 0.1f);
    UIImage *image = [UIImage imageWithData:newImageData];
    
    // 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
    CGSize newSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)compressToByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return self;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        
        CGSize size = CGSizeMake(200, 200);
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    resultImage = [UIImage imageWithData:data];
    return resultImage;
}
- (UIImage *)zipSize{
    if (self.size.width < 200) {
        return self;
    }
    CGSize size = CGSizeMake(200, 200);
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}

- (UIImage *)zip{
    UIImage *image = [self compressToByte:2*1024*1024];
    return  [image zipSize];
}
- (UIImage *)zipGIF{
    UIImage *image = [self compressToByte:500];
    return  [image zipSize];
}
- (UIImage *)gifChangeToImageWithData:(NSData *)data
{
    if (!data)
    {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1)
    {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else
    {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 3.0f;
        for (size_t i = 0; i < count; i++)
        {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image)
            {
                continue;
            }
            duration += [self frameDurationAtIndex:i source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        if (!duration)
        {
            duration = (1.0f / 10.0f) * count;
        }
         animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    CFRelease(source);
    return animatedImage;
}

- (NSData *)zipGIFWithData:(NSData *)data
{
    if (!data) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage = nil;
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval duration = 0.0f;
    for (size_t i = 0; i < count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        duration += [self frameDurationAtIndex:i source:source];
        UIImage *ima = [UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        ima = [ima zip];
        [images addObject:ima];
        CGImageRelease(image);
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    CFRelease(source);
    return UIImagePNGRepresentation(animatedImage);
}
- (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source

{
    
    float frameDuration = 0.1f;
    
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    
    if (delayTimeUnclampedProp)
        
    {
        
        frameDuration = [delayTimeUnclampedProp floatValue];
        
    }
    
    else
        
    {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        
        if (delayTimeProp)
            
        {
            
            frameDuration = [delayTimeProp floatValue];
            
        }
        
    }
    
    if (frameDuration < 0.011f)
        
    {
        
        frameDuration = 0.100f;
        
    }
    
    CFRelease(cfFrameProperties);
    
    return frameDuration;
    
}
- (UIImage *)imageWithScreenshot
{
    return [UIImage imageWithScreenshotGS];
}


// 1.将文字添加到图片上;imageName 图片名字， text 需画的字体
+ (UIImage *)createShareImage:(UIImage *)tImage Context:(NSString *)text
{
    UIImage *sourceImage = tImage;
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    CGFloat nameFont = 8.f;
    //画 自己想要画的内容
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]};
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, nameFont) options:NSStringDrawingUsesDeviceMetrics attributes:attributes context:nil];
    NSLog(@"图片: %f %f",imageSize.width,imageSize.height);
    NSLog(@"sizeToFit: %f %f",sizeToFit.size.width,sizeToFit.size.height);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    [text drawAtPoint:CGPointMake((imageSize.width-sizeToFit.size.width)/2,0) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]}];
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}
+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    
    return [self addImage:image1 Frame1:CGRectMake(image2.size.width-120, image2.size.height-120, 120, 120) toImage:image2 Frame2:CGRectMake(0, 0, image2.size.width, image2.size.height)];
}
+(UIImage *)addImage:(UIImage *)image1 Frame1:(CGRect)frame1 toImage:(UIImage *)image2 Frame2:(CGRect)frame2
{
    UIGraphicsBeginImageContext(image2.size);
    
    //Draw image2
    [image2 drawInRect:frame2];
    
    //Draw image1
    [image1 drawInRect:frame1];
    
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}



+ (UIImage *)imageWithScreenshotGS
{
//    CGSize imageSize = CGSizeZero;
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    if (UIInterfaceOrientationIsPortrait(orientation))
//        imageSize = [UIScreen mainScreen].bounds.size;
//    else
//        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
//    
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    for (UIWindow *window in [UIApplication sharedApplication].windows  )
//    {
//        CGContextSaveGState(context);
//        CGContextTranslateCTM(context, window.center.x, window.center.y);
//        CGContextConcatCTM(context, window.transform);
//        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
//        if (orientation == UIInterfaceOrientationLandscapeLeft)
//        {
//            CGContextRotateCTM(context, M_PI_2);
//            CGContextTranslateCTM(context, 0, -imageSize.width);
//        }
//        else if (orientation == UIInterfaceOrientationLandscapeRight)
//        {
//            CGContextRotateCTM(context, -M_PI_2);
//            CGContextTranslateCTM(context, -imageSize.height, 0);
//        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
//            CGContextRotateCTM(context, M_PI);
//            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
//        }
//        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
//        {
//            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
//        }
//        else
//        {
//            [window.layer renderInContext:context];
//        }
//        
//        CGContextRestoreGState(context);
//    }
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    NSData *imageData = UIImagePNGRepresentation(image);
//    return [UIImage imageWithData:imageData];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(screenWidth*screenScale, screenHeight*screenScale), YES, 0);
    //设置截屏大小
    //    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow] ;
    ////    [win snapshotViewAfterScreenUpdates:NO];
    ////    [win drawViewHierarchyInRect:win.bounds afterScreenUpdates:NO];
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    [win.layer renderInContext: UIGraphicsGetCurrentContext()];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(window != nil){
        
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
        }
        else{
            [window.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
    }else{
        for (UIWindow * window in [[UIApplication sharedApplication] windows]) {
            if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, [window center].x, [window center].y);
                CGContextConcatCTM(context, [window transform]);
                CGContextTranslateCTM(context, -[window bounds].size.width*[[window layer] anchorPoint].x, -[window bounds].size.height*[[window layer] anchorPoint].y);
                [[window layer] renderInContext:context];
                
                CGContextRestoreGState(context);
            }
        }
        
    }
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(1, 1, screenWidth*screenScale,screenHeight*screenScale);
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    //    CGImageRelease(imageRef);
    CGImageRelease(imageRefRect);
    return sendImage;
}

+(UIImage *)snapshotScreenInView:(UIView *)contentView
{
    
    CGSize size = contentView.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rect = contentView.frame;
    
    //  自iOS7开始，UIView类提供了一个方法-drawViewHierarchyInRect:afterScreenUpdates: 它允许你截取一个UIView或者其子类中的内容，并且以位图的形式（bitmap）保存到UIImage中
    
    [contentView drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (UIImage *)resizeWithImage:(UIImage *)image{
    CGFloat top = image.size.height/2.0;
    CGFloat left = image.size.width/2.0;
    CGFloat bottom = image.size.height/2.0;
    CGFloat right = image.size.width/2.0;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)resizingMode:UIImageResizingModeStretch];
}
@end
