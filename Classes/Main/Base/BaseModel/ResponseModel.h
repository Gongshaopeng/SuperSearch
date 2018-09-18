//
//  ResponseModel.h
//  如意夺宝
//
//  Created by jianjie on 16/4/6.
//  Copyright © 2016年 com.juwang.rydb. All rights reserved.
//

#import "BaseModel.h"


@interface ResponseModel : BaseModel
@property (nonatomic,copy) NSString <Optional>*Status;
@property (nonatomic,copy) NSString <Optional>*Count;//!<总请求数
@property (nonatomic,copy) NSArray <Optional>*Datas;
@property (nonatomic,copy) NSString <Optional>*Message;
@property (nonatomic,copy) NSDictionary <Optional>*ErrorResult;



@property (nonatomic,strong) NSDictionary <Optional>*tbk_item_get_response;
@property (nonatomic,strong) NSDictionary <Optional>*tbk_dg_item_coupon_get_response;
@property (nonatomic,strong) NSDictionary <Optional>*tbk_uatm_favorites_get_response;
@property (nonatomic,strong) NSDictionary <Optional>*tbk_uatm_favorites_item_get_response;

//@property (nonatomic,copy) NSString<Optional> *Message;
@property (nonatomic,strong) NSDictionary <Optional>*error_response;

@end


@interface resultsModel : BaseModel

@property (nonatomic,copy) NSDictionary <Optional>*results;
@property (nonatomic,copy) NSString <Optional>*request_id;
@property (nonatomic,copy) NSString <Optional>*total_results;

//@property (nonatomic,copy) NSArray <Optional>*n_tbk_item;

@end

@interface TBKItemModel : BaseModel

@property (nonatomic,copy) NSArray <Optional>*n_tbk_item;
@property (nonatomic,copy) NSArray <Optional>*tbk_coupon;
@property (nonatomic,copy) NSArray <Optional>*tbk_favorites;
@property (nonatomic,copy) NSArray <Optional>*uatm_tbk_item;

@end
@interface ItemModel : BaseModel

@property (nonatomic,copy) NSString <Optional>*ShopTitle;//!<店铺名称
@property (nonatomic,copy) NSString <Optional>*Nick;//!<卖家昵称
@property (nonatomic,copy) NSString <Optional>*SellerId;//!<卖家id
@property (nonatomic,copy) NSString <Optional>*NumIid;//!<itemId
@property (nonatomic,copy) NSString <Optional>*Title;//!<商品标题
@property (nonatomic,copy) NSString <Optional>*PictUrl;//!<商品主图
@property (nonatomic,copy) NSDictionary <Optional>*SmallImages;//!<商品小图列表
@property (nonatomic,copy) NSString <Optional>*ItemDescription;//!<宝贝描述（推荐理由）
@property (nonatomic,copy) NSString <Optional>*ItemUrl;//!<商品详情页链接地址
@property (nonatomic,copy) NSString <Optional>*CouponClickUrl;//!<商品优惠券推广链接
@property (nonatomic,copy) NSString <Optional>*CouponTotalCount;//!<优惠券总量
@property (nonatomic,copy) NSString <Optional>*CouponRemainCount;//!<优惠券剩余量
@property (nonatomic,copy) NSString <Optional>*CouponStartTime;//!<优惠券开始时间
@property (nonatomic,copy) NSString <Optional>*CouponEndTime;//!<优惠券结束时间
@property (nonatomic,copy) NSString <Optional>*CouponInfo;//!<优惠券面额
@property (nonatomic,copy) NSString <Optional>*CommissionRate;//!<佣金比率(%)
@property (nonatomic,copy) NSString <Optional>*TkRate;//!<佣金比率(%)

@property (nonatomic,copy) NSString <Optional>*Volume;//!<30天销量
@property (nonatomic,copy) NSString <Optional>*ZkFinalPrice;//!<折扣价

@property (nonatomic,copy) NSString <Optional>*UserType;//!<卖家类型，0表示集市，1表示商城
@property (nonatomic,copy) NSString <Optional>*Category;//!<后台一级类目

