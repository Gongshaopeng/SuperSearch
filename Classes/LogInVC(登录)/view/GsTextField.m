//
//  GsTextField.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/4/19.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GsTextField.h"

@implementation GsTextField

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = self.leftLable;
        CALayer * leftBorder = [CALayer layer];
        leftBorder.frame = CGRectMake(0,__kNewSize(98), __kNewSize(630), __kNewSize(1));
    
        leftBorder.backgroundColor = [UIColor colorWithHexString:@"#c6c6c6"].CGColor;
        [self.layer addSublayer:leftBorder];
    }
    return self;
}

-(UILabel *)leftLable{
    if (!_leftLable) {
        _leftLable = [[UILabel alloc]init];
//        _labelLeft.frame = CGRectMake(0, 0, __kNewSize(128), __kNewSize(100));
//        _labelLeft.text = @"手机号码";
//        _labelLeft.textAlignment = NSTextAlignmentLeft;
//        _labelLeft.font = [UIFont systemFontOfSize:__kNewSize(28)];
//        _labelLeft.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _leftLable;
}

@end
