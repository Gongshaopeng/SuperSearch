//
//  TKLView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/31.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "TKLView.h"
@interface TKLView ()

@property (nonatomic,strong) UILabel * titleLable;
@property (nonatomic,strong) UIView * xianView;
@property (nonatomic,strong) UIImageView * zhangImage;

@end
@implementation TKLView

//初始化方法
#pragma mark - InitView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self t_UI];
        [self t_Frame];
    }
    return self;
}

-(void)t_UI{
    
    [self addSubview:self.xianView];
    [self addSubview:self.bodylabel];
    [self addSubview:self.cancelButton];
    [self addSubview:self.goButton];
    [self addSubview:self.titleLable];
    [self addSubview:self.zhangImage];


}
-(void)t_Frame{
 

    [_xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(__kNewSize(64));
        make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, __kNewSize(28), 0, __kNewSize(28)));
//        make.size.mas_equalTo(CGSizeMake(__kNewSize(300), __kNewSize(28)));
//        make.centerX.mas_equalTo(self);

    }];
    [_zhangImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_xianView.mas_bottom).offset(__kNewSize(30));
        make.right.mas_equalTo(self.mas_right).offset(-__kNewSize(12));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(198), __kNewSize(155)));
    }];
    [_bodylabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_xianView.mas_top).offset(__kNewSize(32));
        make.centerX.mas_equalTo(_xianView);
//        make.centerY.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(__kNewSize(300), __kNewSize(28)));
        make.top.left.right.mas_equalTo(_xianView).insets(UIEdgeInsetsMake(__kNewSize(20), __kNewSize(28), 0, __kNewSize(28)));
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom).offset(__kNewSize(-92));
        make.left.mas_equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake((__kScreenWidth__-__kNewSize(92))/2, __kNewSize(92)));
        
    }];
    [_goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom).offset(__kNewSize(-92));
        make.left.mas_equalTo(_cancelButton.mas_right);
        make.size.mas_equalTo(CGSizeMake((__kScreenWidth__-__kNewSize(92))/2, __kNewSize(92)));
        
    }];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(__kNewSize(48));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(310), __kNewSize(32)));
    }];
}

-(UIImageView *)zhangImage{
    if (!_zhangImage) {
        _zhangImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"window_seal"]];
    }
    return _zhangImage;
}
-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font =  [UIFont systemFontOfSize:__kNewSize(32)];
        _titleLable.numberOfLines = 1;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor colorWithHexString:@"#222222"];
        _titleLable.text = @"您的淘口令已生成";
        _titleLable.backgroundColor = [UIColor whiteColor];
    }
    return _titleLable;
}
-(UIView *)xianView{
    if (!_xianView) {
        _xianView = [[UIView alloc]init];
        _xianView.layer.masksToBounds = YES;
//        _xianView.layer.cornerRadius = __kNewSize(40);
        _xianView.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        _xianView.layer.borderWidth = 1.0;
        
    }
    return _xianView;
}
-(UILabel *)bodylabel{
    if (!_bodylabel) {
        _bodylabel = [[UILabel alloc]init];
        _bodylabel.font =  [UIFont systemFontOfSize:__kNewSize(28)];
        _bodylabel.numberOfLines = 0;
//        _bodylabel.textAlignment = NSTextAlignmentCenter;
        _bodylabel.textColor = [UIColor colorWithHexString:@"#999999"];
//        _bodylabel.layer.masksToBounds = YES;
//        //        _xianView.layer.cornerRadius = __kNewSize(40);
//        _bodylabel.layer.borderColor = [UIColor colorWithHexString:@"#ff4200"].CGColor;
//        _bodylabel.layer.borderWidth = 1.0;
    }
    return _bodylabel;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"不分享" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(32)];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
//        [_cancelButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        //        _cancelButton.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        _cancelButton.layer.masksToBounds = YES;
//        _cancelButton.layer.cornerRadius = __kNewSize(40);
        _cancelButton.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        _cancelButton.layer.borderWidth = __kNewSize(1);
    }
    return _cancelButton;
}
-(UIButton *)goButton{
    if (!_goButton) {
        _goButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goButton setTitle:@"去粘贴" forState:UIControlStateNormal];
        _goButton.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(32)];
        [_goButton setTitleColor:[UIColor colorWithHexString:@"#42d25e"] forState:UIControlStateNormal];
//        [_goButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        //        _goButton.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        _goButton.layer.masksToBounds = YES;
//        _goButton.layer.cornerRadius = __kNewSize(40);
        _goButton.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        _goButton.layer.borderWidth = __kNewSize(1);
    }
    return _goButton;
}

-(void)setBodyStr:(NSString *)bodyStr{
    _bodylabel.text = bodyStr;
    CGFloat height = [NSString measureMutilineStringHeight:bodyStr andFont:[UIFont systemFontOfSize:__kNewSize(28)] andWidthSetup:__kNewSize(654)];
    [_xianView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(__kNewSize(64), __kNewSize(28), 0, __kNewSize(28)));

        //        make.top.mas_equalTo(self.mas_top).offset(__kNewSize(32));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(height+40);

        //        make.size.mas_equalTo(CGSizeMake(__kNewSize(300), __kNewSize(28)));
    }];
    [_bodylabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(_xianView).insets(UIEdgeInsetsMake(__kNewSize(20), __kNewSize(28), __kNewSize(20), __kNewSize(28)));

        //        make.top.mas_equalTo(_xianView.mas_top).offset(__kNewSize(32));
        make.centerX.mas_equalTo(_xianView);
        make.centerY.mas_equalTo(_xianView);
        //        make.size.mas_equalTo(CGSizeMake(__kNewSize(300), __kNewSize(28)));
        make.height.mas_equalTo(height+20);
    }];
   
}
@end
