//
//  GridListCollectionViewCell.m
//  Grid-List
//
//  Created by LeeJay on 16/10/17.
//  Copyright © 2016年 Mob. All rights reserved.
//  代码下载地址https://github.com/leejayID/List2Grid

#import "GridListCollectionViewCell.h"
#import "UIImageView+WebCache.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface GridListCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *volumeLabel;

@end

@implementation GridListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI
{
    _imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageV];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_priceLabel];
    
    _volumeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _volumeLabel.textColor = [UIColor greenColor];
    _volumeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_volumeLabel];
}

- (void)setIsGrid:(BOOL)isGrid
{
    _isGrid = isGrid;
    
    if (isGrid) {
        _imageV.frame = CGRectMake(5, 5, self.bounds.size.width - 60, self.bounds.size.width - 60);
        _titleLabel.frame = CGRectMake(5, self.bounds.size.width - 45, ScreenWidth/2, 20);
        _priceLabel.frame = CGRectMake(5, self.bounds.size.width - 20, ScreenWidth/2, 20);
        _volumeLabel.frame = CGRectMake(5, self.bounds.size.width - 20, ScreenWidth/2, 20);

    } else {
        _imageV.frame = CGRectMake(5, 5, self.bounds.size.height - 10, self.bounds.size.height - 10);
        _titleLabel.frame = CGRectMake(self.bounds.size.height + 10, 0, ScreenWidth/2, self.bounds.size.height - 20);;
        _priceLabel.frame = CGRectMake(self.bounds.size.height + 10, self.bounds.size.height - 30, ScreenWidth/3, 20);;
        _volumeLabel.frame = CGRectMake(self.bounds.size.height + 10+ScreenWidth/3, self.bounds.size.height - 30, ScreenWidth/3, 20);;

    }
}

- (void)setModel:(ItemModel *)model
{
    _model = model;
    _titleLabel.text = model.Title;
    _volumeLabel.text = [NSString stringWithFormat:@"月销量:%@",model.Volume];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.ZkFinalPrice];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.PictUrl]];
}

@end