@end

@interface TBKCouponModel : BaseModel

@property (nonatomic,copy) NSString <Optional>*ShopTitle;//!<店铺名称
@property (nonatomic,copy) NSString <Optional>*Nick;//!<卖家昵称
@property (nonatomic,copy) NSString <Optional>*SellerId;//!<卖家id
@property (nonatomic,copy) NSString <Optional>*NumIid;//!<itemId
@property (nonatomic,copy) NSString <Optional>*Title;//!<商品标题
@property (nonatomic,copy) NSString <Optional>*PictUrl;//!<商品主图
@property (nonatomic,copy) NSDictionary <Optional>*SmallImages;//!<商品小图列表
@property (nonatomic,copy) NSString <Optional>*ItemDescription;//!<宝贝描述（推荐理由）
@property (nonatomic,copy) NSString <Optional>*ItemUrl;//!<商品详情页链接地址
@property (nonatomic,copy) NSString <Optional>*CouponClickUrl;//!<商品优惠券推广链接
@property (nonatomic,copy) NSString <Optional>*CouponTotalCount;//!<优惠券总量
@property (nonatomic,copy) NSString <Optional>*CouponRemainCount;//!<优惠券剩余量
@property (nonatomic,copy) NSString <Optional>*CouponStartTime;//!<优惠券开始时间
@property (nonatomic,copy) NSString <Optional>*CouponEndTime;//!<优惠券结束时间
@property (nonatomic,copy) NSString <Optional>*CouponInfo;//!<优惠券面额
@property (nonatomic,copy) NSString <Optional>*CommissionRate;//!<佣金比率(%)
@property (nonatomic,copy) NSString <Optional>*TkRate;//!<佣金比率(%)
@property (nonatomic,copy) NSString <Optional>*Volume;//!<30天销量
@property (nonatomic,copy) NSString <Optional>*ZkFinalPrice;//!<折扣价

@property (nonatomic,copy) NSString <Optional>*UserType;//!<卖家类型，0表示集市，1表示商城
@property (nonatomic,copy) NSString <Optional>*Category;//!<后台一级类目



/*
 Category = 16;
 CommissionRate = "5.50";
 CouponClickUrl = "https://uland.taobao.com/coupon/edetail?e=u2mRpXkrUR0GQASttHIRqUEhYjmxgs95CQVKeLppAsLyi1aSyqbpmpT7kWsJc6JThGF8ZNxrGnbe5acsBXNro1kFiA80RWuQDfqEFBOhTcyRyqpGKCje6lT3AJems1KrRKDp%2BKlFfZwVue4dN28kOGPfrr0N2WBeTRpRLr83147k92%2BM7h46c4lk8zpB6D12b7myOIbHPk8%3D&traceId=0ab2019315209346723423022";
 CouponEndTime = "2018-03-15";
 CouponInfo = "\U6ee1159\U5143\U51cf20\U5143";
 CouponRemainCount = 4000;
 CouponStartTime = "2018-03-11";
 CouponTotalCount = 40000;
 ItemDescription = "2018\U6625\U88c5\U4e0a\U65b0";
 ItemUrl = "http://detail.tmall.com/item.htm?id=564810360137";
 Nick = "\U7fbd\U82b1\U98d8\U65d7\U8230\U5e97";
 NumIid = 564810360137;
 PictUrl = "http://img.alicdn.com/tfscom/i1/2051444128/TB1ydIPaNSYBuNjSsphXXbGvVXa_!!0-item_pic.jpg";
 SellerId = 2051444128;
 ShopTitle = "\U7fbd\U82b1\U98d8\U65d7\U8230\U5e97";
 SmallImages =             (
 "http://img.alicdn.com/tfscom/i4/2051444128/TB2Z3TVX1uSBuNjSsziXXbq8pXa_!!2051444128.jpg",
 "http://img.alicdn.com/tfscom/i4/2051444128/TB2FStga1uSBuNjSsplXXbe8pXa_!!2051444128.jpg",
 "http://img.alicdn.com/tfscom/i2/2051444128/TB2pM8FXAZmBKNjSZPiXXXFNVXa_!!2051444128.jpg",
 "http://img.alicdn.com/tfscom/i4/2051444128/TB2K9G4XDdYBeNkSmLyXXXfnVXa_!!2051444128.jpg"
 );
 Title = "\U6bdb\U8863\U642d\U914d\U88d9\U4e24\U4ef6\U59572018\U65b0\U6b3e\U5973\U88c5\U6625\U88c5\U65f6\U9ae6\U5957\U88c5\U6d0b\U6c14\U7f51\U7eb1\U8fde\U8863\U88d9\U6c14\U8d28\U6f6e";
 UserType = 1;
 Volume = 8272;
 ZkFinalPrice = "169.00";

 */
