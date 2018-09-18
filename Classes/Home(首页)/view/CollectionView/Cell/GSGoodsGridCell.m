//
//  GSGoodsGridCellCell.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/14.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GSGoodsGridCell.h"
#import <UIImageView+WebCache.h>



@interface GSGoodsGridCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *gridImageView;
/* gridLabel */
@property (strong , nonatomic)UILabel *gridLabel;
/* backGridView */
@property (strong , nonatomic)UIView *backGridView;

@end
@implementation GSGoodsGridCell

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

    [self addSubview:self.gridLabel];
    [self addSubview:self.gridImageView];
   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(__kNewSize(32));
//        make.left.mas_equalTo(self).mas_offset(__kNewSize(50));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(104), __kNewSize(105)));
        make.centerX.mas_equalTo(self);
    }];
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_gridImageView.mas_bottom).mas_offset(__kNewSize(6));
        //        make.left.mas_equalTo(self).mas_offset(__kNewSize(50));
        make.height.mas_equalTo( __kNewSize(24));
        make.centerX.mas_equalTo(self);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setGridItem:(GSGridItem *)gridItem
{
    _gridItem = gridItem;
    _gridLabel.text = gridItem.Title;
    
    if (_gridItem.Image.length == 0) return;
    if ([[_gridItem.Image substringToIndex:4] isEqualToString:@"http"]) {
        
        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.Image]placeholderImage:[UIImage imageNamed:@"discount_icon_not"]];
    }else{
        _gridImageView.image = [UIImage imageNamed:_gridItem.Image];
    }
}

- (void)setGridItemArr:(NSArray *)gridItemArr
{
    
    if (!_backGridView) {
        _backGridView = [[UIView alloc]init];
//        _backGridView.layer.cornerRadius = 10;
//        //将多余的部分切掉
//        _backGridView.layer.masksToBounds = YES;
        [self addSubview:_backGridView];
        _backGridView.backgroundColor = [UIColor whiteColor];
    
    NSInteger count = gridItemArr.count;
        //
       NSInteger roH;
        if (count <= 4) {
            roH = 4;
        }else{
            roH = count;
        }
        
        
        
    GSGridItem *gridItem ;

        //间距
        CGFloat margin = (( __kScreenWidth__) -(PIC_WIDTH*COL_COUNT))/(COL_COUNT+1);
        
    //行数
        NSInteger  num = [STool returnCountFirstNumber:roH andSecondNumber:COL_COUNT];
        _backGridView.frame =CGRectMake(0, 0, __kScreenWidth__,margin +(PIC_HEIGHT +margin)*num);

    for (int i=0; i<count; i++)
    {
        UIControl *control = [[UIControl alloc]init];
        // 行
        NSInteger row = i / COL_COUNT;
        //列
        NSInteger col = i % COL_COUNT;
       
        //pointX
        CGFloat picX =margin + (PIC_WIDTH +margin) * col;
        //pointY
        CGFloat picY = margin +(PIC_HEIGHT +margin) * row;
        
        control.frame = CGRectMake(picX, picY, PIC_WIDTH, PIC_HEIGHT);

        gridItem = gridItemArr[i];
        _gridItem = gridItem;
        control.tag = 120+i;
        [control addTarget:self action:@selector(btnGridClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backGridView addSubview:control];
//        control.backgroundColor = [UIColor redColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((control.bounds.size.width-__kNewSize(105))/2, 0, __kNewSize(105), __kNewSize(105))];
        imageView.tag = 44444+i;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = __kNewSize(105)/2;
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor=[UIColor whiteColor].CGColor;
        if (_gridItem.Image.length == 0) return;
//        if ([[_gridItem.Image substringToIndex:4] isEqualToString:@"http"]) {
        
            [imageView sd_setImageWithURL:[NSURL URLWithString:gridItem.Image]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
//        }else{
//            imageView.image = [UIImage imageNamed:_gridItem.Image];
//        }
//        imageView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
        [control addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, imageView.frame.size.height+__kNewSize(6), control.bounds.size.width, __kNewSize(24));
        label.text = gridItem.Title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:__kNewSize(24)];
        label.tag = 55555+i;
        label.textColor = [UIColor colorWithHexString:@"#4e4e4e"];
        [control addSubview:label];
        
    }
          }
}

-(void)btnGridClick:(UIControl *)con{
     GSLog(@"%ld",con.tag-120);

        if ([self.delegate respondsToSelector:@selector(myGSGoodsGridClicked:)])
        {
            [self.delegate myGSGoodsGridClicked:con.tag - 120];
        }
}
-(UIImageView *)gridImageView{
    if (!_gridImageView) {
        _gridImageView = [[UIImageView alloc]init];
        _gridImageView.layer.masksToBounds = YES;
        _gridImageView.layer.cornerRadius = __kNewSize(105)/2;
        _gridImageView.layer.borderWidth = 1;
        _gridImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    return _gridImageView;
}
-(UILabel *)gridLabel{
    if (!_gridLabel) {
        _gridLabel = [[UILabel alloc]init];
        _gridLabel.textAlignment = NSTextAlignmentCenter;
        _gridLabel.font = [UIFont systemFontOfSize:__kNewSize(24)];
        _gridLabel.textColor = [UIColor colorWithHexString:@"#4e4e4e"];
    }
    return _gridLabel;
}
@end
