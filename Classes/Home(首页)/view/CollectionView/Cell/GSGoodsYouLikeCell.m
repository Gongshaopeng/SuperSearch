//
//  GSGoodsYouLikeCell.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/15.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//
#define cellWH  __kScreenWidth__* 0.5 - 50

#import "GSGoodsYouLikeCell.h"
// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface GSGoodsYouLikeCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 优惠券背景图片 */
@property (strong , nonatomic)UIImageView *couponInfoImageView;
/* 商品来源图片 */
@property (strong , nonatomic)UIImageView *userTypeImageView;
/* 店铺图片 */
@property (strong , nonatomic)UIImageView *shopImageView;

/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 原价 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 折扣价 */
@property (strong , nonatomic)UILabel *zkpriceLabel;
/* 销量 */
@property (strong , nonatomic)UILabel *volumeLabel;
/* 优惠券面额 */
@property (strong , nonatomic)UILabel *couponInfoLabel;
/* 店铺名称 */
@property (strong , nonatomic)UILabel *shopTitleLabel;

/* 返利 */
@property (strong , nonatomic)UILabel *rateLabel;

@end
@implementation GSGoodsYouLikeCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    [self addSubview:self.goodsImageView];
    [self addSubview:self.userTypeImageView];
    [self addSubview:self.goodsLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.zkpriceLabel];
    [self addSubview:self.volumeLabel];
    [self addSubview:self.couponInfoImageView];
    [_couponInfoImageView addSubview:self.couponInfoLabel];
    [self addSubview:self.shopImageView];
    [self addSubview:self.shopTitleLabel];
//    [_goodsImageView addSubview:self.rateLabel];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:0];
        make.size.mas_equalTo(CGSizeMake(self.dc_width , self.dc_width));
        
    }];
    
//    [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_goodsImageView.mas_right).offset(__kNewSize(-12));
//        [make.bottom.mas_equalTo(_goodsImageView.mas_bottom)setOffset:__kNewSize(-12)];
//        make.size.mas_equalTo(CGSizeMake(__kNewSize(160) , __kNewSize(30)));
//
//    }];
    
//    if([self.youLikeItem.UserType integerValue] == 0){
//        [_userTypeImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(__kNewSize(20));
//            make.left.mas_equalTo(self.mas_left).offset(__kNewSize(0));
//            make.size.mas_equalTo(CGSizeMake(__kNewSize(0) ,__kNewSize(0)));
//
//        }];
//    }else{
        [_userTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(__kNewSize(20));
            make.left.mas_equalTo(self.mas_left).offset(__kNewSize(12));
            make.size.mas_equalTo(CGSizeMake(__kNewSize(26) ,__kNewSize(26)));
            
        }];
//    }
   
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 
        make.top.mas_equalTo(_userTypeImageView);
        make.left.mas_equalTo(_userTypeImageView.mas_right).offset(__kNewSize(6));
        make.size.mas_equalTo(CGSizeMake(self.dc_width-__kNewSize(56) ,__kNewSize(26)));
    }];
//
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsImageView).offset(__kNewSize(12));
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.top.mas_equalTo(_goodsLabel.mas_bottom).offset(__kNewSize(14));

    }];
    [_volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(__kNewSize(-20));
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.top.mas_equalTo(_goodsLabel.mas_bottom).offset(__kNewSize(14));

    }];
    [_couponInfoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsImageView).offset(__kNewSize(12));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(100) ,__kNewSize(36)));
        make.top.mas_equalTo(_priceLabel.mas_bottom).offset(__kNewSize(14));

    }];
    [_couponInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_couponInfoImageView);
        make.size.mas_equalTo(_couponInfoImageView);

    }];
