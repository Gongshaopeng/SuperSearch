//
//  TBUSerModel.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/2.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "TBUSerModel.h"

@implementation TBUSerModel
static id _STC;
+ (instancetype)userModel{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _STC = [[[self class] alloc] init];
    });
    return _STC;
}
-(id)init{
    if (self = [super init]) {
 
    }
    return self;
}
@end
