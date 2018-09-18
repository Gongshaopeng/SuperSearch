//
//  STool.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/1.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "STool.h"

@implementation STool
//// 调整行间距
+(void)newParagraphStyle:(UILabel *)lable str:(NSString *)textStr LineSpacing:(CGFloat)LineSpacing{
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
    lable.attributedText = attributedString;
    
    [lable sizeToFit];
}
+(NSMutableAttributedString *)attributedPlaceholderText:(NSString *)holderText colorStr:(NSString *)color
{
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:color]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"ArialMT"size:__kNewSize(28)]
                        range:NSMakeRange(0, holderText.length)];
    //_searchTextField.attributedPlaceholder = placeholder;
    return placeholder;
}
+(NSString *)getDocIdFromWhichToObtainUrl:(NSString *)URL objectForKey:(NSString *)key
{
    
    NSDictionary * dict = [NSDictionary getURLParameters:URL];
    if (dict == nil) {
        return @"";
    }
    NSString * str =[dict objectForKey:key];
    if (str == nil) {
        return @"";
    }
    return str;
}

/**
 *  判断两个浮点数是否整除
 *
 *  @param firstNumber  第一个浮点数(被除数)
 *  @param secondNumber 第二个浮点数(除数,不能为0)
 *
 *  @return 返回值可判定是否整除
 */
+ (BOOL)judgeDivisibleWithFirstNumber:(CGFloat)firstNumber andSecondNumber:(CGFloat)secondNumber {
    // 默认记录为整除
    BOOL isDivisible = YES;
    
    if (secondNumber == 0) {
        return NO;
    }
    
    CGFloat result = firstNumber / secondNumber;
    NSString * resultStr = [NSString stringWithFormat:@"%f", result];
    NSRange range = [resultStr rangeOfString:@"."];
    NSString * subStr = [resultStr substringFromIndex:range.location + 1];
    
    for (NSInteger index = 0; index < subStr.length; index ++) {
        unichar ch = [subStr characterAtIndex:index];
        
        // 后面的字符中只要有一个不为0，就可判定不能整除，跳出循环
        if ('0' != ch) {
            //            NSLog(@"不能整除");
            isDivisible = NO;
            break;
        }
    }
    
    // NSLog(@"可以整除");
    return isDivisible;
}
+(NSInteger)returnCountFirstNumber:(CGFloat)firstNumber andSecondNumber:(CGFloat)secondNumber{
    if ([self judgeDivisibleWithFirstNumber:firstNumber andSecondNumber:secondNumber]) {
        return firstNumber/secondNumber;
    }else{
        return (firstNumber/secondNumber)+1;
    }
}


+(NSString *)returnCouponInfo:(NSString *)couponInfo price:(NSString *)price{
    
    NSScanner *scanner = [NSScanner scannerWithString:[self returnCouponInfo:couponInfo]];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    NSString *num=[NSString stringWithFormat:@"%d",number];
    NSString * zkP = [NSString stringWithFormat:@"¥ %ld",[price integerValue]-[num integerValue]];
    return zkP;
}

+(NSString *)returnCouponInfo:(NSString *)couponInfo{
    NSArray *array = [couponInfo componentsSeparatedByString:@"减"];
    if (array.count != 0) {
        return array[1];
    }
    return @"0元";
}
+(BOOL)isLogin
{
       return NO;
}

+(NSString *)arrTransformString:(NSArray *)arr
{
            NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"jsonStr==%@",jsonStr);
    return jsonStr;

}
+(NSArray *)strTransformArr:(NSString *)str
{
             NSArray* dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            GSLog(@"字符串转字典/数组 %@",dic);
    return dic;
}

//工厂创建
+ (UIButton *)setButton:(NSString *)title x:(CGFloat)x y:(CGFloat)y sel:(SEL)method
{
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 130, 50)];
    [button2  setTitle:title forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor cyanColor];
    button2.titleLabel.adjustsFontSizeToFitWidth = YES;
    button2.titleLabel.translatesAutoresizingMaskIntoConstraints = YES;
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
//    [self.myBGScrollView addSubview:button2];
    return button2;
}

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *
 *  @return UIImage
 */
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}
/**
 *根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取 * UIImage image 原始的图片 * CGSize size 截取图片的size
 */
+(UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size{
    //被切图片宽比例比高比例小 或者相等，以图片宽进行放大
    if (image.size.width*size.height <= image.size.height*size.width) {
        //以被剪裁图片的宽度为基准，得到剪切范围的大小
        CGFloat width = image.size.width; CGFloat height = image.size.width * size.height / size.width;
        // 调用剪切方法
        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [self imageFromImage:image inRect:CGRectMake(0, (image.size.height -height)/2, width, height)];
        
    }else{ //被切图片宽比例比高比例大，以图片高进行剪裁
        // 以被剪切图片的高度为基准，得到剪切范围的大小
        CGFloat width = image.size.height * size.width / size.height; CGFloat height = image.size.height;
        // 调用剪切方法
        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [self imageFromImage:image inRect:CGRectMake((image.size.width -width)/2, 0, width, height)];
        
    } return nil;
    
}
    
/**
 *从图片中按指定的位置大小截取图片的一部分 * UIImage image 原始的图片 * CGRect rect 要截取的区域
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    //返回剪裁后的图片
    return newImage;
    
}
    
    
  
@end