//
    [_zkpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_goodsImageView).offset(__kNewSize(-20));
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.top.mas_equalTo(_couponInfoImageView);

    }];
    [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_couponInfoImageView.mas_bottom).offset(__kNewSize(12));
        make.left.mas_equalTo(self.mas_left).offset(__kNewSize(12));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(26) ,__kNewSize(26)));

    }];
    [_shopTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_shopImageView);
        make.left.mas_equalTo(_shopImageView.mas_right).offset(__kNewSize(6));
        make.size.mas_equalTo(CGSizeMake(self.dc_width-__kNewSize(56) ,__kNewSize(26)));

    }];
}



#pragma mark - 初始化UI

- (UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc]init];
        [_goodsImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _goodsImageView.contentMode =  UIViewContentModeScaleAspectFill;
        _goodsImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _goodsImageView.clipsToBounds  = YES;
//        imageView.layer.masksToBounds = YES;
//        imageView.layer.cornerRadius = __kNewSize(105)/2;
//        _goodsImageView.layer.borderWidth = 1;
//        _goodsImageView.layer.borderColor=[UIColor whiteColor].CGColor;
//        _goodsImageView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];

    }
    return _goodsImageView;
}

-(UIImageView *)couponInfoImageView{
    if (!_couponInfoImageView) {
       _couponInfoImageView = [[UIImageView alloc]init];
        _couponInfoImageView.image =[UIImage imageNamed:@"discount_icon_coupon"];
    }
    return _couponInfoImageView;
}
-(UIImageView *)shopImageView{
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc]init];
        _shopImageView.image =[UIImage imageNamed:@"discount_icon_shop"];
    }
    return _shopImageView;
}
-(UIImageView *)userTypeImageView{
    if (!_userTypeImageView) {
        _userTypeImageView = [[UIImageView alloc]init];
//        [_userTypeImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
//        _userTypeImageView.contentMode =  UIViewContentModeScaleAspectFill;
//        _userTypeImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _userTypeImageView.clipsToBounds  = YES;
        _userTypeImageView.image =[UIImage imageNamed:@"discount_icon_tm"];
    }
    return _userTypeImageView;
}
-(UILabel *)rateLabel{
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc]init];
        _rateLabel.font =  [UIFont systemFontOfSize:__kNewSize(22)];
        _rateLabel.numberOfLines = 1;
        _rateLabel.textAlignment = NSTextAlignmentCenter;
        _rateLabel.textColor = [UIColor whiteColor];
        _rateLabel.backgroundColor = [UIColor orangeColor];
    }
    return _rateLabel;
}
-(UILabel *)goodsLabel{
    if (!_goodsLabel) {
        _goodsLabel = [[UILabel alloc]init];
        _goodsLabel.font =  [UIFont systemFontOfSize:__kNewSize(26)];
        _goodsLabel.numberOfLines = 1;
        _goodsLabel.textAlignment = NSTextAlignmentLeft;
        _goodsLabel.textColor = [UIColor colorWithHexString:@"#333333"];

    }
    return _goodsLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font =  [UIFont systemFontOfSize:__kNewSize(22)];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];

    }
    return _priceLabel;
}
-(UILabel *)zkpriceLabel{
    if (!_zkpriceLabel) {
        _zkpriceLabel = [[UILabel alloc]init];
        _zkpriceLabel.font =  [UIFont systemFontOfSize:__kNewSize(22)];
        _zkpriceLabel.numberOfLines = 1;
        _zkpriceLabel.textAlignment = NSTextAlignmentRight;
        _zkpriceLabel.textColor = [UIColor colorWithHexString:@"#ff4200"];

    }
    return _zkpriceLabel;
}
-(UILabel *)volumeLabel{
    if (!_volumeLabel) {
        _volumeLabel = [[UILabel alloc]init];
        _volumeLabel.font =  [UIFont systemFontOfSize:__kNewSize(22)];
        _volumeLabel.numberOfLines = 1;
        _volumeLabel.textAlignment = NSTextAlignmentRight;
        _volumeLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];

    }
    return _volumeLabel;
}
-(UILabel *)couponInfoLabel{
    if (!_couponInfoLabel) {
        _couponInfoLabel = [[UILabel alloc]init];
        _couponInfoLabel.font =  [UIFont systemFontOfSize:__kNewSize(22)];
        _couponInfoLabel.numberOfLines = 1;
        _couponInfoLabel.textAlignment = NSTextAlignmentCenter;
//        NSString *path = [[NSBundle mainBundle]pathForResource:@"discount_icon_coupon@2x"ofType:@"png"];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        _couponInfoLabel.layer.contents = (id)image.CGImage;
        _couponInfoLabel.textColor = [UIColor whiteColor];
        _couponInfoLabel.backgroundColor = [UIColor clearColor];

      
    }
    return _couponInfoLabel;
}
-(UILabel *)shopTitleLabel{
    if (!_shopTitleLabel) {
        _shopTitleLabel = [[UILabel alloc]init];
        _shopTitleLabel.font =  [UIFont systemFontOfSize:__kNewSize(22)];
        _shopTitleLabel.numberOfLines = 1;
        _shopTitleLabel.textAlignment = NSTextAlignmentLeft;
        _shopTitleLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    }
    return _shopTitleLabel;
}


