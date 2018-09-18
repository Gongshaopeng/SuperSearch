//
//  LoginView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/19.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#define __kAuthCodeCountdown__ 60

#import "LoginView.h"

static NSInteger _countdown = __kAuthCodeCountdown__;

@interface LoginView ()
{
    NSTimer * _timer;

}

@end
@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self l_Init];
        [self l_UI];
        [self l_frame];
        [self l_layer];
        [self l_threeLogin];
    }
    return self;
}
-(void)l_Init{
    
}
-(void)l_UI{
    [self addSubview:self.iconImage];
    [self addSubview:self.setPhoneNumberTF];
    [self addSubview:self.setPasswordToNumberTF];
    [self addSubview:self.verificationBtn];
    [self addSubview:self.completeBtn];
    [self addSubview:self.shuoming];
    [self addSubview:self.xianTiao];
    [self addSubview:self.thirdPartyTitle];
    
    [self addSubview:self.wxLoginBtn];
    [self addSubview:self.qqLoginBtn];
    [self addSubview:self.tbLoginBtn];

}

-(void)l_frame{
    
    [_iconImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(__kNewSize(74));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(144), __kNewSize(144)));
    }];
    [_setPhoneNumberTF makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.mas_bottom).offset(__kNewSize(60));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(630), __kNewSize(100)));
    }];
    [_setPasswordToNumberTF makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setPhoneNumberTF.mas_bottom).offset(2);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(630), __kNewSize(100)));
    }];
    [_verificationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setPhoneNumberTF.mas_bottom).offset(__kNewSize(0));
        make.left.mas_equalTo(__kScreenWidth__-__kNewSize(224));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(224), __kNewSize(100)));
    }];
    [_completeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setPasswordToNumberTF.mas_bottom).offset(__kNewSize(62));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(630), __kNewSize(84)));
    }];
    [_shuoming makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_completeBtn.mas_bottom).offset(__kNewSize(36));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(630), __kNewSize(24)));
    }];
    
    [_xianTiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shuoming.mas_bottom).offset(__kNewSize(265+12));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(476), __kNewSize(1)));
    }];
    [_thirdPartyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shuoming.mas_bottom).offset(__kNewSize(265));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(256), __kNewSize(24)));
    }];
    [_wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdPartyTitle.mas_bottom).offset(__kNewSize(52));
        make.left.mas_equalTo(self.mas_left).offset(__kNewSize(117));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(100)));
    }];
    [_qqLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdPartyTitle.mas_bottom).offset(__kNewSize(52));
        make.left.mas_equalTo(_wxLoginBtn.mas_right).offset(__kNewSize(108));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(100)));
    }];
    [_tbLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdPartyTitle.mas_bottom).offset(__kNewSize(52));
        make.left.mas_equalTo(_qqLoginBtn.mas_right).offset(__kNewSize(108));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(100)));
    }];
}

-(void)l_layer{
    [self leftLayerButton:_verificationBtn];

}

-(void)l_threeLogin{
    if ([GSUMLogin setLogin].isWx) {
        self.wxLoginBtn.hidden = NO;
    }else{
        self.wxLoginBtn.hidden = YES;
    }
    if ([GSUMLogin setLogin].isQQ) {
        self.qqLoginBtn.hidden = NO;
    }else{
        self.qqLoginBtn.hidden = YES;

    }
    if ([GSUMLogin setLogin].isTB) {
        self.tbLoginBtn.hidden = NO;
    }else{
        self.tbLoginBtn.hidden = YES;
    }
    if(self.tbLoginBtn.hidden == self.wxLoginBtn.hidden == self.qqLoginBtn.hidden == YES){
        _xianTiao.hidden = YES;
        _thirdPartyTitle.hidden = YES;
    }
    
}

-(void)leftLayerButton:(UIButton *)button{
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(__kNewSize(6), __kNewSize(100-50)/2, __kNewSize(2), __kNewSize(50));
    leftBorder.backgroundColor = [UIColor colorWithHexString:@"#c6c6c6"].CGColor;
    [button.layer addSublayer:leftBorder];
}
-(void)bottomLayer:(UITextField *)tefid{
    CALayer * bootmBorder = [CALayer layer];
    bootmBorder.frame = CGRectMake(0,__kNewSize(98), __kScreenWidth__-__kNewSize(60), __kNewSize(1));
    bootmBorder.backgroundColor = [UIColor colorWithHexString:@"#c6c6c6"].CGColor;
    [tefid.layer addSublayer:bootmBorder];
}

