//
//  CacheManager.m
//  YMSP
//
//  Created by allen on 15/6/12.
//  Copyright (c) 2015年 Youmei. All rights reserved.
//

#import "CacheManager.h"
#import "NSString+MD5Addition.h"
static NSInteger cacheMaxCacheAge = 60*60*24*7; // 1 week

@implementation CacheManager
{
    NSString* _cachePath;
    NSMutableDictionary* _memCacheDic;
}
+(CacheManager*) sharedManager{
    static CacheManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
- (id)init
{
    self = [super init];
    if (self) {
        _memCacheDic = [[NSMutableDictionary alloc] init];
        NSFileManager* fm = [NSFileManager defaultManager];
        _cachePath = [[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Cache"]] copy];
        [fm createDirectoryAtPath:_cachePath withIntermediateDirectories:YES attributes:nil error:nil];
#if 1
#if TARGET_OS_IPHONE
        // Subscribe to app events
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanDisk)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0
        UIDevice *device = [UIDevice currentDevice];
        if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported)
        {
            // When in background, clean memory in order to have less chance to be killed
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(clearMemory)
                                                         name:UIApplicationDidEnterBackgroundNotification
                                                       object:nil];
        }
#endif
#endif
#endif
    }
    return self;
}
/**
 *  从缓存字典中获取数据,如不存在,从本地获取
 *
 *  @param keyName URL字符串
 *
 *  @return 有可能是空值
 */
-(NSData*) cacheWithKeyName:(NSString*) keyName{
    NSString* md5FromKeyName = [keyName stringFromMD5];
    NSData* data = [_memCacheDic valueForKey:md5FromKeyName];
    if (!data) {
        NSString* filePath = [_cachePath stringByAppendingPathComponent:md5FromKeyName];
        data = [NSData dataWithContentsOfFile:filePath];
        [_memCacheDic setValue:data forKey:md5FromKeyName];
    }
    return data;
}
-(void) writeCache:(NSData*) data withKeyName:(NSString*) keyName cacheStrategy:(CacheStrategy) cacheStrategy{
    NSString* md5FromKeyName = [keyName stringFromMD5];
    NSString* filePath = nil;
    switch (cacheStrategy) {
        case CacheStrategyDisk:{
            filePath = [_cachePath stringByAppendingPathComponent:md5FromKeyName];
            [data writeToFile:filePath atomically:YES];
            [_memCacheDic setValue:data forKey:md5FromKeyName];
        }
            break;
        case CacheStrategyMemory:
        {
            [_memCacheDic setValue:data forKey:md5FromKeyName];
        }
            break;
        default:
            break;
    }
}

-(void) clearMemory{
    [_memCacheDic removeAllObjects];
}
-(void) cleanCacheFromDisk:(NSString*) directoryName{
    NSString* directoryPath = [_cachePath stringByAppendingPathComponent:directoryName];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:directoryPath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}
/**
 *  清理时间超过7天的本地缓存
 */
-(void) cleanDisk {
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-cacheMaxCacheAge];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:_cachePath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [_cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        if ([[[attrs fileModificationDate] laterDate:expirationDate] isEqualToDate:expirationDate])
        {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
}

@end
