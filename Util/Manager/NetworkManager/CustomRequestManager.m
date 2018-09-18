//
//  CustomRequestManager.m
//
//  Created by allen on 15/6/12.
//  Copyright (c) 2015年 Youmei. All rights reserved.
//

#import "CustomRequestManager.h"
#import "AFNetworking.h"
//#import "RegexKitLite.h"
#import "NetworkManager.h"

#define __kBadNetError__ @"网络异常"

@implementation FileModel

@end
@implementation CustomRequestManager
{
    NSMutableArray* _requestArr;
}

static id _sharedInstance;
+(instancetype) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _requestArr = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)startRequestWithUrl:(NSString*) url parameters:(id)parameters completed:(RequestCompleted)completed failed:(RequestFailed)failed{
    [self startRequestWithUrl:url parameters:parameters completed:completed failed:failed method:RequestMethodPost];
}

-(void)startRequestWithUrl:(NSString*) url parameters:(id)parameters completed:(RequestCompleted)completed failed:(RequestFailed)failed method:(RequestMethod) method{
    
    [self startRequestWithUrl:url parameters:parameters completed:completed failed:failed method:method Signature:RequestDonotsignType];
}

-(void)startRequestWithUrl:(NSString*) url parameters:(id)parameters completed:(RequestCompleted)completed failed:(RequestFailed)failed method:(RequestMethod) method Signature:(RequestSignature)signature
{
    
    AFHTTPSessionManager* manager = [NetworkManager sharedHTTPSession];
 
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // 设置可以接收无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    //    GSLog(@"UserAgent%@",[IphoneType defaultUserAgentString]);
      manager.securityPolicy = securityPolicy;
//    [manager.requestSerializer setValue:[IphoneType defaultUserAgentString] forHTTPHeaderField:@"User-Agent"];

    
    switch (method) {
        case RequestMethodPost:
        {
//         NSData * data = [[CacheManager sharedManager] cacheWithKeyName:urlString];
//            if (data) {
//                NSError* error;
//                NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//                completed(dic);
//            }else{
            [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                if( responseObject != nil ){
                    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    
                    NSData * data = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
                    NSError* error;
//                    [[CacheManager sharedManager] writeCache:data withKeyName:urlString cacheStrategy:CacheStrategyDisk];
                    
                    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                    if (!dic) {
                        dic = @{@"ErrorResult":error};
                    }
                    completed(dic);
                    
                }
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                failed(__kBadNetError__);
                RequestLog(@"%@\n%@",error.domain,[error.userInfo valueForKey:@"NSLocalizedDescription"]);
            }];
//            }
        }
            break;
        case RequestMethodGet:
        {
          
            NSString* urlString = [self setDictionary:parameters TurnStrUrl:url];

            GSLog(@"GET请求Url: %@",urlString);
            
            //            [self cancelRequestsForPath:encodedUrlString];
            [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if (responseObject != nil) {
                    //                        RequestLog(@"responseStr = %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    
                    NSError* error;
                    if(responseStr != nil){
                        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
                        if (!dic) {
                            dic = @{@"error_response":error};
                        }
                        completed(dic);
                        
                    }
                    
                }
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                failed(__kBadNetError__);
                RequestLog(@"%@\n%@",error.domain,[error.userInfo valueForKey:@"NSLocalizedDescription"]);
            }];
        }
            break;
    }
}

-(NSString *)setDictionary:(NSDictionary *)parameters TurnStrUrl:(NSString *)url{
    NSMutableString* tempUrl = [NSMutableString new];
    NSDictionary* paramDic = (NSDictionary*)parameters;
    NSInteger _count = 0;
    for (NSString* dicKey in [paramDic allKeys]) {
        _count++;
        NSString* dicValue = [paramDic valueForKey:dicKey];
        dicValue = [self UrlEncodeUTF8String:dicValue];
        if (_count == 1) {
            [tempUrl appendFormat:@"%@=%@",dicKey,dicValue];
        }else{
            [tempUrl appendFormat:@"&%@=%@",dicKey,dicValue];
        }
    }
  return  [NSString stringWithFormat:@"%@?%@",url,tempUrl];

}
-(NSString *)UrlEncodeUTF8String:(NSString *)urlString{
    NSString *encodedUrlString;
    //            NSString * comUrlStr;
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0)
    {
        encodedUrlString = [encodedUrlString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        encodedUrlString = [encodedUrlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        encodedUrlString = [urlString stringByAddingPercentEncodingWithAllowedCharactersUrl];
        
    }else{
        encodedUrlString = [urlString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        encodedUrlString = [encodedUrlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        encodedUrlString = [encodedUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    GSLog(@"encodedUrlString %@",encodedUrlString);
    return encodedUrlString;
}


- (void)startUploadWithUrl:(NSString *)url parameters:(id)parameters files:(NSArray<FileModel*>*)files completed:(RequestCompleted)completed failed:(RequestFailed)failed{
    
    //    AFHTTPSessionManager* manager = [NetworkManager sharedHTTPSession];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.requestSerializer.timeoutInterval = self.timeoutInterval?:15;
    //    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //    manager.securityPolicy = securityPolicy;
    //    // 设置可以接收无效的证书
    //    [securityPolicy setAllowInvalidCertificates:YES];
    //    [securityPolicy setValidatesDomainName:NO];
    //
    //    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //        for (FileModel* fileModel in files) {
    //            [formData appendPartWithFileData:fileModel.data name:fileModel.name fileName:fileModel.fileName mimeType:fileModel.mimeType];
    //        }
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
    ////        RequestLog(@"responseStr = %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    //        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    ////        responseStr = [responseStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"null\""];
    ////        NSString *responseStrRegex = @"\"\\w+\\s{0,}\":\\s{0,}\\w+";
    ////        NSArray *regexArray = [responseStr componentsMatchedByRegex:responseStrRegex];
    ////
    ////        for (NSString *s in regexArray)
    ////        {
    ////            NSRange responseRange = [responseStr rangeOfString:s];
    ////            NSString *numStr = [NSString stringWithFormat:@"\"%@\"",[s componentsSeparatedByString:@":"][1]];
    ////            NSRange numRange = [s rangeOfString:[s componentsSeparatedByString:@":"][1]];
    ////            NSString *numReplaceStr = [s stringByReplacingCharactersInRange:numRange withString:numStr];
    ////            responseStr = [responseStr stringByReplacingCharactersInRange:responseRange withString:numReplaceStr];
    ////        }
    //        NSError* error;
    //        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //        if (!dic) {
    //            dic = @{@"ResponseError":error};
    //        }
    //
    //        completed(dic);
    //    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
    //        failed(__kBadNetError__);
    //    }];
}
- (void)cancelRequestsForPath:(NSString *)path
{
    [[NetworkManager sharedHTTPSession].tasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURLSessionDataTask *task = obj;
        if ([task.currentRequest.URL.relativePath hasSuffix:path]) {
            [task cancel];
        }
    }];
}

@end

