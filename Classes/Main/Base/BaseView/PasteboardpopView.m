//
//  PasteboardpopView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/28.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "PasteboardpopView.h"
#import "AdpopupsView.h"
#import <UIImageView+WebCache.h>

@interface PasteboardpopView ()

//这里面填写属性
//需要公开的写在点h文件中
@property (nonatomic,strong) AdpopupsView * adpopupsView;
@property (nonatomic,strong) UIView * backGView;//!<背景view
@property (nonatomic,strong) UILabel * topTitleLable;//标题
@property (nonatomic,strong) UIImageView * iconImageView;//商品图片
@property (nonatomic,strong) UILabel * shopTitleLable;//店铺名
@property (nonatomic,strong) UILabel * zkFinalPriceLable;//折扣
@property (nonatomic,strong) UILabel * couponInfoLable;//优惠
@property (nonatomic,strong) UILabel * titleLable;//商品名
@property (nonatomic,strong) UIButton * leftButton;//
@property (nonatomic,strong) UIButton * rightButton;//

@end

@implementation PasteboardpopView

//初始化方法
#pragma mark - InitView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self p_UI];
        [self p_Frame];
    }
    return self;
}

-(void)p_UI{
    
//    [self addSubview:self.backGView];
    [self addSubview:self.topTitleLable];
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLable];
    [self addSubview:self.zkFinalPriceLable];
    [self addSubview:self.topTitleLable];
    [_topTitleLable addSubview:self.couponInfoLable];
    [self addSubview:self.shopTitleLable];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];

    
}

-(void)p_Frame{
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.dc_width, __kNewSize(565)));
    }];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(__kNewSize(38));
        make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, __kNewSize(24), 0, __kNewSize(24)));
        make.height.mas_equalTo(__kNewSize(80));
    }];
    [_zkFinalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLable.mas_bottom).offset(__kNewSize(28));
        make.left.mas_equalTo(self.mas_left).offset(__kNewSize(24));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(160), __kNewSize(30)));
    }];
    
   
    [_topTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_zkFinalPriceLable.mas_right).offset(__kNewSize(20));
        make.centerY.mas_equalTo(_zkFinalPriceLable);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(136), __kNewSize(22)));
        
    }];
    [_couponInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(_zkFinalPriceLable);
//        make.left.mas_equalTo(_zkFinalPriceLable.mas_right).offset(__kNewSize(20));
        make.centerY.mas_equalTo(_topTitleLable);
        make.centerX.mas_equalTo(_topTitleLable);
        make.size.mas_equalTo(_topTitleLable);
        
    }];
    [_shopTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_zkFinalPriceLable.mas_bottom).offset(__kNewSize(14));
        make.left.mas_equalTo(_zkFinalPriceLable);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(300), __kNewSize(20)));
        
    }];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_shopTitleLable.mas_bottom).offset(__kNewSize(50));
        make.left.mas_equalTo(self.mas_left).offset(__kNewSize(35));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(240), __kNewSize(80)));
        
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_shopTitleLable.mas_bottom).offset(__kNewSize(50));
        make.right.mas_equalTo(self.mas_right).offset(__kNewSize(-35));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(240), __kNewSize(80)));
        
    }];
}


//-(AdpopupsView *)adpopupsView{
//    if (!_adpopupsView) {
//        
//        _adpopupsView = [[AdpopupsView alloc] initWithCustomView:self.iconImageView popStyle:GSAnimationPopStyleScale dismissStyle:GSAnimationDismissStyleScale ];
//        _adpopupsView.popBGAlpha = 0.5f;
//        _adpopupsView.isClickBGDismiss = YES;
//        
//        _adpopupsView.popComplete = ^{
//            NSLog(@"显示完成");
//        };
//        // 2.7 移除完成回调
//        _adpopupsView.dismissComplete = ^{
//            NSLog(@"移除完成");
//        };
//        _adpopupsView.tapComplete = ^{
//            NSLog(@"点击图片");
//          
//        };
//        
//        [_adpopupsView pop];
//    }
//    return _adpopupsView;
//}

