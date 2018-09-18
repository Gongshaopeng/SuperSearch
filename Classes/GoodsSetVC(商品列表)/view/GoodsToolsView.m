//
//  GoodsToolsView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/24.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GoodsToolsView.h"

@interface GoodsToolsView ()
{
    
}

@end
@implementation GoodsToolsView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self g_UI];
        [self g_frame];
    }
    return self;
}
-(void)g_UI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imageView];
    [self addSubview:self.lableTitle];
    [self addSubview:self.switchBtn];
    [self addSubview:self.searchBtn];
//    [self addSubview:self.mySwitch];
}
-(void)g_frame{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(__kNewSize(20));
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(54), __kNewSize(54)));
    }];
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imageView.mas_right).mas_offset(__kNewSize(20));
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(400), __kNewSize(40)));
    }];
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle.mas_right).mas_offset(__kNewSize(20));
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(80), __kNewSize(40)));
    }];
//    [_mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self).mas_offset(__kNewSize(-20));
//        make.centerY.mas_equalTo(self);
////        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(60)));
//        make.size.mas_equalTo(CGSizeMake(59.0f, 31.0f));
//
//    }];
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(__kNewSize(-20));
        make.centerY.mas_equalTo(self);
        //        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(60)));
        make.size.mas_equalTo(CGSizeMake(49.0f, 31.0f));
        
    }];
}
#pragma mark - Delegate

- (void)onStatusDelegate{
    if(_mySwitch.OnStatus){
        NSLog(@"打开");
    }else{
        NSLog(@"关闭");
    }
}
#pragma mark - Click
-(void)searchClick:(UIButton *)btn{
    if (btn.isSelected == YES) {
        [EntireManageMent addConfigKey:__Config_SearchChannelKey__ configvalue:@"0" updataTime:nil];

        _searchBtn.backgroundColor = [UIColor redColor];
        [_searchBtn setTitle:@"好券" forState:UIControlStateNormal];
        btn.selected = NO;
        GSLog(@"好券");
        [self setGoodsToolsdelegate:SearchCouponType];

    }else{
        [EntireManageMent addConfigKey:__Config_SearchChannelKey__ configvalue:@"1" updataTime:nil];
        [EntireManageMent addConfigKey:__Config_NO_CouponKey__ configvalue:@"NO" updataTime:nil];
        [_switchBtn setOn:NO animated:NO];

        _searchBtn.backgroundColor = [UIColor orangeColor];
        [_searchBtn setTitle:@"超级搜" forState:UIControlStateNormal];
        btn.selected = YES;
        GSLog(@"超级搜");
        [self setGoodsToolsdelegate:SearchSuperType];

    }
}
-(void)getValue1:(id)sender{
    UISwitch *swi2=(UISwitch *)sender;
    if (swi2.isOn) {
        NSLog(@"On");
        [EntireManageMent addConfigKey:__Config_NO_CouponKey__ configvalue:@"YES" updataTime:nil];
        [self setGoodsToolsdelegate:CouponYESType];
    }else{
        NSLog(@"Off");
        [EntireManageMent addConfigKey:__Config_NO_CouponKey__ configvalue:@"NO" updataTime:nil];
        [self setGoodsToolsdelegate:CouponNOType];

    }
    
    
}

