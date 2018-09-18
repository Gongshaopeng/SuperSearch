//
//  SearchView.h
//  星火作文
//
//  Created by 巩继鹏 on 15/11/25.
//  Copyright © 2015年 com.juwan.easyzw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol backVCDelegate <NSObject>

@optional

-(void)sentReportDeletebtnClicked;

@end

@interface SearchView : UIView
@property (nonatomic ,strong) UIView    *bgView;//!< 背景视图
@property (nonatomic ,strong) UIButton  *searchBtn;//!< 搜索按钮
@property (nonatomic,strong) UITextField *searchTextField; //!< 搜索框
@property (nonatomic,strong) UIImageView *imgv; //!< 搜索框
@property (nonatomic,strong) UIView *xianS;  //!<底部线条

@property (nonatomic,strong) UIButton * videoBtn;//!<视频弹窗按钮

//@property (nonatomic, weak)   id<backVCDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;

-(void)playVideoButtonIs:(BOOL)isHidVideo;

@end
