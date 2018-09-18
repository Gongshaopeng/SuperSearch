//
//  DetailVC.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/7.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "SubViewController.h"
#import "PanLoad.h"
@class ItemModel;
@protocol DetailVCDelegate <NSObject>

- (void)myDetailVCpop:(NSDictionary *)dict;

@end
@interface DetailVC :SubViewController  <UIWebViewDelegate, NSURLConnectionDelegate,SlideLeftOrRightDelegate>
@property (nonatomic, copy) NSString *openUrl;
@property (nonatomic, copy) NSString *num_iid;
@property (nonatomic, copy) NSString *shopTitle;
@property (nonatomic,copy) NSString *CouponInfo;//!<优惠券面额
@property (nonatomic,copy) NSString *ZkFinalPrice;//!<折扣价
@property (nonatomic,copy) NSString *PictUrl;//!<商品主图
@property (nonatomic,copy) ItemModel *model;//!<数据

@property(nonatomic, assign) id<DetailVCDelegate>delegate;

@property (strong, nonatomic) UIWebView *webView;

-(UIWebView *)getWebView;
-(void)requestloadWeb:(NSString *)url;

@end
