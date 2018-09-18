//
//  BaseViewController.h
//  TESTDome
//
//  Created by 巩继鹏 on 16/6/7.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationBar.h"
typedef enum : NSUInteger
{
     //popController
    popControllerType,
    //ToController
    UserCenterControllerType,
    //RootController
    RootControllerType,
}
popViewControllerType;

typedef enum : NSUInteger
{
    //首页
   SuperSearchType,
    //高额优惠
    HighdiscountType,
    //购物车
   GoodsCartsType,
    //个人中心
    UserCenterType,
    //搜索
    SearchType,
    //商品列表
   GoodsSetType,
    //登录页
   LogInType,
}
CheckActionType;



@interface BaseViewController : UIViewController<UIAlertViewDelegate>
@property (nonatomic, assign) popViewControllerType popVCType;//!<Pop返回
@property (nonatomic, assign) CheckActionType checkType;//!<来源

@property (nonatomic,strong) BaseNavigationBar * _Nullable  baseNavigationBar;
@property (nonatomic, strong) UIView* myView;//最底层的view
@property (nonatomic, strong) UIView* xian;//!<线



//是否隐藏Navi
-(void)hideNavigationBar:(BOOL)isHide;

- (void)createRightBarButtonWithImageName:(NSString *)imageName WithSelector:(SEL)selector;
- (void)createRightBarButtonWithRightBarButton:(NSString *)btnName WithSelector:(SEL)selector;
- (void)createRightBarButton:(NSString *)btnName textColor:(UIColor *)textColor WithSelector:(SEL)selector;
- (void)createRightBarButtonWithLeftBarButton:(NSString *)btnName WithSelector:(SEL)selector;
- (void)createLeftBarButtonWithImageName:(NSString *)imageName WithSelector:(SEL)selector;
- (void)createLeftBarButton:(NSString *)btnName img:(NSString *)leftImg WithSelector:(SEL)selector;

- (void)createRightBarButton:(NSString *)btnName WithSelector:(SEL)selector;
- (void)createRightBarButton:(NSString *)btnName colorWithHexString:(NSString *)colorStr WithSelector:(SEL)selector;
- (void)createRightBarButton:(NSString *)btnName textColor:(UIColor *)textColor font:(CGFloat)font WithSelector:(SEL)selector;
- (void)createRightBarButton:(NSString *)btnName textColor:(UIColor *)textColor font:(CGFloat)font frame:(CGRect)frame WithSelector:(SEL)selector;


- (void)createLeftBarButtonWithImageName:(NSString *)imageName BtnAdjacent:(NSString *)btnAdName WithSelector:(SEL)selector WithBtnAdSelector:(SEL)adSelector;
- (void)createLeftBarButton:(NSString *)btnName img:(NSString *)leftImg rightBtn:(NSString *)rName WithSelector:(SEL)selector WithRightSelector:(SEL)selectorR;


@end
