//
//  supSearchTopView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/26.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "SupSearchTopView.h"

@interface SupSearchTopView ()
@property (nonatomic,strong) UIImageView * topBackImageView;//背景图
@property (nonatomic ,strong) UIButton  *searchButton;//!< 搜索按钮
@property (nonatomic ,strong) UIButton  *rightBtn;//!< 搜索按钮
@property (nonatomic,strong) UITextField *searchTextField; //!< 搜索框


@end
@implementation SupSearchTopView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_UI];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, __kNewSize(46), 0, __kNewSize(46)));
        make.top.mas_equalTo(self.mas_top).offset(__kNewSize(274));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(674), __kNewSize(80)));
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(_searchButton).insets(UIEdgeInsetsMake(0, __kNewSize(674-144), 0, 0));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(144), __kNewSize(80)));
    }];
}

-(void)p_UI{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"first_search_bg-@2x"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.layer.contents = (id)image.CGImage;
    [self addSubview:self.searchButton];
    [_searchButton addSubview:self.rightBtn];
}




-(UIButton *)searchButton{
    
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitle:@"输入淘宝/天猫 商品标题或关键词" forState:0];
        [_searchButton setTitleColor:[UIColor colorWithHexString:@"#777777"] forState:0];
        _searchButton.titleLabel.font = PFR13Font;
        [_searchButton setImage:[UIImage imageNamed:@"search_icon"] forState:0];
        [_searchButton adjustsImageWhenHighlighted];
        _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, __kNewSize(26+18+6), 0, 0);
        _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, __kNewSize(26), 0, 0);
        //        _searchButton.frame = CGRectMake(__kNewSize(20), 28, __kScreenWidth__-__kNewSize(40), __kNewSize(56));
        _searchButton.backgroundColor = [UIColor whiteColor];
        _searchButton.layer.cornerRadius = __kNewSize(80)/2;
        [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];

      
        //将多余的部分切掉
        _searchButton.layer.masksToBounds = YES;
    }
    return _searchButton;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"搜索" forState:0];
        [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:0];
        _rightBtn.titleLabel.font = PFR13Font;
        _rightBtn.backgroundColor = [UIColor colorWithHexString:@"#fa8773"];
        [_rightBtn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rightBtn;
}

-(void)searchButtonClick{
    if ([self.delegate respondsToSelector:@selector(mySupSearchTopClicked)])
    {
        [self.delegate mySupSearchTopClicked];
    }
}

@end
