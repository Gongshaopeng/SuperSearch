//
//  STCModel.h
//  TESTDome
//
//  Created by 巩继鹏 on 16/6/13.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCModel : NSObject
+ (instancetype)stcModel;

/**
 * 上一个 商品 ID
 */
@property (nonatomic,strong) NSString *  lastItmeID;//!<上一个 商品 ID

/**
 *  是否弹过警告窗 1:弹过 0:没弹
 */
@property (nonatomic,assign) NSInteger isAlert;//!<是否弹过警告窗


/**
 *  当前所在控制器
 */
@property (nonatomic,assign) NSInteger vcType;//!< 搜索：1

/**
 *  当前所在控制器
 */
@property (nonatomic,assign) NSInteger openUrlType;//!< 阿里：1 友盟：0

@end