/*
 Category = 16;
 ClickUrl = "https://s.click.taobao.com/t?e=m%3D2%26s%3D3x5cyI%2BFiIwcQipKwQzePOeEDrYVVa64XoO8tOebS%2Bfjf2vlNIV67gmCZTe%2BlNeiP5bxJy%2F%2Fu7ggxX1619tT8aqob0ALfUoVXivjQbMTl3Yserf6nR40Ue%2FBas0tvb4eZz42eVlqqJT6BXppXS5x5z0BDlc5vrJjopr%2FSerwmYOv%2BQQ7Mc4F%2BWIqZNqbSXVkTXZPhxN7XjHv0y8ncWxM8ky7rC8U46m2xgxdTc00KD8%3D";
 CommissionRate = "<null>";
 CouponClickUrl = "<null>";
 CouponEndTime = "<null>";
 CouponInfo = "<null>";
 CouponRemainCount = 0;
 CouponStartTime = "<null>";
 CouponTotalCount = 0;
 EventEndTime = "1970-01-01 00:00:00";
 EventStartTime = "1970-01-01 00:00:00";
 ItemUrl = "http://item.taobao.com/item.htm?id=568378679065";
 Nick = roxyvip;
 NumIid = 568378679065;
 PictUrl = "https://img.alicdn.com/tfscom/i3/348631552/TB1tKT6nASWBuNjSszdXXbeSpXa_!!0-item_pic.jpg";
 Provcity = "\U4e0a\U6d77";
 ReservePrice = "265.00";
 SellerId = 348631552;
 ShopTitle = "MFHK THE ONE \U79c1\U6a71";
 SmallImages =     (
 "https://img.alicdn.com/tfscom/i3/348631552/TB2v3k5nCBYBeNjy0FeXXbnmFXa_!!348631552.jpg",
 "https://img.alicdn.com/tfscom/i2/348631552/TB2CIWTd_qWBKNjSZFxXXcpLpXa_!!348631552.jpg",
 "https://img.alicdn.com/tfscom/i1/348631552/TB2hUDSnr5YBuNjSspoXXbeNFXa_!!348631552.jpg",
 "https://img.alicdn.com/tfscom/i1/348631552/TB2i3xEdWAoBKNjSZSyXXaHAVXa_!!348631552.jpg"
 );
 Status = 1;
 Title = "MFHK\U9ad8\U7ea7\U5b9a\U5236\U4ea4\U53c9\U5305\U88f9\U5f0f\U4e0a\U8863\Uff01\U4e0a\U4e0d\U8d39\U529b\U7684\U65f6\U9ae6~\U8eab\U8f7b\U677e\U4e0e\U4f17\U4e0d\U540c\Uff01";
 TkRate = "8.00";
 Type = 1;
 UserType = 0;
 Volume = 79;
 ZkFinalPrice = "198.00";
 ZkFinalPriceWap = "198.00";
 */
@end

@interface TbkFavoritesModel : BaseModel

@property (nonatomic,copy) NSString <Optional>* type;
@property (nonatomic,copy) NSString <Optional>* favorites_id;
@property (nonatomic,copy) NSString <Optional>*favorites_title;

@end

@interface SpreadModel : BaseModel

@property (nonatomic,copy) NSString <Optional>* Content;
@property (nonatomic,copy) NSString <Optional>* ErrMsg;

@end