-(void)setGoodsToolsdelegate:(GoodsToolsType)type{
    if ([self.delegate respondsToSelector:@selector(myGoodsToolsClicked:)])
    {
        [self.delegate myGoodsToolsClicked:type];
    }
}
#pragma mark - UI

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"first_search_no"];
//        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}
-(UILabel *)lableTitle{
    if (!_lableTitle) {
        _lableTitle = [[UILabel alloc]init];
        _lableTitle.text = @"仅显示优惠券商品";
        _lableTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        _lableTitle.font = [UIFont systemFontOfSize:__kNewSize(28)];
    }
    return _lableTitle;
}
-(UISwitch *)switchBtn{
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc]init];
        //设置背景，发现上面设置的框的大小确实无效，因为背景只有控件那么大，并不是设置的那么大，而且控件是圆角
        _switchBtn.backgroundColor=[UIColor grayColor];
        //设置ON一边的背景颜色，默认是绿色
        _switchBtn.onTintColor=[UIColor orangeColor];
        //设置OFF一边的背景颜色，默认是灰色，发现OFF背景颜色其实也是控件”边框“颜色
        _switchBtn.tintColor=[UIColor grayColor];
        //设置滑块颜色
        _switchBtn.thumbTintColor=[UIColor whiteColor];
        _switchBtn.layer.cornerRadius = _switchBtn.bounds.size.height/2;
        _switchBtn.layer.masksToBounds = YES;
//        _switchBtn.onImage=[UIImage imageNamed:@"1.png"];//无效
//        _switchBtn.offImage=[UIImage imageNamed:@"logo.png"];//无效
      
        //开关控件默认是关闭的，setOn可以默认成打开，所以其实它在显示的时候有一个打开的动作，但这个动作不发送消息，即捕捉不到
        //如我们做个试验，弄个针对“值变动”所引发的操作，即值发生变动，开启输出“On”，关闭输出“Off”
        //发现第一次并没有输出On，我们自己手动从关闭到开启时会有On和Off
        //所以这个setOn虽然是一个开启动作，但我们可以认为它相当于是内置了，我们看不到这个动作，所以捕捉不到
        //但这里我们练习了获取值变动病利用isOn来做相应的操作
        [_switchBtn addTarget:self action:@selector(getValue1:) forControlEvents:UIControlEventValueChanged];
        //设置成开启病设置动画形式出现，当然也可以直接用[_switchBtn setOn:YES];
        NSString * strIsOn = [EntireManageMent readConfigDataWithConfigKey:__Config_NO_CouponKey__];
        if ([strIsOn isEqualToString:@"YES"]) {
            [_switchBtn setOn:YES animated:YES];
        }else{
            [_switchBtn setOn:NO animated:NO];
        }
        
        //isOn是一个getter方法，所以不能够赋值，即不能用swi.isOn=YES，只能取得当前结果，一般用于判断是否是开启状态
        if (_switchBtn.isOn) {
            NSLog(@"It is On");
            [EntireManageMent addConfigKey:__Config_NO_CouponKey__ configvalue:@"YES" updataTime:nil];
        }else{
            [EntireManageMent addConfigKey:__Config_NO_CouponKey__ configvalue:@"NO" updataTime:nil];
        }
    }
    return _switchBtn;
}

-(MySwitch *)mySwitch{
    if (!_mySwitch) {
        _mySwitch = [[MySwitch alloc]initWithFrame:CGRectMake(0, 0, 59, 31) withGap:2.0];
//        _mySwitch.Gap = 2.0;
//        [_mySwitch setBackgroundImage:[UIImage imageNamed:@"back.png"]];
//        [_mySwitch setLeftBlockImage:[UIImage imageNamed:@"left_slider.png"]];
//        [_mySwitch setRightBlockImage:[UIImage imageNamed:@"right_slider.png"]];
        _mySwitch.delegate=self;
    }
    return _mySwitch;
}
-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(22)];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
        //        _logOutBtn.backgroundColor = [UIColor colorWithHexString:@"#b4b4b4"];
        NSString * strIsOn = [EntireManageMent readConfigDataWithConfigKey:__Config_SearchChannelKey__];
        if ([strIsOn isEqualToString:@"1"]) {
            [_searchBtn setTitle:@"超级搜" forState:UIControlStateNormal];
            _searchBtn.backgroundColor = [UIColor orangeColor];
            _searchBtn.selected = YES;
        }else{
            [_searchBtn setTitle:@"好券" forState:UIControlStateNormal];
            _searchBtn.backgroundColor = [UIColor redColor];
            _searchBtn.selected = NO;

        }
        
    }
    return _searchBtn;
}

@end
