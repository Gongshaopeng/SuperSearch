//
//  NetworkManager.m
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

static AFHTTPSessionManager *manager ;
static AFURLSessionManager *urlsession ;

+(AFHTTPSessionManager *)sharedHTTPSession{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 5;
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       
    });
    return manager;
}

+(AFURLSessionManager *)sharedURLSession
{
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        urlsession = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return urlsession;
}
@end
