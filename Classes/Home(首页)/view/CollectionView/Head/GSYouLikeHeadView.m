//
//  GSYouLikeHeadView.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/15.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GSYouLikeHeadView.h"


// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface GSYouLikeHeadView ()

@end

@implementation GSYouLikeHeadView

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
    if (!_likeImageView) {
 
    _likeImageView = [[UIImageView alloc] init];
    _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_likeImageView];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(__kNewSize(360), __kNewSize(30)));
    }];
}

#pragma mark - Setter Getter Methods

@end
