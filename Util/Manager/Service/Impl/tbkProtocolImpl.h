//
//  IndexProtocolImpl.h
//  LaiZhuan
//
//  Created by allen on 16/1/12.
//  Copyright © 2016年 jianjie. All rights reserved.
//

#import "AbstractAction.h"
#import "tbkProtocol.h"
#import "RequestModel.h"
#import "ResponseModel.h"
//#import "DictModel.h"

typedef NS_ENUM(NSInteger,RequestDataType) {
    RequestItemGetType,
    RequestItemCouponGetType,
    RequestUatmFavoritesGetType
};

@interface tbkProtocolImpl : AbstractAction <tbkProtocol>


@end
