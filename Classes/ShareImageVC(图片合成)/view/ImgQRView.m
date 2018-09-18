//
//  ImgQRView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/6/1.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "ImgQRView.h"
#import <UIImageView+WebCache.h>
#import "SGQRCodeTool.h"
#import "tbkProtocolImpl.h"
#import "searchProtocolLmpl.h"

@interface ImgQRView ()
@property (nonatomic,strong)id<tbkProtocol>tbkImpl;
@property (nonatomic,strong)id<searchProtocol>searchImpl;

/* 图片 */
@property(nonatomic ,strong) UIImageView * imageTopView;
/* 优惠券背景图片 */
@property (strong , nonatomic)UIImageView *couponInfoImageView;
/* 二维码图片 */
@property (strong , nonatomic)UIImageView *qrImageView;
/* 标题 */
@property(nonatomic ,strong) UILabel * titleLable;
/* 原价 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 折扣价 */
@property (strong , nonatomic)UILabel *zkpriceLabel;
/* 销量 */
@property (strong , nonatomic)UILabel *volumeLabel;
/* 优惠券面额 */
@property (strong , nonatomic)UILabel *couponInfoLabel;

@end
@implementation ImgQRView
#pragma mark - 数据请求
-(void)request:(NSString *)url{
    self.tbkImpl = [[tbkProtocolImpl alloc]init];
    self.searchImpl = [[searchProtocolLmpl alloc]init];
    NSArray * listArr = @[url];
//    [self.tbkImpl  r_tb_TaobaoTbkSpreadGet:[RequestModel modelWithDictionary:@{@"requests":@[url]}]  complete:^(resultsModel *model) {
//
//    } failed:^(NSString *error) {
//
//    }];
    [self.searchImpl r_Search_SpreadGet:[RequestModel modelWithDictionary:@{@"urls":listArr}] complete:^(ResponseModel *model) {
        GSLog(@"%@",model);
        for (NSDictionary * dict in model.Datas) {
            SpreadModel * iModel = [[SpreadModel alloc]initWithDictionary:dict error:nil];
            //        GSLog(@"\n name: %@ \n 优惠券: %@ \n 现价: %@",iModel.Title,iModel.CouponInfo,iModel.ZkFinalPrice);
            _qrImageView.image = [SGQRCodeTool SG_generateWithLogoQRCodeData:iModel.Content?:@"" logoImageName:@"about_bird_1" logoScaleToSuperView:0.2];
            
        }
    } failed:^(RequestFailedError error) {
        
    }];
}



#pragma mark - 数据填充
- (void)setItemM:(ItemModel *)itemM{
    [_imageTopView sd_setImageWithURL:[NSURL URLWithString:itemM.PictUrl] placeholderImage:[UIImage imageNamed:@"discount_subject_not"]];
    _priceLabel.text = [NSString stringWithFormat:@"原价¥ %.2f",[itemM.ZkFinalPrice floatValue]];
    _titleLable.text = itemM.Title;
//    _volumeLabel.text = [NSString stringWithFormat:@"销量：%@",itemM.Volume];
    _couponInfoLabel.text = [NSString stringWithFormat:@"%@券",[STool returnCouponInfo:itemM.CouponInfo]];
    _zkpriceLabel.text = [NSString stringWithFormat:@"券后：%@",[STool returnCouponInfo:itemM.CouponInfo price:itemM.ZkFinalPrice]];
    GSLog(@"CouponClickUrl : %@",itemM.CouponClickUrl);
    [self request:itemM.CouponClickUrl];
  

}

- (void)setImageUrl:(NSString *)imageUrl{
    [_imageTopView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"discount_subject_not"]];
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self layoutSubviewsFrame];
    }
    return self;
}
- (void)setUpUI
{
    [self addSubview:self.imageTopView];
    [self addSubview:self.titleLable];
    [self addSubview:self.priceLabel];
    [self addSubview:self.zkpriceLabel];
    [self addSubview:self.couponInfoImageView];
    [_couponInfoImageView addSubview:self.couponInfoLabel];
    [self addSubview:self.qrImageView];

}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
- (void)layoutSubviewsFrame
{

    [_imageTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:0];
        make.size.mas_equalTo(CGSizeMake(__kNewSize(546) , __kNewSize(546)));
        
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageTopView.mas_bottom).offset(__kNewSize(20));
        make.left.mas_equalTo(self.mas_left).offset(__kNewSize(12));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(546)-__kNewSize(200) ,__kNewSize(30*2)));
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imageTopView).offset(__kNewSize(12));
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.top.mas_equalTo(_titleLable.mas_bottom).offset(__kNewSize(14));
        
    }];
    [_couponInfoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imageTopView).offset(__kNewSize(12));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(100) ,__kNewSize(36)));
        make.top.mas_equalTo(_priceLabel.mas_bottom).offset(__kNewSize(14));
        
    }];
    [_couponInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_couponInfoImageView);
        make.size.mas_equalTo(_couponInfoImageView);
        
    }];
    //
    [_zkpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_couponInfoImageView.mas_right).offset(__kNewSize(10));
        make.width.mas_equalTo(self).multipliedBy(0.3);
        make.top.mas_equalTo(_couponInfoImageView);
        
    }];
    [_qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageTopView.mas_bottom).mas_offset(__kNewSize(20));
        make.right.mas_equalTo(self).mas_offset(__kNewSize(-10));
        make.bottom.mas_equalTo(self).mas_offset(__kNewSize(-10));

        make.size.mas_equalTo(CGSizeMake(__kNewSize(169) ,__kNewSize(169)));

    }];
}

#pragma mark - UI
- (UIImageView *)imageTopView{
    if (!_imageTopView) {
        _imageTopView = [[UIImageView alloc]init];
        [_imageTopView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _imageTopView.contentMode =  UIViewContentModeScaleAspectFill;
        _imageTopView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _imageTopView.clipsToBounds  = YES;
//                _imageTopView.layer.masksToBounds = YES;
//                _imageTopView.layer.cornerRadius = __kNewSize(105)/2;
//                _imageTopView.layer.borderWidth = 1;
//                _imageTopView.layer.borderColor=[UIColor whiteColor].CGColor;
//                _imageTopView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
        
    }
    return _imageTopView;
}

-(UIImageView *)couponInfoImageView{
    if (!_couponInfoImageView) {
        _couponInfoImageView = [[UIImageView alloc]init];
        _couponInfoImageView.image =[UIImage imageNamed:@"discount_icon_coupon"];
    }
    return _couponInfoImageView;
}
-(UIImageView *)qrImageView{
    if (!_qrImageView) {
        _qrImageView = [[UIImageView alloc]init];
//        _qrImageView.image =[UIImage imageNamed:@"discount_icon_coupon"];
        _qrImageView.backgroundColor = [UIColor blackColor];
    }
    return _qrImageView;
}
-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font =  [UIFont systemFontOfSize:__kNewSize(24)];
        _titleLable.numberOfLines = 2;
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
        
    }
    return _titleLable;
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
        _zkpriceLabel.textAlignment = NSTextAlignmentLeft;
        _zkpriceLabel.textColor = [UIColor colorWithHexString:@"#ff4200"];
        
    }
    return _zkpriceLabel;
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
@end
