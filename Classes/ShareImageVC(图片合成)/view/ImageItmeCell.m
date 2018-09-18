//
//  ImageItmeCell.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/5/31.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "ImageItmeCell.h"
#import <UIImageView+WebCache.h>


@interface ImageItmeCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *ImageView;

@end

@implementation ImageItmeCell
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
    [self addSubview:self.ImageView];

}
//- (void)setModel:(ItemModel *)model{
//    [_ImageView sd_setImageWithURL:[NSURL URLWithString:model.PictUrl] placeholderImage:nil];
//}
//- (void)setImgArr:(NSArray *)imgArr{
//    [_ImageView sd_setImageWithURL:[NSURL URLWithString:model.PictUrl] placeholderImage:nil];
//}
- (void)setImgUrl:(NSString *)imgUrl{
        [_ImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:0];
        make.size.mas_equalTo(CGSizeMake(self.dc_width , self.dc_width));
        
    }];
}
-(UIImageView *)ImageView{
    if (!_ImageView) {
        _ImageView = [[UIImageView alloc]init];
//        _ImageView.layer.masksToBounds = YES;
//        _ImageView.layer.cornerRadius = __kNewSize(105)/2;
        _ImageView.layer.borderWidth = 1;
        _ImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    return _ImageView;
}
@end
