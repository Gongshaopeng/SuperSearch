//
//  DirectionsCell.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/26.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "DirectionsCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DirectionsCell ()


@end

@implementation DirectionsCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self layerFrame];
    }
    return self;
}

- (void)setUpUI
{
    [self addSubview:self.directionImageView];
    [self addSubview:self.numImageView];
    [_numImageView addSubview:self.numLabel];

}
-(void)layerFrame{
//    [_numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).offset(__kNewSize(26));
//        make.top.mas_equalTo(self.mas_top).offset(__kNewSize(2));
//        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(44)));
//    }];
//    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_numImageView).offset(__kNewSize(26));
//        make.top.mas_equalTo(_numImageView.mas_top).offset(__kNewSize(4));
//        make.size.mas_equalTo(CGSizeMake(__kNewSize(40), __kNewSize(30)));
//    }];
//    [_directionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.centerY.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(__kNewSize(450), __kNewSize(624)));
//    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(__kNewSize(26));
        make.top.mas_equalTo(self.mas_top).offset(__kNewSize(2));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(44)));
    }];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_numImageView).offset(__kNewSize(30));
        make.centerY.mas_equalTo(_numImageView);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(40), __kNewSize(30)));
    }];
    
    
    
    
}

-(UIImageView *)directionImageView{
    if (!_directionImageView) {
        
        _directionImageView = [[UIImageView alloc] init];
        _directionImageView.contentMode = UIViewContentModeScaleAspectFit;
        _directionImageView.backgroundColor = [UIColor whiteColor];
    }
    return _directionImageView;
}
-(UIImageView *)numImageView{
    if (!_numImageView) {
        
        _numImageView = [[UIImageView alloc] init];
//        _numImageView.contentMode = UIViewContentModeScaleAspectFill;
        _numImageView.image = [UIImage imageNamed:@"first_icon_step"];
//        NSString *path = [[NSBundle mainBundle]pathForResource:@"first_icon_step@2x"ofType:@"png"];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        _numImageView.layer.contents = (id)image.CGImage;
    }
    return _numImageView;
}
-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.font =  PFR12Font;
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.text = @"1";
        _numLabel.textColor = [UIColor whiteColor];
    }
    return _numLabel;
}
@end
