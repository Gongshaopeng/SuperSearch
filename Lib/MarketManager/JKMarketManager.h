//
//  MarketManager.h
//  MT
//
//  Created by jianjie on 16/6/24.
//  Copyright © 2016年 jianjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JKMarketDefine.h"

typedef enum : NSUInteger {
    JKMarketSizeTypeFour,
    JKMarketSizeTypeSix,
    JKMarketSizeTypePlus,
    JKMarketSizeTypeX
} JKMarketSizeType;

@interface JKMarketManager : NSObject

+ (instancetype)showJKMarketManager;

- (CGFloat)translationSize:(CGFloat)pxSize;

- (CGFloat)translationSize:(CGFloat)pxSize marketSizeType:(JKMarketSizeType)marketSizeType;
@end
