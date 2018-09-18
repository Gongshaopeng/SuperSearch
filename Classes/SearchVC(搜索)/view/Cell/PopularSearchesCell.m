//
//  PopularSearchesCell.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/26.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "PopularSearchesCell.h"

@interface PopularSearchesCell ()
{
    CGFloat tagListHight;
}
/* 标题lable */
@property (strong , nonatomic)UILabel *popularTitleLabel;
/* 底部标题lable */
@property (strong , nonatomic)UILabel *popularBotttomTitleLabel;

@end
@implementation PopularSearchesCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
//        [self layoutFrame];
    }
    return self;
}
-(void)setListHot:(NSArray *)listHot{
    self.popularTitleLabel.text = @"热门搜索";
//    [self.tagList setupSubViewsWithTitles:@[@"女装", @"小白鞋",@"背包",@"春装男",@"春装新款女",@"家居",@"手机配件"]];
    [self.tagList setupSubViewsWithTitles:listHot];
//    tagListHight = _tagList.contentSize.height-(_tagList.contentSize.height/5);
    self.popularBotttomTitleLabel.text = @"商品查券  教程说明";
    
   
}
- (void)setUpUI
{
    

   
}

//- (void)layoutFrame
- (void)layoutSubviews
{
    [super layoutSubviews];

        [self.popularTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, __kNewSize(26), 0, 0));
            make.top.mas_equalTo(self.mas_top).offset(__kNewSize(0));
            make.size.mas_equalTo(CGSizeMake(__kNewSize(160), __kNewSize(30)));
        }];
    
        [self.tagList mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_popularTitleLabel.mas_bottom).offset(__kNewSize(22));
            make.top.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(__kNewSize(50), __kNewSize(26), __kNewSize(82), __kNewSize(26)));
//            make.width.mas_equalTo(__kScreenWidth__-__kNewSize(52));
//            GSLog(@"%f",_tagList.contentSize.height);
//            make.size.mas_equalTo(CGSizeMake( __kScreenWidth__-__kNewSize(52), __kNewSize(tagListHight)));
        }];
    
        [self.popularBotttomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, __kNewSize(26), 0,  __kNewSize(26)));
        make.bottom.mas_equalTo(self.mas_bottom).offset(__kNewSize(-52));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(674), __kNewSize(30)));
        }];
    
}

-(UILabel *)popularTitleLabel{
    if (!_popularTitleLabel) {
        _popularTitleLabel = [[UILabel alloc]init];
        _popularTitleLabel.font =  PFR14Font;
        _popularTitleLabel.numberOfLines = 1;
        _popularTitleLabel.textAlignment = NSTextAlignmentLeft;
        _popularTitleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        [self addSubview:_popularTitleLabel];
     
    }
    return _popularTitleLabel;
}

-(UILabel *)popularBotttomTitleLabel{
    if (!_popularBotttomTitleLabel) {
        _popularBotttomTitleLabel = [[UILabel alloc]init];
        _popularBotttomTitleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:__kNewSize(30)];
        _popularBotttomTitleLabel.numberOfLines = 1;
        _popularBotttomTitleLabel.textAlignment = NSTextAlignmentCenter;
        _popularBotttomTitleLabel.textColor = [UIColor colorWithHexString:@"#97a0ad"];
        [self addSubview:_popularBotttomTitleLabel];
    }
    return _popularBotttomTitleLabel;
}
-(KMTagListView *)tagList{
    if (!_tagList) {
        
       _tagList = [[KMTagListView alloc]init];
        _tagList.delegate_ = self;
//        CGRect rect = _tagList.frame;
        
//        rect.size.height = tagListHight;
//        _tagList.frame = rect;
        [self addSubview:_tagList];

    }
    return _tagList;
}
#pragma mark - KMtagListListViewDelegate
- (void)ptl_TagListView:(KMTagListView*)tagListView didSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content
{
    NSLog(@"content: %@ index: %zd", content, index);
    if ([self.delegate respondsToSelector:@selector(mySupSearchSelectTagViewAtIndex:selectContent:)])
    {
        [self.delegate mySupSearchSelectTagViewAtIndex:index selectContent:content];
    }
}
@end
