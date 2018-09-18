//
//  R_MainVCModel.h
//  Product Temp
//
//  Created by jianjie on 15/11/2.
//  Copyright © 2015年 jianjie. All rights reserved.
//

#import "JSONModel.h"

@class ResponseHeadModel;
@interface R_MainVCModel : JSONModel

/**
 *  请求服务器参数
 */
@property (nonatomic,copy) NSString* api; //!< 系统提供固定值
@property (nonatomic,copy,readonly) NSString* appkey; //!< 系统提供固定值
@property (nonatomic,copy,readonly) NSString* ver; //!< 版本号
@property (nonatomic,strong) ResponseHeadModel* headModel; //!< 服务器返回对象
@property (nonatomic,copy) NSArray * list;
@property (nonatomic,copy) NSString* channel_id;
@property (nonatomic,copy) NSString* keyword;
@property (nonatomic,assign) NSInteger count;//!< 总页数
@property (nonatomic,assign) NSInteger page;//!< 当前页数
@property (nonatomic,copy) NSString* baseMedia; //!< 图片url前缀
@property (nonatomic,readonly) NSInteger pagesize;//!< 返回页数

@end
