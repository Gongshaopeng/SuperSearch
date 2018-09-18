//
//  searchProtocolLmpl.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/13.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "searchProtocolLmpl.h"
#import "CustomRequestManager.h"

@implementation searchProtocolLmpl


- (void)r_Search_DgItemCouponGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
    [self startRequestWithAPI:__API_dg_Item_coupon_get__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_UatmFavoritesGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
    [self startRequestWithAPI:__API_uatm_favorites_get__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_UatmFavoritesItemGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
    [self startRequestWithAPI:__API_uatm_favorites_item_get__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_TpwdCreate:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
    [self startRequestWithAPI:__API_tpwd_create__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_ItmeGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
     [self startRequestWithAPI:__API_Item_get__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_EditConfig:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
       [self startRequestWithAPI:__API_EditConfig__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_UatmFavorites:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
     [self startRequestWithAPI:__API_UatmFavorites__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_RebateOrderGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
      [self startRequestWithAPI:__API_rebate_order_get__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_ItemGuessLike:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
      [self startRequestWithAPI:__API_Item_guess_like__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_SpreadGet:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
     [self startRequestWithAPI:__API_spread_get__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_WirelessShareTpwdQuery:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
     [self testIP_RequestWithAPI:__API_Wireless_Share_Tpwd_Query__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_Search_WirelessShareTpwdCreate:(RequestModel *)paramDto complete:(void (^)(ResponseModel *model))complete failed:(void (^)(RequestFailedError error))failed{
     [self testIP_RequestWithAPI:__API_Wireless_Share_Tpwd_Create__ requestModel:paramDto completed:complete failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}

/**
 *  @author Allen, 16-05-31 10:05:52
 *
 *  @brief 淘宝客 —— 数据请求统一入口
 *
 *  @param api           api
 *  @param requestModel  RequestModel, 可为nil
 *  @param complete      成功回调
 *  @param failed        失败回调
 *  @param requestMethod RequestMethod:RequestMethodPost,RequestMethodGet
 */
- (void)startRequestWithAPI:(NSString *)api requestModel:(RequestModel *)requestModel completed:(void (^)(ResponseModel *rModle))complete failed:(void (^)(RequestFailedError error))failed method:(RequestMethod)requestMethod Signature:(RequestSignature)signature{
    
    requestModel = requestModel?:[RequestModel standardModel];
//    requestModel.method = api;
    NSString * url = [NSString stringWithFormat:@"%@/%@",__kBase_Https_Url__,api];
    [self startRequestURL:url RequestModel:requestModel completed:complete failed:failed method:requestMethod Signature:signature];
}
- (void)testIP_RequestWithAPI:(NSString *)api requestModel:(RequestModel *)requestModel completed:(void (^)(ResponseModel *rModle))complete failed:(void (^)(RequestFailedError error))failed method:(RequestMethod)requestMethod Signature:(RequestSignature)signature{
    
    requestModel = requestModel?:[RequestModel standardModel];
    //    requestModel.method = api;
    NSString * url = [NSString stringWithFormat:@"%@/%@",__kTEST_IP_Https_Url__,api];
    [self startRequestURL:url RequestModel:requestModel completed:complete failed:failed method:requestMethod Signature:signature];
}
-(void)startRequestURL:(NSString *)url RequestModel:(RequestModel *)requestModel completed:(void (^)(ResponseModel *rModle))complete failed:(void (^)(RequestFailedError error))failed method:(RequestMethod)requestMethod Signature:(RequestSignature)signature
{
    
    NSMutableDictionary *mParamDic = [NSMutableDictionary returnToDictionaryWithModel:requestModel];
    
    if (requestModel.data != nil && requestModel.data.allKeys.count != 0) {
        [mParamDic addEntriesFromDictionary:requestModel.data];
    }
    
    CustomRequestManager* manager = [CustomRequestManager sharedManager];
    [manager startRequestWithUrl:url parameters:mParamDic completed:^(NSDictionary *dic)
     {
         ResponseModel *model = [ResponseModel instanceFromJSONDictionary:dic];
        GSLog(@"返回值：%@",dic);
         if ([model.Status integerValue] == 1) {
             if (model.Datas != nil) {
                 if (complete) {
                     complete(model);
                 }
             }else{
                 failed(RequestFailedNoDataType);
             }
         }else{
             if ([model.Count integerValue] == 0) {
                 [EasyTextView showErrorText:@"没有更多数据了！" config:^EasyTextConfig *{
                return [EasyTextConfig shared].setBgColor([UIColor colorWithHexString:@"#000000"] ).setTitleColor([UIColor colorWithHexString:@"#ffffff"]).setShadowColor([UIColor clearColor]).setAlphaBG(0.8);
                 }];
                 failed(RequestFailedNoDataType);

             }else{
                 [EasyTextView showErrorText:@"网络错误！试试再刷新一下吧！" config:^EasyTextConfig *{
                     return [EasyTextConfig shared].setBgColor([UIColor colorWithHexString:@"#4c4c4c"]).setTitleColor([UIColor colorWithHexString:@"#ffffff"]).setShadowColor([UIColor clearColor]);
                 }];
                 failed(RequestFailedNoNetworkType);

             }

         }

         
     } failed:^(NSString * error) {
         failed(RequestFailedNoDataType);
//         [EasyTextView showErrorText:errorStr];

     } method:requestMethod Signature:signature];
}
@end
