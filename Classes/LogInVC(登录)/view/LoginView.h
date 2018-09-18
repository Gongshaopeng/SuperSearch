//
//  LoginView.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/19.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "BaseView.h"
#import "GsTextField.h"

typedef enum : NSUInteger
{
    //默认
    LogInbuttonType,
    //登录
    LogInbuttonCompleteType,
    //获取验证码
    LogInbuttonVerificationType,
    //QQ
    LogInbuttonQQType,
    //微信
    LogInbuttonWXType,
    //淘宝
    LogInbuttonTBType
 
}
LogInbuttonClickType;

@protocol MyLogInClickDelegate <NSObject>

- (void)myLogInClickWithType:(LogInbuttonClickType)logInType;

@end

@interface LoginView : BaseView

@property (nonatomic, assign) LogInbuttonClickType clickType;//!<点击类型
@property(nonatomic, assign) id<MyLogInClickDelegate>delegate;

@property (nonatomic,strong) UIImageView * iconImage;//!<icon
@property (nonatomic,strong) GsTextField * setPhoneNumberTF;//!<手机号
@property (nonatomic,strong) GsTextField * setPasswordToNumberTF;//!<验证码
@property (nonatomic,strong) UIButton    * completeBtn;//!<完成
@property (nonatomic,strong) UIButton * verificationBtn;//!<获取验证码
@property (nonatomic,strong) UILabel * shuoming;//!<声明
@property (nonatomic,strong) UIButton * userProtocolBtn;//!<用户协议按钮

@property (nonatomic,strong) UILabel * thirdPartyTitle;//!<第三方标题
@property (nonatomic,strong) UILabel * xianTiao;//!<线条
@property (nonatomic,strong) UIButton * qqLoginBtn;//!<QQ登录
@property (nonatomic,strong) UILabel * qqLable;//!<QQTitle
@property (nonatomic,strong) UIButton * wxLoginBtn;//!<微信登录
@property (nonatomic,strong) UILabel * wxLable;//!< 微信Title
@property (nonatomic,strong) UIButton * tbLoginBtn;//!<淘宝登录
@property (nonatomic,strong) UILabel * tbLable;//!< 淘宝Title

@end
