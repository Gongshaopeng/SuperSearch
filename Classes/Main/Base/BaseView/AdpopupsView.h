//
//  AdpopupsView.h
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/11/10.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 显示弹框样式
 */
typedef NS_ENUM(NSInteger, GSPopStyle) {
    GSAnimationPopStyleNoNew = 0,               //什么都不添加
    GSAnimationPopStyleTapYes ,               ///<开启点击背景图手势
    GSAnimationPopStyledissBtn,                ///<显示关闭按钮
  
};

/**
 显示时动画弹框样式
 */
typedef NS_ENUM(NSInteger, GSAnimationPopStyle) {
    GSAnimationPopStyleNO = 0,               ///< 无动画
    GSAnimationPopStyleScale,                ///< 缩放动画，先放大，后恢复至原大小
    GSAnimationPopStyleShakeFromTop,         ///< 从顶部掉下到中间晃动动画
    GSAnimationPopStyleShakeFromBottom,      ///< 从底部往上到中间晃动动画
    GSAnimationPopStyleShakeFromLeft,        ///< 从左侧往右到中间晃动动画
    GSAnimationPopStyleShakeFromRight,       ///< 从右侧往左到中间晃动动画
    GSAnimationPopStyleCardDropFromLeft,     ///< 卡片从顶部左侧开始掉落动画
    GSAnimationPopStyleCardDropFromRight,    ///< 卡片从顶部右侧开始掉落动画
};

/**
 移除时动画弹框样式
 */
typedef NS_ENUM(NSInteger, GSAnimationDismissStyle) {
    GSAnimationDismissStyleNO = 0,               ///< 无动画
    GSAnimationDismissStyleScale,                ///< 缩放动画
    GSAnimationDismissStyleDropToTop,            ///< 从中间直接掉落到顶部
    GSAnimationDismissStyleDropToBottom,         ///< 从中间直接掉落到底部
    GSAnimationDismissStyleDropToLeft,           ///< 从中间直接掉落到左侧
    GSAnimationDismissStyleDropToRight,          ///< 从中间直接掉落到右侧
    GSAnimationDismissStyleCardDropToLeft,       ///< 卡片从中间往左侧掉落
    GSAnimationDismissStyleCardDropToRight,      ///< 卡片从中间往右侧掉落
    GSAnimationDismissStyleCardDropToTop,        ///< 卡片从中间往顶部移动消失
};

@interface AdpopupsView : UIView

/** 显示时点击背景是否移除弹框，默认为NO。 */
@property (nonatomic) BOOL isClickBGDismiss;
/** 显示时是否监听屏幕旋转，默认为NO */
@property (nonatomic) BOOL isObserverOrientationChange;
/** 显示时背景的透明度，取值(0.0~1.0)，默认为0.5 */
@property (nonatomic) CGFloat popBGAlpha;

/// 动画相关属性参数
/** 显示时动画时长，>= 0。不设置则使用默认的动画时长 */
@property (nonatomic) CGFloat popAnimationDuration;
/** 隐藏时动画时长，>= 0。不设置则使用默认的动画时长 */
@property (nonatomic) CGFloat dismissAnimationDuration;

/** 显示完成回调 */
@property (nullable, nonatomic, copy) void(^popComplete)();
/** 移除完成回调 */
@property (nullable, nonatomic, copy) void(^dismissComplete)();
/** 点击完成回调 */
@property (nullable, nonatomic, copy) void(^tapComplete)();


/**
 通过自定义视图来构造弹框视图
 
 @param customView 自定义视图
 */
- (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView
                                   popStyle:(GSAnimationPopStyle)popStyle
                               dismissStyle:(GSAnimationDismissStyle)dismissStyle
                               newStyle:(GSPopStyle)newStyle;


/**
 显示弹框
 */
- (void)pop;

/**
 移除弹框
 */
- (void)dismiss;
@end
