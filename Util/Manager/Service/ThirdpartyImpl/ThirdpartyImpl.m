//
//  RequestNetWork.m
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/3/23.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import "ThirdpartyImpl.h"
#import "CustomRequestManager.h"

@implementation ThirdpartyImpl

#pragma mark - 请求分流

//邀请收徒
- (void)t_requestSinaShortUrl:(ThirdPartyBean *)paramDto complete:(void (^)(ThirdPartyModel *))complete failed:(void (^)(NSString *))failed
{
    [self signRequestWithAPI:nil requestModel:paramDto completed:complete failed:failed method:RequestMethodGet Signature:RequestDonotsignType];
}

#pragma mark - 入口

//更新加密入口
- (void)signRequestWithAPI:(NSString *)api requestModel:(ThirdPartyBean *)requestModel completed:(void (^)(ThirdPartyModel *))complete failed:(void (^)(NSString *))failed method:(RequestMethod)requestMethod Signature:(RequestSignature)signature{
    requestModel = requestModel?:[ThirdPartyBean standardBean];
    //    requestModel.api = api;
    
  
    
    [self startSignIntegralURL:__kUrl_Sina_Short Request:requestModel completed:complete failed:failed method:requestMethod Signature:signature];

}

#pragma mark - 请求


-(void)startSignIntegralURL:(NSString *)url Request:(ThirdPartyBean *)requestModel  completed:(void (^)(ThirdPartyModel *))complete failed:(void (^)(NSString *))failed method:(RequestMethod)requestMethod Signature:(RequestSignature)signature
{
    
    NSMutableDictionary *mParamDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                     //                                                                                     @"ver":requestModel.ver,
                                                                                     //                                                                                     @"sign":requestModel.sign,
                                                                                     //                                                                                     @"pageSize":requestModel.pageSize,
                                                                                     //                                                                                     @"token":requestModel.token
                                                                                     }];
    if (requestModel.data != nil && requestModel.data.allKeys.count != 0) {
        [mParamDic addEntriesFromDictionary:requestModel.data];
    }
    CustomRequestManager* manager = [CustomRequestManager sharedManager];
    [manager startRequestWithUrl:url parameters:mParamDic completed:^(NSDictionary *dic)
     {
         
        
//                  ThirdPartyModel *model = [ThirdPartyModel instanceFromJSONDictionary:dic];
         ThirdPartyModel *model;
         
         @try {
             //             model = [[ResponseModel alloc]initWithDictionary:dic error:nil];
             for (NSDictionary *dict in dic) {
                 model = [ThirdPartyModel instanceFromJSONDictionary:dict];
             }
         }
         @catch (NSException *exception) {
             //             NSLog(@"%@",exception);
         }
         
         if (complete) {
             complete(model);
         }
         
     } failed:^(NSString *errorStr) {
         failed(errorStr);
     } method:requestMethod Signature:signature];
    
}
@end
