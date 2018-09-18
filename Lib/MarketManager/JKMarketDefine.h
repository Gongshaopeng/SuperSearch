//
//  MarketDefine.m
//  MarketManagerDemo
//
//  Created by Jackie on 2016/10/25.
//  Copyright © 2016年 Jockie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKMarketManager.h"
#pragma mark - configuration(配置)

//默认的设计尺寸
#define DefuleWidth JKMarketSizeTypeSix

//放大模式下的 放大比例
#define EnlargingScale 1.0

#pragma mark - define(定义)


#define __kIsVertical__  ([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height)

//各个机型默认宽度大小
#define JKDefule35InchScreenWidth     (__kIsVertical__?320.0:480.0)
#define JKDefule40InchScreenWidth     (__kIsVertical__?320.0:568.0)
#define JKDefule47InchScreenWidth     (__kIsVertical__?375.0:667.0)
#define JKDefule55InchScreenWidth     (__kIsVertical__?414.0:736.0)
#define JKDefule58InchScreenWidth     (__kIsVertical__?375.0:812.0)

//传入一个px尺寸  输出一个按照屏幕适配的尺寸(默认尺寸)
#define __kNewSize(pxSize) [[JKMarketManager showJKMarketManager]translationSize:pxSize]
#define __kNewFont(pxSize) [UIFont systemFontOfSize:__kNewSizeSix(pxSize)]
#define __kNewBoldFont(pxSize) [UIFont boldSystemFontOfSize:__kNewSizeSix(pxSize)]

#define __kNewCGSizeMake(pxWidth,pxHeight) CGSizeMake(__kNewSize(pxWidth), __kNewSize(pxHeight))
#define __kNewCGRectMake(pxX,pxY,pxWidth,pxHeight) CGRectMake(__kNewSize(pxX), __kNewSize(pxY), __kNewSize(pxWidth), __kNewSize(pxHeight))
// 4,5.(320)
#define __kNewSizeFour(pxSize) [[JKMarketManager showJKMarketManager]translationSize:pxSize marketSizeType:JKMarketSizeTypeFour]

// 6.(375)
#define __kNewSizeSix(pxSize) [[JKMarketManager showJKMarketManager]translationSize:pxSize marketSizeType:JKMarketSizeTypeSix]

// plus.(414)
#define __kNewSizePlus(pxSize) [[JKMarketManager showJKMarketManager]translationSize:pxSize marketSizeType:JKMarketSizeTypePlus]

//传入一个pt尺寸  输出一个按照屏幕适配的尺寸(默认尺寸)
#define __kSize(ptSize) __kNewSize(ptSize *2)
#define __kFont(ptSize) [UIFont systemFontOfSize:__kSizeSix(ptSize)]
#define __kBoldFont(ptSize) [UIFont boldSystemFontOfSize:__kSizeSix(ptSize)]


#define __kCGSizeMake(ptWidth,ptHeight) CGSizeMake(__kSize(ptWidth), __kSize(ptHeight))
#define __kCGRectMake(ptX,ptY,ptWidth,ptHeight) CGRectMake(__kSize(ptX), __kSize(ptY), __kSize(ptWidth), __kSize(ptHeight))
// 4,5.(320)
#define __kSizeFour(ptSize) [[JKMarketManager showJKMarketManager]translationSize:(ptSize*2) marketSizeType:JKMarketSizeTypeFour]

// 6.(375)
#define __kSizeSix(ptSize) [[JKMarketManager showJKMarketManager]translationSize:(ptSize*2 )marketSizeType:JKMarketSizeTypeSix]

// plus.(414)
#define __kSizePlus(ptSize) [[JKMarketManager showJKMarketManager]translationSize:(ptSize*2) marketSizeType:JKMarketSizeTypePlus]



