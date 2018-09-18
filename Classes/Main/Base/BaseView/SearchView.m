//
//  SearchView.m
//  星火作文
//
//  Created by 巩继鹏 on 15/11/25.
//  Copyright © 2015年 com.juwan.easyzw. All rights reserved.
//
#define kLightblueColor [UIColor colorWithRed:40/255.0 green:159/255.0 blue:217/255.0 alpha:1]

#import "SearchView.h"

@interface SearchView () 


@end
@implementation SearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self lazyCreateUI];
    }
    return self;
}

#pragma mark - initSubviews

- (void)lazyCreateUI
{
//    [self addSubview:self.bgView];
    [self addSubview:self.videoBtn];
    [self addSubview:self.searchTextField];
    [self addSubview:self.searchBtn];

//    [self addSubview:self.xianS];

    [self p_layoutSubviews];
}


#pragma mark - layoutSubviews
-(void)playVideoButtonIs:(BOOL)isHidVideo{
    //yes：显示浮窗按钮
    if (isHidVideo == YES) {
        _videoBtn.alpha = 1;
        [_videoBtn updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY).offset(__kNewSize(20));
            make.left.equalTo(self.left).offset(__kNewSize(20));
            make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(50)));
        }];
        [_searchTextField updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY).offset(__kNewSize(20));
            make.left.equalTo(self.left).offset(__kNewSize(110));
            make.size.mas_equalTo(CGSizeMake(__kScreenWidth__-__kNewSize(204), __kNewSize(88)));
        }];
        [_searchBtn updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY).offset(__kNewSize(20));
            make.left.equalTo(_searchTextField.right).offset(__kNewSize(-10));
            make.size.mas_equalTo(CGSizeMake(__kNewSize(114), __kNewSize(86)));
        }];
        
    }else{
        _videoBtn.alpha = 0;
        [_searchTextField updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY).offset(__kNewSize(20));
            make.left.equalTo(self.left).offset(__kNewSize(20));
            make.size.mas_equalTo(CGSizeMake(__kScreenWidth__-__kNewSize(114), __kNewSize(88)));
        }];
        [_searchBtn updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY).offset(__kNewSize(20));
            make.left.equalTo(_searchTextField.right).offset(__kNewSize(-10));
            make.size.mas_equalTo(CGSizeMake(__kNewSize(114), __kNewSize(86)));
        }];
//         _searchTextField.frame = CGRectMake(0, __kNavigationBarHeight__-__kNewSize(88), __kScreenWidth__-__kNewSize(114), __kNewSize(88));
//        _searchBtn.frame=CGRectMake(__kScreenWidth__-__kNewSize(114), __kNavigationBarHeight__-__kNewSize(86), __kNewSize(114), __kNewSize(86));
        
    }
}

-(void)p_layoutSubviews
{
    
    _bgView.frame=CGRectMake(0, 0,__kScreenWidth__, self.frame.size.height);
//    _searchBtn.frame=CGRectMake(__kScreenWidth__-55, (70-50)/2, 50, 50);
    
}


-(UIView *)bgView
{
    if (_bgView==nil)
    {
        _bgView=[[UIView alloc]init];
//        _bgView.layer.shadowOffset=CGSizeMake(0, 1);
//        _bgView.layer.shadowOpacity=0.3;
        _bgView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _bgView;
}
-(UIButton *)searchBtn
{
    if (_searchBtn==nil)
    {
        _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame=CGRectMake(__kScreenWidth__-__kNewSize(114), __kNavigationBarHeight__-__kNewSize(86), __kNewSize(114), __kNewSize(86));

//        UIFont *iconfont=[UIFont fontWithName:@"iconfont" size:__kNewSize(16)];
        _searchBtn.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(28)];
    //   _searchBtn.layer.cornerRadius = 5.0;
      //  _searchBtn.userInteractionEnabled = YES;
//        _searchBtn.backgroundColor = [UIColor greenColor];
        
    }
    return _searchBtn;
}

-(UITextField *)searchTextField
{
    if (_searchTextField==nil)
    {
        _searchTextField=[[UITextField alloc]init];
        _searchTextField.frame = CGRectMake(0, __kNavigationBarHeight__-__kNewSize(88), __kScreenWidth__-__kNewSize(114), __kNewSize(88));
        UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(__kNewSize(14),0, __kNewSize(26+28+20), __kNewSize(88))];

//       _searchTextField.backgroundColor = [UIColor orangeColor];
        [aview addSubview:self.imgv];
        _searchTextField.leftView = aview;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.userInteractionEnabled=YES;
        _searchTextField.font = [UIFont systemFontOfSize:__kNewSize(28)];
//        _searchTextField.attributedPlaceholder = [MaqueTool attributedPlaceholderText:@"搜索或输入网址" colorStr:@"#777777"];
//         _searchTextField.textAlignment=NSTextAlignmentLeft;
//        [self boomLayerTF:_searchTextField];
    }
    return _searchTextField;
}
-(void)boomLayerTF:(UITextField *)tfd{
    
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0, _searchTextField.bounds.size.height-__kNewSize(1),__kScreenWidth__, __kNewSize(1));
    leftBorder.backgroundColor = [UIColor colorWithHexString:@"#c6c6c6"].CGColor;
    [tfd.layer addSublayer:leftBorder];
    
}
-(UIImageView *)imgv{
    if (!_imgv) {
        _imgv=[[UIImageView alloc] init];
        _imgv.frame = CGRectMake(__kNewSize(26), __kNewSize(88-34)/2, __kNewSize(36), __kNewSize(34));

    }
    return _imgv;
}
- (UIView *)xianS{
    if (!_xianS) {
        _xianS = [[UIView alloc]initWithFrame:CGRectMake(0,__kNavigationBarHeight__-__kNewSize(1), __kScreenWidth__, __kNewSize(1))];
        _xianS.backgroundColor = [UIColor colorWithHexString:@"#c6c6c6"];
        
    }
    return _xianS;
}

- (UIButton *)videoBtn{
    if (!_videoBtn) {
        _videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoBtn setTitle:@"小窗" forState:UIControlStateNormal];
        [_videoBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _videoBtn.backgroundColor = [UIColor colorWithHexString:@"#de3031"];
        _videoBtn.titleEdgeInsets = UIEdgeInsetsMake(0,__kNewSize(40), 0, 0);
        UIImage *image = [UIImage imageNamed:@"window_small"];
        UIImageView *iconView = [[UIImageView alloc]initWithImage:image];
        iconView.frame = CGRectMake(__kNewSize(10), __kNewSize((50-30)/2), __kNewSize(30), __kNewSize(30));
        [_videoBtn addSubview:iconView];
        _videoBtn.layer.masksToBounds = YES;
        _videoBtn.layer.cornerRadius = 2.0f;
        _videoBtn.layer.borderWidth = __kNewSize(1);
        CGColorRef colorref = [UIColor colorWithHexString:@"#ffffff"].CGColor;
        [_videoBtn.layer setBorderColor:colorref];
        _videoBtn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(24)];
//        [_videoBtn addTarget:self action:@selector(playVideoClick) forControlEvents:UIControlEventTouchUpInside];
        _videoBtn.alpha = 0;
    }
    return _videoBtn;
}
@end
