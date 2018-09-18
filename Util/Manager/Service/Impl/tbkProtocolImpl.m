//
//  IndexProtocolImpl.m
//  LaiZhuan
//
//  Created by allen on 16/1/12.
//  Copyright © 2016年 jianjie. All rights reserved.
//

#import "tbkProtocolImpl.h"
#import "CustomRequestManager.h"
@class resultsModel;

@implementation tbkProtocolImpl
- (void)r_tb_TaobaoTbkSpreadGet:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed{
    [self startRequestWithAPI:@"taobao.tbk.spread.get" requestModel:paramDto completed:^(ResponseModel *rModle) {
        GSLog(@"%@",rModle);
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}

- (void)r_tb_WirelessShareTpwdQuery:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed{
    
    [self startRequestWithAPI:@"taobao.wireless.share.tpwd.query" requestModel:paramDto completed:^(ResponseModel *rModle) {
        GSLog(@"%@",rModle);
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}

- (void)r_tb_ItmeGet:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed{
   
    [self startRequestWithAPI:__API_Item_get__ fields:_Fields_Item_get_ requestModel:paramDto completed:^(ResponseModel *rModle) {
        resultsModel * model = [[resultsModel alloc]initWithDictionary:rModle.tbk_item_get_response error:nil];
        if (![model.total_results isEqualToString:@"0"])
        {
            TBKItemModel * tmodel = [[TBKItemModel alloc]initWithDictionary:model.results error:nil];
            complete(tmodel);
        }else{
            failed(@"未查询到");
        }
        
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}

- (void)r_tb_RebateOrderGet:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed{
    [self startRequestWithAPI:__API_rebate_order_get__ fields:_Fields_rebate_order_get_ requestModel:paramDto completed:^(ResponseModel *rModle) {
        GSLog(@"%@",rModle);
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}

- (void)r_tb_ItemConvert:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed{
    [self startRequestWithAPI:__API_Item_convert__ fields:_Fields_Item_convert_ requestModel:paramDto completed:^(ResponseModel *rModle) {
        GSLog(@"%@",rModle);
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_tb_TpwdCreate:(RequestModel *)paramDto complete:(void (^)(TBKItemModel *model))complete failed:(void (^)(NSString *error))failed{
    [self startRequestWithAPI:__API_tpwd_create__ fields:nil  requestModel:paramDto completed:^(ResponseModel *rModle) {
        GSLog(@"%@",rModle);
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_tb_DgItemCouponGet:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed{
    [self startRequestWithAPI:__API_dg_Item_coupon_get__ fields:nil  requestModel:paramDto completed:^(ResponseModel *rModle) {
        GSLog(@"%@",rModle);
        resultsModel * model = [[resultsModel alloc]initWithDictionary:rModle.tbk_dg_item_coupon_get_response error:nil];

//            TBKItemModel * tmodel = [[TBKItemModel alloc]initWithDictionary:rModle.results error:nil];
            complete(model);
        
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}

- (void)r_tb_UatmFavoritesGet:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed{
    [self startRequestWithAPI:__API_uatm_favorites_get__ fields:__Fields_uatm_favorites_get__  requestModel:paramDto completed:^(ResponseModel *rModle) {
        resultsModel * model = [[resultsModel alloc]initWithDictionary:rModle.tbk_uatm_favorites_get_response error:nil];
        complete(model);
//        GSLog(@"%@",rModle);
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
}
- (void)r_tb_UatmFavoritesItemGet:(RequestModel *)paramDto complete:(void (^)(resultsModel *model))complete failed:(void (^)(NSString *error))failed{
    [self startRequestWithAPI:__API_uatm_favorites_item_get__ fields:__Fields_uatm_favorites_item_get__ requestModel:paramDto completed:^(ResponseModel *rModle) {
        resultsModel * model = [[resultsModel alloc]initWithDictionary:rModle.tbk_uatm_favorites_item_get_response error:nil];
        complete(model);
         GSLog(@"%@",rModle);
    } failed:failed method:RequestMethodPost Signature:RequestDefaultType];
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
- (void)startRequestWithAPI:(NSString *)api fields:(NSString *)fields requestModel:(RequestModel *)requestModel completed:(void (^)(ResponseModel *rModle))complete failed:(void (^)(NSString *))failed method:(RequestMethod)requestMethod Signature:(RequestSignature)signature{
    
    requestModel = requestModel?:[RequestModel standardModel];
    requestModel.method = api;
    requestModel.fields = fields;

    [self startRequestURL:__kBase_Https_Url__ RequestModel:requestModel completed:complete failed:failed method:requestMethod Signature:signature];
}
- (void)startRequestWithAPI:(NSString *)api requestModel:(RequestModel *)requestModel completed:(void (^)(ResponseModel *rModle))complete failed:(void (^)(NSString *))failed method:(RequestMethod)requestMethod Signature:(RequestSignature)signature{
    
    requestModel = requestModel?:[RequestModel standardModel];
    requestModel.method = api;
    
    [self startRequestURL:@"https://eco.taobao.com/router/rest" RequestModel:requestModel completed:complete failed:failed method:requestMethod Signature:signature];
}

-(void)startRequestURL:(NSString *)url RequestModel:(RequestModel *)requestModel completed:(void (^)(ResponseModel *rModle))complete failed:(void (^)(NSString *))failed method:(RequestMethod)requestMethod Signature:(RequestSignature)signature
{

    NSMutableDictionary *mParamDic = [NSMutableDictionary returnToDictionaryWithModel:requestModel];
    
    if (requestModel.data != nil && requestModel.data.allKeys.count != 0) {
        [mParamDic addEntriesFromDictionary:requestModel.data];
    }

    CustomRequestManager* manager = [CustomRequestManager sharedManager];
    [manager startRequestWithUrl:url parameters:[self SignParam:mParamDic] completed:^(NSDictionary *dic)
     {
                  ResponseModel *model = [ResponseModel instanceFromJSONDictionary:dic];
//         GSLog(@"返回值：%@",dic);
         if (complete) {
             complete(model);
         }

     } failed:^(NSString *errorStr) {
         failed(errorStr);
     } method:requestMethod Signature:signature];
}

@end