-(UIView *)backGView{
    if (!_backGView) {
        _backGView = [[UIView alloc]init];
    }
    return _backGView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
//        [_iconImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
//        _iconImageView.contentMode =  UIViewContentModeScaleAspectFill;
//        _iconImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        _iconImageView.clipsToBounds  = YES;
    }
    return _iconImageView;
}
-(UILabel *)topTitleLable{
    if (!_topTitleLable) {
        _topTitleLable = [[UILabel alloc]init];
//        _topTitleLable.font =  [UIFont systemFontOfSize:__kNewSize(22)];
//        _topTitleLable.numberOfLines = 1;
//        _topTitleLable.textAlignment = NSTextAlignmentLeft;
        [_topTitleLable.layer insertSublayer:[self setCAGradientLayerColorOne:@"#ff434a" ColorTwo:@"#fe5f9a" W:136 H:22] atIndex:0];
        _topTitleLable.layer.masksToBounds = YES;
        _topTitleLable.layer.cornerRadius = __kNewSize(11);
    }
    return _topTitleLable;
}
-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font =  [UIFont systemFontOfSize:__kNewSize(28)];
        _titleLable.numberOfLines = 2;
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _titleLable;
}
-(UILabel *)zkFinalPriceLable{
    if (!_zkFinalPriceLable) {
        _zkFinalPriceLable = [[UILabel alloc]init];
        _zkFinalPriceLable.font =  [UIFont systemFontOfSize:__kNewSize(30)];
        _zkFinalPriceLable.numberOfLines = 1;
        _zkFinalPriceLable.textAlignment = NSTextAlignmentLeft;
        _zkFinalPriceLable.textColor = [UIColor colorWithHexString:@"#f11014"];
    }
    return _zkFinalPriceLable;
}
-(UILabel *)couponInfoLable{
    if (!_couponInfoLable) {
        _couponInfoLable = [[UILabel alloc]init];
        _couponInfoLable.font =  [UIFont systemFontOfSize:__kNewSize(16)];
        _couponInfoLable.numberOfLines = 1;
        _couponInfoLable.textAlignment = NSTextAlignmentCenter;
        _couponInfoLable.textColor = [UIColor whiteColor];
//        [_couponInfoLable.layer insertSublayer:[self setCAGradientLayerColorOne:@"#ff434a" ColorTwo:@"#fe5f9a" W:136 H:22] atIndex:0];
        _couponInfoLable.backgroundColor = [UIColor clearColor];
        _couponInfoLable.layer.masksToBounds = YES;
        _couponInfoLable.layer.cornerRadius = __kNewSize(11);
    }
    return _couponInfoLable;
}

-(UILabel *)shopTitleLable{
    if (!_shopTitleLable) {
        _shopTitleLable = [[UILabel alloc]init];
        _shopTitleLable.font =  [UIFont systemFontOfSize:__kNewSize(20)];
        _shopTitleLable.numberOfLines = 1;
        _shopTitleLable.textAlignment = NSTextAlignmentLeft;
        _shopTitleLable.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _shopTitleLable;
}

-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitle:@"搜同款" forState:UIControlStateNormal];
        _leftButton.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(34)];
        [_leftButton setTitleColor:[UIColor colorWithHexString:@"#ff4200"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
//        _leftButton.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        _leftButton.layer.masksToBounds = YES;
        _leftButton.layer.cornerRadius = __kNewSize(40);
        _leftButton.layer.borderColor = [UIColor colorWithHexString:@"#ff4200"].CGColor;
        _leftButton.layer.borderWidth = 1.0;
    }
    return _leftButton;
}
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"去购买" forState:UIControlStateNormal];
        _rightButton.titleLabel.font=[UIFont systemFontOfSize:__kNewSize(34)];
        [_rightButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(goodsClick) forControlEvents:UIControlEventTouchUpInside];
//        _rightButton.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        [_rightButton.layer insertSublayer:[self setCAGradientLayerColorOne:@"#ff8d01" ColorTwo:@"#ff5200" W:240 H:80] atIndex:0];
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.cornerRadius = __kNewSize(40);
    }
    return _rightButton;
}

#pragma mark - Setter Getter Methods
-(void)setCouponModel:(TBKCouponModel *)couponModel
{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:couponModel.PictUrl] placeholderImage:[UIImage imageNamed:@"discount_subject_not"]];
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:couponModel.PictUrl] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//        GSLog(@"img.size.height: %ff",image.size.height);
//        _iconImageView.image  = image;
////        _iconImageView.image = [STool clipImage:image toRect:CGSizeMake(self.dc_width, __kNewSize(528))];
//
//        [_iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self);
//            make.centerX.mas_equalTo(self);
//            make.size.mas_equalTo(CGSizeMake(self.dc_width, __kNewSize(568)));
//        }];
//    }];
    
  
//    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:couponModel.PictUrl]];
//
//    UIImage *img = [UIImage imageWithData:data];
////    img.size.height
    
   [STool newParagraphStyle:_titleLable str:couponModel.Title LineSpacing:__kNewSize(12)];
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",couponModel.ZkFinalPrice]];
    [abs beginEditing];
    //  字体大小
    [abs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:__kNewSize(20)] range:NSMakeRange(1, 1)];
    _zkFinalPriceLable.attributedText = abs;
    _couponInfoLable.text = [NSString stringWithFormat:@"返利专享券%@",[STool returnCouponInfo:couponModel.CouponInfo]];
    _shopTitleLable.text = couponModel.ShopTitle;
}


-(CAGradientLayer *)setCAGradientLayerColorOne:(NSString *)colorOne ColorTwo:(NSString *)colorTwo W:(CGFloat)w H:(CGFloat)h{
  CAGradientLayer *  _gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    _gradient.startPoint = CGPointMake(0, 0);
    _gradient.endPoint = CGPointMake(1, 0);
    _gradient.frame =CGRectMake(0, 0, __kNewSize(w), __kNewSize(h));
    _gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:colorOne].CGColor,(id)[UIColor colorWithHexString:colorTwo].CGColor,nil];
    return _gradient;
}
-(void)searchClick{
    if (self.SearchComplete) {
        self.SearchComplete();
    }
}
-(void)goodsClick{
    if (self.GoodsComplete) {
        self.GoodsComplete();
    }
}
@end
