//
//  MyGoodsCartsVC.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/27.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "MainViewController.h"

#import "PanLoad.h"

@interface MyGoodsCartsVC : MainViewController  <UIWebViewDelegate, NSURLConnectionDelegate,SlideLeftOrRightDelegate>
@property (nonatomic, copy) NSString *openUrl;
@property (nonatomic, copy) NSString *num_iid;
@property (nonatomic, copy) NSString *shopTitle;

@property (strong, nonatomic) UIWebView *webView;

-(UIWebView *)getWebView;
-(void)requestloadWeb:(NSString *)url;
@end
