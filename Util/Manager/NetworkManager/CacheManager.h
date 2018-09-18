//
//  CacheManager.h
//  YMSP
//
//  Created by allen on 15/6/12.
//  Copyright (c) 2015年 Youmei. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSInteger, CacheStrategy){
    CacheStrategyNone, //!< 不缓存
    CacheStrategyDisk, //!< 缓存在本地
    CacheStrategyMemory //!< 缓存在内存
};
@interface CacheManager : NSObject
+(CacheManager*) sharedManager;

-(NSData*) cacheWithKeyName:(NSString*) keyName;

-(void) writeCache:(NSData*) data withKeyName:(NSString*) keyName cacheStrategy:(CacheStrategy) cacheStrategy;

-(void) cleanCacheFromDisk:(NSString*) directoryName;
@end
