//
//  UserCenterVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/13.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//
#import "searchProtocolLmpl.h"

#import "UserCenterVC.h"

#import <AlibabaAuthSDK/albbsdk.h>
#import "MyAlertView.h"
#import <UIImageView+WebCache.h>

@interface UserCenterVC ()

@property (nonatomic,strong)id<searchProtocol>searchImpl;

@property (nonatomic, strong) UIButton * logInBtn;//!<登录

@property (nonatomic, strong) UIButton * logOutBtn;//!<退出登录
@property (nonatomic, strong) UIButton * dingdanBtn;//!<订单

@property (nonatomic, strong) UILabel * nameLable;//!<名字
@property (nonatomic, strong) UIImageView * iconImageView;//!<头像

@end

@implementation UserCenterVC
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.baseNavigationBar.titleLabel.text = @"我的";
     self.myView.backgroundColor = [UIColor whiteColor];
    [self c_Init];
    [self c_UI];
    [self c_Frame];
     [self m_login];
}

-(void)c_Init{
    self.searchImpl = [[searchProtocolLmpl alloc]init];

}
-(void)c_UI{
    [self.myView addSubview:self.iconImageView];
    [self.myView addSubview:self.nameLable];
    [self.myView addSubview:self.logInBtn];
    [self.myView addSubview:self.logOutBtn];
    [self.myView addSubview:self.dingdanBtn];


}
-(void)c_Frame{


    __kWeakSelf__;
    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.myView);
        make.top.mas_equalTo(weakSelf.myView.mas_top).offset(__kNewSize(90)+NavigationBarHeight);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(118), __kNewSize(118)));
    }];
    [_nameLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(__kNewSize(20));
        make.size.mas_equalTo(CGSizeMake(__kScreenWidth__, __kNewSize(40)));
    }];
        [_logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLable.mas_bottom).offset(__kNewSize(120));
            make.centerX.mas_equalTo(weakSelf.myView);
            make.size.mas_equalTo(CGSizeMake(__kScreenWidth__-__kNewSize(60), __kNewSize(90)));
        }];
        [_logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_logInBtn.mas_bottom).offset(__kNewSize(120));
            make.centerX.mas_equalTo(weakSelf.myView);
            make.size.mas_equalTo(CGSizeMake(__kScreenWidth__-__kNewSize(60), __kNewSize(90)));
        }];
    [_dingdanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_logOutBtn.mas_bottom).offset(__kNewSize(120));
        make.centerX.mas_equalTo(weakSelf.myView);
        make.size.mas_equalTo(CGSizeMake(__kScreenWidth__-__kNewSize(60), __kNewSize(90)));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)m_login{
    
    if(![[ALBBSession sharedInstance] isLogin]){
        ALBBSDK *albbSDK = [ALBBSDK sharedInstance];
        [albbSDK setAppkey:__al_BC_AppKey__];
        [albbSDK setAuthOption:NormalAuth];
        [albbSDK auth:self successCallback:^(ALBBSession *session) {
            NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[[session getUser] ALBBUserDescription]];
            NSLog(@"%@", tip);
            [self initWithName:[session getUser].nick icon:[session getUser].avatarUrl];
            [TBUSerModel userModel].login = @"1";

            [[MyAlertView alertViewWithTitle:@"登录成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        } failureCallback:^(ALBBSession *session, NSError *error) {
            NSString *tip=[NSString stringWithFormat:@"登录失败:%@",@""];
            
            NSLog(@"%@", tip);
            [[MyAlertView alertViewWithTitle:@"登录失败" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }];
    }else{
        ALBBSession *session=[ALBBSession sharedInstance];
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[[session getUser] ALBBUserDescription]];
        [TBUSerModel userModel].login = @"1";

        NSLog(@"%@\n%@", tip ,[session getUser].nick);
        [self initWithName:[session getUser].nick icon:[session getUser].avatarUrl];
        [[MyAlertView alertViewWithTitle:@"登录成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}
-(void)dingdanClick{
    
//     [GOpenUrl newOpenStr:@"tbopen://"];
    [ALBCPush pushALBCSDK:pushALBCTypeMyOrders openType:ALBCOpenTypeH5 data:nil complete:^(UIViewController * _Nonnull vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
//    [self.searchImpl r_Search_RebateOrderGet:[RequestModel modelWithDictionary:@{@"Date":@"2018-04-18 17:23:13 ",@"Number":@"600"}] complete:^(ResponseModel *model) {
//        GSLog(@"%@",model);
//    } failed:^(RequestFailedError error) {
//
//    }];
}

-(void)logInClick{
      [self m_login];
}

-(void)logoutClick{
  
    if(![[ALBBSession sharedInstance] isLogin]){
        [[MyAlertView alertViewWithTitle:@"未登录" message:@"还没有登录哟！" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        [[ALBBSDK sharedInstance] logout];
        [[MyAlertView alertViewWithTitle:@"退出成功" message:@"退出登录！" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
    [self initWithName:@"麻雀优惠券" icon:@""];
    [TBUSerModel userModel].login = @"0";


}

-(void)initWithName:(NSString *)nameUser icon:(NSString *)iconImage{
    _nameLable.text = nameUser;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:iconImage] placeholderImage:[UIImage imageNamed:@"default_49_11"]];
}

-(UIButton *)logInBtn{
    if (!_logInBtn) {
        _logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logInBtn setTitle:@"登录" forState:UIControlStateNormal];
        _logInBtn.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(32)];
        [_logInBtn setTitleColor:[UIColor colorWithHexString:@"#9f9f9f"] forState:UIControlStateNormal];
        [_logInBtn addTarget:self action:@selector(logInClick) forControlEvents:UIControlEventTouchUpInside];
        //        _logOutBtn.backgroundColor = [UIColor colorWithHexString:@"#b4b4b4"];
        _logInBtn.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        
        
        
    }
    return _logInBtn;
}
-(UIButton *)logOutBtn{
    if (!_logOutBtn) {
        _logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        _logOutBtn.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(32)];
        [_logOutBtn setTitleColor:[UIColor colorWithHexString:@"#9f9f9f"] forState:UIControlStateNormal];
        [_logOutBtn addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
        //        _logOutBtn.backgroundColor = [UIColor colorWithHexString:@"#b4b4b4"];
        _logOutBtn.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        
    }
    return _logOutBtn;
}
-(UIButton *)dingdanBtn{
    if (!_dingdanBtn) {
        _dingdanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dingdanBtn setTitle:@"我的订单" forState:UIControlStateNormal];
        _dingdanBtn.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(32)];
        [_dingdanBtn setTitleColor:[UIColor colorWithHexString:@"#9f9f9f"] forState:UIControlStateNormal];
        [_dingdanBtn addTarget:self action:@selector(dingdanClick) forControlEvents:UIControlEventTouchUpInside];
        //        _logOutBtn.backgroundColor = [UIColor colorWithHexString:@"#b4b4b4"];
        _dingdanBtn.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        
    }
    return _dingdanBtn;
}
-(UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]init];
        _nameLable.textColor = [UIColor redColor];
        _nameLable.font =[UIFont systemFontOfSize:__kNewSize(30)];
        _nameLable.textAlignment = NSTextAlignmentCenter;
        _nameLable.text = @"麻雀优惠券";
    }
    return _nameLable;
}
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = (__kNewSize(118))/2;
        _iconImageView.layer.borderWidth = 1.0;
        CGColorRef colorref = [UIColor grayColor].CGColor;
        [_iconImageView.layer setBorderColor:colorref];
        _iconImageView.image =[UIImage imageNamed:@"me_1"];
    }
    return _iconImageView;
}

@end