#pragma mark - Setter Getter Methods
- (void)setYouLikeItem:(ItemModel *)youLikeItem
{
    if([youLikeItem.UserType integerValue] == 0){
        _userTypeImageView.alpha = 0;
        [self updateFrame:0];
    }else{
        _userTypeImageView.alpha = 1;
        [self updateFrame:1];
    }
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.PictUrl] placeholderImage:[UIImage imageNamed:@"discount_subject_not"]];
    _priceLabel.text = [NSString stringWithFormat:@"原价¥ %.2f",[youLikeItem.ZkFinalPrice floatValue]];
    _goodsLabel.text = youLikeItem.Title;
    _volumeLabel.text = [NSString stringWithFormat:@"销量：%@",youLikeItem.Volume];
    _couponInfoLabel.text = [NSString stringWithFormat:@"%@券",[STool returnCouponInfo:youLikeItem.CouponInfo]];
    _zkpriceLabel.text = [NSString stringWithFormat:@"券后：%@",[STool returnCouponInfo:youLikeItem.CouponInfo price:youLikeItem.ZkFinalPrice]];
    _shopTitleLabel.text = youLikeItem.ShopTitle;
    
    //返利
    CGFloat rate;
    if (youLikeItem.CommissionRate) {
        rate = [youLikeItem.CommissionRate floatValue];
    }else{
        rate = [youLikeItem.TkRate floatValue];
    }
    
    [self fanLiFinalPrice:[youLikeItem.ZkFinalPrice floatValue] CommissionRate:rate];
   
    
   
}

#pragma mark - 返利
-(void)fanLiFinalPrice:(CGFloat)price CommissionRate:(CGFloat)rate{
    CGFloat fl = price*(rate/100);
    if(fl > 0){
        _rateLabel.alpha = 1;
    }else{
        _rateLabel.alpha = 0;
    }
    GSLog(@"返利：%0.2f",fl);
    NSString *rateValue=[NSString stringWithFormat:@"再返%0.2f", fl];
    _rateLabel.text = rateValue;
}


-(void)updateFrame:(CGFloat)tag{
    if (tag == 0) {
//        [_userTypeImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(__kNewSize(20));
//            make.left.mas_equalTo(self.mas_left).offset(__kNewSize(6));
//            make.size.mas_equalTo(CGSizeMake(__kNewSize(0) ,__kNewSize(0)));
//
//        }];
//        [_goodsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_userTypeImageView);
//            make.left.mas_equalTo(_userTypeImageView.mas_right).offset(__kNewSize(12));
//            make.size.mas_equalTo(CGSizeMake(self.dc_width ,__kNewSize(26)));
//        }];
    }
   
}


@end
