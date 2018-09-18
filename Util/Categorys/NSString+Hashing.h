

#import <Foundation/Foundation.h>
@interface NSString (NSString_Hashing)

//MD5加密
- (NSString *_Nullable)MD5Hash;
- (nullable NSString *)stringByAddingPercentEncodingWithAllowedCharactersUrl;

@end
