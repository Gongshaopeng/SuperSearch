//
//  NetworkManager.h
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkManager : NSObject

+(AFHTTPSessionManager *)sharedHTTPSession;

+(AFURLSessionManager *)sharedURLSession;

@end