#pragma mark - 初始化UI
-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        _iconImage.image = [UIImage imageNamed:@"login_icon_logo"];
    }
    return _iconImage;
}
-(GsTextField *)setPhoneNumberTF{
    if (_setPhoneNumberTF == nil) {
        _setPhoneNumberTF = [[GsTextField alloc]init];
         _setPhoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
        _setPhoneNumberTF.placeholder = @"请输入手机号";
//        UILabel *leftLable = [[UILabel alloc] init];
//        UIView * lefView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kNewSize(138), __kNewSize(100))];
       _setPhoneNumberTF.leftLable.frame = CGRectMake(0, 0, __kNewSize(128), __kNewSize(100));
       _setPhoneNumberTF. leftLable.text = @"手机号码";
        _setPhoneNumberTF.leftLable.textAlignment = NSTextAlignmentLeft;
        _setPhoneNumberTF.leftLable.font = [UIFont systemFontOfSize:__kNewSize(28)];
        _setPhoneNumberTF.leftLable.textColor = [UIColor colorWithHexString:@"#333333"];
        _setPhoneNumberTF.clearButtonMode = UITextFieldViewModeAlways;
        _setPhoneNumberTF.font = [UIFont systemFontOfSize:__kNewSize(28)];
    }
    return _setPhoneNumberTF;
}

-(GsTextField *)setPasswordToNumberTF{
    if (_setPasswordToNumberTF == nil) {
        _setPasswordToNumberTF = [[GsTextField alloc]init];
        _setPasswordToNumberTF.keyboardType = UIKeyboardTypeNumberPad;
        _setPasswordToNumberTF.placeholder = @"请输入验证码";
        //        UILabel *leftLable = [[UILabel alloc] init];
        //        UIView * lefView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kNewSize(138), __kNewSize(100))];
        _setPasswordToNumberTF.leftLable.frame = CGRectMake(0, 0, __kNewSize(128), __kNewSize(100));
        _setPasswordToNumberTF. leftLable.text = @"验证码";
        _setPasswordToNumberTF.leftLable.textAlignment = NSTextAlignmentLeft;
        _setPasswordToNumberTF.leftLable.font = [UIFont systemFontOfSize:__kNewSize(28)];
        _setPasswordToNumberTF.leftLable.textColor = [UIColor colorWithHexString:@"#333333"];
     
//        _setPasswordToNumberTF.clearButtonMode = UITextFieldViewModeAlways;
        _setPasswordToNumberTF.font = [UIFont systemFontOfSize:__kNewSize(28)];
    }
    return _setPasswordToNumberTF;
}

