//
//  BaseView.m
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()

//这里面填写属性
//需要公开的写在点h文件中

@end

@implementation BaseView
{
    BOOL _isCreated;
}

//初始化方法
#pragma mark - InitView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        [self lazyCreateUI];
//        [self layoutSubview];
    }
    return self;
}

//创建UI
#pragma mark - CreateUI
- (void)lazyCreateUI
{
    if (_isCreated == YES)  return;
    
    // createUI
    
    _isCreated = YES;
}

//创建大小
- (void)layoutSubview
{
    //You should set subviews constrainsts or frame here
}

//根据数据初始化view
#pragma mark - Config Cell's Data

//点击事件
#pragma mark - Event response

//系统代理
#pragma mark - SystemDelegate

//页面代理
#pragma mark - CustomDelegate
// button、gesture, etc

//私有方法
#pragma mark - Private methods

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

// 弹出警告框
- (void)showTitle:(NSString *)title
          message:(NSString *)message
      titleButton:(NSString *)titleBth
{
    UIAlertView *alertView   = [[UIAlertView alloc]
                                initWithTitle:title
                                message:message
                                delegate:nil
                                cancelButtonTitle:nil
                                otherButtonTitles:titleBth, nil];
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];
}

//公有方法
#pragma mark - Public methods

//set和get方法
#pragma mark - Getters and Setters
// initialize views here, etc

- (void)downloadAnimation
{
    
    NSArray* windows = [UIApplication sharedApplication].windows;
    UIWindow *window = [windows objectAtIndex:0];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (int i=0; i<5; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"loading%d@2x",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
    }
    
    UIView *downloadImageViewTwo = (UIView *)[window viewWithTag:8888];
    if (downloadImageViewTwo)
    {
        [downloadImageViewTwo removeFromSuperview];
        downloadImageViewTwo = nil;
    }
    
    UIImageView *downloadImageView = [[UIImageView alloc]initWithFrame:CGRectMake((__kScreenWidth__-100)/2, (__kScreenHeight__-100)/2, 100, 100)];
    downloadImageView.animationImages =imageArray;
    
    //设置动画播放时间
    downloadImageView.animationDuration = 1.5;
    //开始播放动画
    [downloadImageView startAnimating];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__)];
    [bgView addSubview:downloadImageView];
    bgView.tag = 8888;
    [window addSubview:bgView];
    
}

- (void)stopDownloadAnimation
{
    NSArray* windows = [UIApplication sharedApplication].windows;
    UIWindow *window = [windows objectAtIndex:0];
    
    UIView *downloadImageView = (UIView *)[window viewWithTag:8888];
    if (downloadImageView)
    {
        [downloadImageView removeFromSuperview];
        downloadImageView = nil;
    }
}

- (NSMutableAttributedString *)makeString:(NSString *)makeString
                        theFirstLowString:(NSString *)firstLowString
                       theSecondLowString:(NSString *)secondLowString
                               firstIndex:(NSInteger)firstIndex
{
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc]initWithString:makeString];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(firstIndex, firstLowString.length)];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(makeString.length-1-secondLowString.length, secondLowString.length)];
    return att;
}


-(void)initValueParticipate:(NSString *)str people:(NSString *)people lable:(UILabel *)lable {
    
    NSString * strSuggest = [NSString stringWithFormat:@"%@  %@",str,people];
    NSMutableAttributedString *attSuggest=[[NSMutableAttributedString alloc]initWithString:strSuggest];
    
    [attSuggest addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:__kNewSize(30)],NSForegroundColorAttributeName:[[UIColor grayColor]colorWithAlphaComponent:0.4]} range:NSMakeRange(str.length,people.length+2)];
    lable.attributedText=attSuggest;
    
}

//-(NSString *)readFMPath:(NSString *)url{
//NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
//    
//}

/**
 
 * 删除网页缓存
 
 */

-(void)removeFileManager:(NSString *)url{
    NSFileManager *fm=[NSFileManager defaultManager];
    //获取document路径
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    [fm createDirectoryAtPath:[cachesPath stringByAppendingString:@"/Caches"] withIntermediateDirectories:YES attributes:nil error:nil];
    //写入路径
    NSString *path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[url hash]]];

    [fm removeItemAtPath:path error:nil];
}

/**
 
 * 网页缓存写入文件
 
 */

- (void)writeToCache:(NSString *)url

{
    NSString * htmlResponseStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
    //创建文件管理器
    
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    //获取document路径
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    [fileManager createDirectoryAtPath:[cachesPath stringByAppendingString:@"/Caches"] withIntermediateDirectories:YES attributes:nil error:nil];
    //写入路径
    NSString *path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[url hash]]];
    [htmlResponseStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

/**
 
 * 网页缓存写入文件
 
 */

- (NSString *)readCache:(NSString *)url
{
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[url hash]]];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    return htmlString;
}
// 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
// 根据路径删除文件
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}


@end
