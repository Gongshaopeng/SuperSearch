//
//  GSHomeTopToolView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/23.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GSHomeTopToolView.h"

@interface GSHomeTopToolView ()
@property (nonatomic,strong) CAGradientLayer *gradient;
@end

@implementation GSHomeTopToolView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self setGSLayer];
        [self acceptanceNote];
    }
    return self;
}

- (void)setUpUI
{
 
    [self addSubview:self.searchButton];
   
    [self.layer insertSublayer:self.gradient atIndex:0];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, __kNewSize(20), 0, __kNewSize(20)));
        make.centerY.mas_equalTo(self).offset(topCenterY_y);
        make.size.mas_equalTo(CGSizeMake(__kScreenWidth__-__kNewSize(40), __kNewSize(62)));
    }];
}
-(void)setGSLayer{
       _gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor]colorWithAlphaComponent:0.4].CGColor,(id)[UIColor clearColor].CGColor,nil];
}
-(void)setGSLayerHide{
    
     _gradient.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,(id)[UIColor clearColor].CGColor,nil];
}
#pragma mark - 接受通知
- (void)acceptanceNote
{
    __kWeakSelf__;
    [[NSNotificationCenter defaultCenter]addObserverForName:SHOWTOPTOOLVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.backgroundColor = [UIColor whiteColor];
        _searchButton.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        [weakSelf setGSLayerHide];
    }];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:HIDETOPTOOLVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.backgroundColor = [UIColor clearColor];
        _searchButton.backgroundColor = [[UIColor colorWithHexString:@"#ffffff"]colorWithAlphaComponent:0.85];
        [weakSelf setGSLayer];
    }];
}

-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitle:@"输入淘宝/天猫 商品标题或关键词" forState:0];
        [_searchButton setTitleColor:[UIColor colorWithHexString:@"#777777"] forState:0];
        _searchButton.backgroundColor = [[UIColor colorWithHexString:@"#ffffff"]colorWithAlphaComponent:0.85];
        _searchButton.titleLabel.font = PFR13Font;
        [_searchButton setImage:[UIImage imageNamed:@"discount_search_icon"] forState:0];
        [_searchButton adjustsImageWhenHighlighted];
        _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * 10, 0, 0);
        _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
//        _searchButton.frame = CGRectMake(__kNewSize(20), 28, __kScreenWidth__-__kNewSize(40), __kNewSize(56));
        _searchButton.layer.cornerRadius = __kNewSize(62)/2;
        
       
        
        //将多余的部分切掉
        _searchButton.layer.masksToBounds = YES;
    }
    return _searchButton;
}
-(CAGradientLayer *)gradient{
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
        //设置开始和结束位置(设置渐变的方向)
        
        _gradient.startPoint = CGPointMake(0, 0);
        
        _gradient.endPoint = CGPointMake(0, 1);
        
        _gradient.frame =CGRectMake(0, 0, __kScreenWidth__, __kNavigationBarHeight__);
        
        _gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor]colorWithAlphaComponent:0.4].CGColor,(id)[UIColor clearColor].CGColor,nil];
        
    }
    return _gradient;
}

@end