-(UIButton *)completeBtn{
    if (_completeBtn == nil) {
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(32)];
        [_completeBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _completeBtn.backgroundColor = [UIColor colorWithHexString:@"#ff5000"];
        _completeBtn.layer.cornerRadius =__kNewSize(84/2);
        [_completeBtn addTarget:self action:@selector(completeClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _completeBtn;
}
-(UIButton *)verificationBtn{
    if (_verificationBtn == nil) {
        _verificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _verificationBtn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(24)];
        [_verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verificationBtn setTitleColor:[UIColor colorWithHexString:@"#ff5000"] forState:UIControlStateNormal];
        _verificationBtn.backgroundColor = [UIColor whiteColor];
        _verificationBtn.layer.cornerRadius = 2;
        [_verificationBtn addTarget:self action:@selector(verificationClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verificationBtn;
}

-(UILabel *)shuoming{
    if (!_shuoming) {
        _shuoming = [[UILabel alloc]init];
        _shuoming.text = @"说明：未注册的用户，系统将自动创建手机账户";
        _shuoming.textAlignment = NSTextAlignmentCenter;
        _shuoming.font = [UIFont systemFontOfSize:__kNewSize(24)];
        _shuoming.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _shuoming;
}
-(UIButton *)userProtocolBtn{
    if (_userProtocolBtn == nil) {
        _userProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _userProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(26)];
        [_userProtocolBtn setTitle:@"麻雀用户协议" forState:UIControlStateNormal];
        [_userProtocolBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        _userProtocolBtn.backgroundColor = [UIColor clearColor];
        //        _userProtocolBtn.layer.cornerRadius = 2;
        CALayer * leftBorder = [CALayer layer];
        leftBorder.frame = CGRectMake(0,__kNewSize(26), __kNewSize(160), __kNewSize(1));
        leftBorder.backgroundColor = [UIColor colorWithHexString:@"#777777"].CGColor;
        [_userProtocolBtn.layer addSublayer:leftBorder];
        
    }
    return _userProtocolBtn;
}
#pragma mark - 第三方登录UI

-(UILabel *)thirdPartyTitle{
    if (_thirdPartyTitle == nil) {
        _thirdPartyTitle = [[UILabel alloc]init];
        _thirdPartyTitle.text = @"使用第三方账号注册";
        _thirdPartyTitle.font = [UIFont systemFontOfSize:__kNewSize(24)];
        _thirdPartyTitle.textColor = [UIColor colorWithHexString:@"#999999"];
        _thirdPartyTitle.textAlignment = NSTextAlignmentCenter;
        _thirdPartyTitle.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _thirdPartyTitle;
}

-(UILabel *)xianTiao{
    if (_xianTiao == nil) {
        _xianTiao = [[UILabel alloc]init];
        _xianTiao.backgroundColor = [UIColor colorWithHexString:@"#c6c6c6"];
    }
    return _xianTiao;
}

-(UIButton *)qqLoginBtn{
    if (_qqLoginBtn == nil) {
        
        _qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_weibo"] forState:UIControlStateNormal];
        _qqLoginBtn.layer.cornerRadius = __kNewSize(100/2);
        [_qqLoginBtn addTarget:self action:@selector(qqClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _qqLoginBtn;
}

-(UIButton *)wxLoginBtn{
    if (_wxLoginBtn == nil) {
        
        _wxLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_wechat"] forState:UIControlStateNormal];
        _wxLoginBtn.layer.cornerRadius = __kNewSize(100/2);
        [_wxLoginBtn addTarget:self action:@selector(wxClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _wxLoginBtn;
}
-(UIButton *)tbLoginBtn{
    if (_tbLoginBtn == nil) {
        
        _tbLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tbLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_tb"] forState:UIControlStateNormal];
        _tbLoginBtn.layer.cornerRadius = __kNewSize(100/2);
        [_tbLoginBtn addTarget:self action:@selector(tbClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _tbLoginBtn;
}

#pragma mark - Click集合

- (void)verificationClick{
    NSLog(@"获取验证码");
    if ( [self phoneNumber:_setPhoneNumberTF.text] == YES) {
//        [_setPasswordToNumberTF becomeFirstResponder];
        
        self.clickType = LogInbuttonVerificationType;
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(authCodeTimer) userInfo:nil repeats:YES];
            [_timer fire];
            _verificationBtn.enabled = NO;
            
        }
        //    _verificationView.verificationBtn.enabled = YES;
        //    _verificationView.verificationBtn.backgroundColor = [UIColor redColor];
    }
}
-(void)authCodeTimer{
    if (_countdown != 0) {
        [_verificationBtn setTitle:[NSString stringWithFormat:@"%lu秒重新获取",(long)_countdown] forState:UIControlStateNormal];
        NSLog(@"%lu",(long)_countdown);
        _countdown--;
        [_verificationBtn setTitleColor:[UIColor colorWithHexString:@"#bbbbbb"] forState:UIControlStateNormal];
        
        
    }else{
        
        [self stopTimeVer];
    }
}
-(void)stopTimeVer{
    [_verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verificationBtn setTitleColor:[UIColor colorWithHexString:@"#de3031"] forState:UIControlStateNormal];
    [_timer invalidate];
    _timer = nil;
    _countdown = __kAuthCodeCountdown__;
    _verificationBtn.enabled = YES;
    
}

- (void)completeClick{
    NSLog(@"登录");
    if ( [self phoneNumber:_setPhoneNumberTF.text] == YES) {
        if ( [self verificationNum:_setPasswordToNumberTF.text] == YES) {
            if (_completeBtn.selected == YES) {
                _completeBtn.selected = NO;
//                [ShowRemindTool newPlayHUD:self.myView text:@"登录中..."];
//                [self keyboardHideClick];
                self.clickType = LogInbuttonCompleteType;
            }
            }
        }
}
- (void)qqClick{
    self.clickType = LogInbuttonQQType;
    [[GSUMLogin setLogin] getUserInfoForPlatform:UMSocialPlatformType_QQ];
}
- (void)wxClick{
    self.clickType = LogInbuttonWXType;
    [[GSUMLogin setLogin] getUserInfoForPlatform:UMSocialPlatformType_WechatTimeLine];

}
- (void)tbClick{
    self.clickType = LogInbuttonTBType;
}

#pragma mark - delegate
-(void)setClickType:(LogInbuttonClickType)clickType{
    if ([self.delegate respondsToSelector:@selector(myLogInClickWithType:)])
    {
        [self.delegate myLogInClickWithType:clickType];
    }
}

-(BOOL)phoneNumber:(NSString *)pNumber{
    if (pNumber.length == 0) {
        [EasyTextView showErrorText:@"手机号不能为空！" config:^EasyTextConfig *{
            return [EasyTextConfig shared].setStatusType(TextStatusTypeNavigation) ;
        }];
        return NO;
    }
    if (![Helper justMobile:pNumber])
    {
        [EasyTextView showErrorText:@"手机号格式有误！" config:^EasyTextConfig *{
            return [EasyTextConfig shared].setStatusType(TextStatusTypeNavigation) ;
        }];
        return NO;
    }
    return YES;
}
-(BOOL)verificationNum:(NSString *)verifNum{
    if (verifNum.length == 0) {
        [EasyTextView showErrorText:@"验证码不能为空！" config:^EasyTextConfig *{
            return [EasyTextConfig shared].setStatusType(TextStatusTypeNavigation) ;
        }];
        return NO;
    }
    return YES;
}


@end
