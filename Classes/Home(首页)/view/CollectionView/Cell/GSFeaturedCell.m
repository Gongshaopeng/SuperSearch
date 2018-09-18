//
//  GSFeaturedCell.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/15.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GSFeaturedCell.h"

#import <UIImageView+WebCache.h>



@interface GSFeaturedCell ()
@property (nonatomic,strong) UIView *featuredView;
/* imageView */
@property (strong , nonatomic)UIImageView *featuredImageView;

@end
@implementation GSFeaturedCell
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
    
    [self addSubview:self.featuredImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
  
    [_featuredImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.dc_width, __kNewSize(160)));
//        make.center.mas_equalTo(self);
//        make.centerX.mas_equalTo(self);
//        make.centerY.mas_equalTo(self);
        
    }];
}

-(void)setGridItem:(GSGridItem *)gridItem{
    [_featuredImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.Image]placeholderImage:[UIImage imageNamed:@"default_49_11"]];

}

-(void)setFeatArr:(NSArray *)featArr
{
    if (!_featuredView) {
    [self addSubview:self.featuredView];

    NSInteger count = featArr.count;
        NSInteger  num = [STool returnCountFirstNumber:count andSecondNumber:2];

    _featuredView.frame = CGRectMake(0, 0, __kScreenWidth__, __kNewSize(160)*num);
        
    for (int i=0; i<count; i++)
    {
        UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake((i%2)*(__kScreenWidth__)/2,(i/2)*__kNewSize(160),(__kScreenWidth__)/2,__kNewSize(160))];
        control.tag = 100+i;
        [control addTarget:self action:@selector(featuredClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, control.frame.size.width, control.frame.size.height)];
//        [imageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
        imageview.contentMode =  UIViewContentModeScaleAspectFit;
//        imageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        imageview.clipsToBounds = YES;
//        imageview.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
        [imageview sd_setImageWithURL:[NSURL URLWithString:featArr[i]] placeholderImage:[UIImage imageNamed:@"discount_good_not"]];
        control.backgroundColor = [UIColor whiteColor];
        [control addSubview:imageview];
        [_featuredView addSubview:control];
        [self leftLayerButton:imageview];
        [self bottomLayerButton:imageview];
        
        }
      }
}

-(void)featuredClick:(UIControl *)con{
    GSLog(@"%ld",con.tag-100);
    
    if ([self.delegate respondsToSelector:@selector(myGSFeaturedClicked:)])
    {
        [self.delegate myGSFeaturedClicked:con.tag - 100];
    }
}

#pragma mark -  layer

-(void)leftLayerButton:(UIView *)view{
    
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0, 0, __kNewSize(1), view.frame.size.height);
    leftBorder.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.2].CGColor;
    [view.layer addSublayer:leftBorder];
    
}

-(void)bottomLayerButton:(UIView *)view{
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0, view.bounds.size.height-__kNewSize(1), view.bounds.size.width, __kNewSize(1));
    leftBorder.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
    [view.layer addSublayer:leftBorder];
    
}

-(UIImageView *)featuredImageView{
    if (!_featuredImageView) {
        _featuredImageView = [[UIImageView alloc]init];
        _featuredImageView.contentMode =  UIViewContentModeScaleAspectFit;
        _featuredImageView.clipsToBounds = YES;
        [self leftLayerButton:_featuredImageView];
        [self bottomLayerButton:_featuredImageView];
//        _featuredImageView.layer.masksToBounds = YES;
//        _featuredImageView.layer.cornerRadius = __kNewSize(105)/2;
//        _featuredImageView.layer.borderWidth = 1;
//        _featuredImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    return _featuredImageView;
}


-(UIView *)featuredView{
    if (!_featuredView) {
        _featuredView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kNewSize(420))];
        _featuredView.backgroundColor = [UIColor whiteColor];
//        _featuredView.layer.cornerRadius = 10;
//        //将多余的部分切掉
//        _featuredView.layer.masksToBounds = YES;
//        _featuredView.layer.borderWidth = __kNewSize(2);
//        _featuredView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _featuredView;
}

@end
