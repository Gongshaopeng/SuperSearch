//
//  NSString+SHA1Addiction.m
//  Meitu
//
//  Created by allen on 15/10/19.
//  Copyright © 2015年 com.juwan. All rights reserved.
//

#import "NSString+SHA1Addiction.h"
#import <CommonCrypto/CommonDigest.h>

#if __has_feature(objc_arc)
#define SAFE_AUTORELEASE(a) (a)
#else
#define SAFE_AUTORELEASE(a) [(a) autorelease]
#endif

@implementation NSString (SHA1Addiction)
- (NSString*) stringFromSHA1
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *outStr = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    for (int i = 0 ; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [outStr appendFormat:@"%02x",digest[i]];
    }
    return outStr;
}

- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return SAFE_AUTORELEASE(outputString);
}
@end
