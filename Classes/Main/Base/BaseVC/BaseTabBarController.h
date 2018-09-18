//
//  BaseTabBarController.h
//  星火作文
//
//  Created by allen on 15/11/24.
//  Copyright © 2015年 com.juwan.easyzw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger ,BaseTabBarControllerType){
    SSTabBarControllerHome = 0,  //
    SSTabBarControllerHighdisCount = 1,  //
    SSTabBarControllerShoppingCart = 2, //
    SSTabBarControllerUser = 3, //
};

@interface BaseTabBarController : UITabBarController

/* 控制器type */
@property (assign , nonatomic)BaseTabBarControllerType tabVcType;



@end
