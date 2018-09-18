//
//  LoginVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/19.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"

@interface LoginVC ()<UITextFieldDelegate,MyLogInClickDelegate>
{
    NSInteger strLength;//输入长度
    BOOL _isMobile;
    BOOL _isVerificationCode;
}
@property (nonatomic,strong) LoginView * logInView;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self l_Init];
    [self l_UI];
}
#pragma mark - 初始化

-(void)l_Init{
    self.baseNavigationBar.titleLabel.text = @"手机快捷登录";
    self.baseNavigationBar.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.xian.hidden = YES;
    self.myView.frame = CGRectMake(0, __kNavigationBarHeight__, __kScreenWidth__, __kOriginalHeight__);
    [self createLeftBarButtonWithImageName:@"login_icon_return" WithSelector:@selector(backAction)];

}
-(void)l_UI{
    [self.myView addSubview:self.logInView];

}
#pragma mark - Click

- (void)backAction{
  
        //登录成功跳转到
         [NOTIFCATIONCENTER postNotification:[NSNotification notificationWithName:LOGINSELECTCENTERINDEX object:nil userInfo:nil]];
        [self dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma mark - 私有方法

-(BOOL)textField:(UITextField*)textField Range:(NSRange)range String:(NSString *)string{
    
    NSInteger longPNum = 11;//!<验证码长度

    NSInteger longVer = 8;//!<验证码长度

    if(_logInView.setPhoneNumberTF == textField){
        if (range.length == 0 && string.length == 1) {
            //手机号输入长度限制
            if (textField.text.length+1 >longPNum) {
                //结束
                [_logInView.setPasswordToNumberTF becomeFirstResponder];
                return NO;
            }
            _isMobile = [self isTextLength:textField.text.length isAddOrLess:YES Authority:longPNum];
        }
        else if (range.length == 1 && string.length == 0)
        {
            _isMobile = [self isTextLength:textField.text.length isAddOrLess:NO Authority:longPNum];
        }
        
    }
    if(_logInView.setPasswordToNumberTF == textField){
        if (range.length == 0 && string.length == 1) {
            //验证码长度限制
            if (textField.text.length+1 > longVer) {
                //结束
                [textField resignFirstResponder];
                return NO;
            }
            _isVerificationCode = [self isTextLength:textField.text.length isAddOrLess:YES Authority:longVer];
        }
        else if (range.length == 1 && string.length == 0)
        {
            _isVerificationCode = [self isTextLength:textField.text.length isAddOrLess:NO Authority:longVer];
        }
        
    }
    
    if (_isMobile == YES && _isVerificationCode == YES) {
        _logInView.completeBtn.backgroundColor = [UIColor colorWithHexString:@"#ff5000"];
        _logInView.completeBtn.selected = YES;
    }else{
        _logInView.completeBtn.backgroundColor = [UIColor colorWithHexString:@"#b4b4b4"];
        _logInView.completeBtn.selected = NO;
    }
    
    return YES;
}

-(BOOL)isTextLength:(NSUInteger)len isAddOrLess:(BOOL)isAL Authority:(NSInteger)num{
    
    if (isAL == YES) {
        strLength = len+1;
    }else{
        strLength = len-1;
    }
    
    if (strLength == num) {
        
        return YES;
    }
    else if (strLength > num)
    {
        return NO;
    }
    else if (strLength < num)
    {
        return NO;
    }
    else if(strLength <= 0)
    {
        strLength = 0;
    }
    return NO;
}

#pragma mark - UITextFieldDelegate


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return [self textField:textField Range:range String:string];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    return YES;
}
#pragma mark - Delegate

-(void)myLogInClickWithType:(LogInbuttonClickType)logInType{
    switch (logInType) {
        case LogInbuttonCompleteType:
            {
                GSLog(@"LogInbuttonCompleteType");
            }
            break;
        case LogInbuttonVerificationType:
        {
            GSLog(@"LogInbuttonVerificationType");

        }
            break;
        case LogInbuttonQQType:
        {
            GSLog(@"LogInbuttonQQType");

        }
            break;
        case LogInbuttonWXType:
        {
            GSLog(@"LogInbuttonWXType");

        }
            break;
        case LogInbuttonTBType:
        {
            GSLog(@"LogInbuttonTBType");
            [self l_loginTB];
        }
            break;
        default:
            break;
    }
}
-(void)l_loginTB{
      
//    if(![[ALBBSession sharedInstance] isLogin]){
        ALBBSDK *albbSDK = [ALBBSDK sharedInstance];
        [albbSDK setAppkey:__al_BC_AppKey__];
        [albbSDK setAuthOption:NormalAuth];
        [albbSDK auth:self successCallback:^(ALBBSession *session) {
            NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[[session getUser] ALBBUserDescription]];
            NSLog(@"%@", tip);
//            [self initWithName:[session getUser].nick icon:[session getUser].avatarUrl];
            [TBUSerModel userModel].login = @"1";

            [[MyAlertView alertViewWithTitle:@"登录成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            [self backAction];
        } failureCallback:^(ALBBSession *session, NSError *error) {
            NSString *tip=[NSString stringWithFormat:@"登录失败:%@",@""];
            
            NSLog(@"%@", tip);
            [[MyAlertView alertViewWithTitle:@"登录失败" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }];
    
//    }else{
//        ALBBSession *session=[ALBBSession sharedInstance];
//        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[[session getUser] ALBBUserDescription]];
//        [TBUSerModel userModel].login = @"1";
//        NSLog(@"%@\n%@", tip ,[session getUser].nick);
////        [self initWithName:[session getUser].nick icon:[session getUser].avatarUrl];
//        [[MyAlertView alertViewWithTitle:@"登录成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
//    }
}
#pragma mark - UI

-(LoginView *)logInView{
    if (!_logInView) {
        _logInView = [[LoginView alloc]init];
        _logInView.frame = CGRectMake(0, 0, __kScreenWidth__, __kOriginalHeight__);
        _logInView.setPhoneNumberTF.delegate = self;
        _logInView.setPasswordToNumberTF.delegate = self;
        _logInView.delegate = self;
        
    }
    return _logInView;
}
@end
