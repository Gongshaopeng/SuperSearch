//
//  UIView+Addition.h
//  THCustomer
//
//  Created by lichentao on 13-8-11.
//  Copyright (c) 2013年 efuture. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kScreenScale(__PARA)      (((__PARA)/320.0f)*(kScreenWidth))

@interface UIView (Addition)
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/*取消阴影*/
- (void)hideShadow;

/*设置阴影*/
- (void)shadowColor:(UIColor*)color shadowOffset:(CGSize)offset shadowRadius:(CGFloat)radius shadowOpacity:(CGFloat)opacity;

/*设置圆角*/
- (void)cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

/*既有圆角又有阴影*/
- (void)shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset shadowRadius:(CGFloat)sradius shadowOpacity:(CGFloat)opacity
	   cornerRadius:(CGFloat)cradius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor;

@end
