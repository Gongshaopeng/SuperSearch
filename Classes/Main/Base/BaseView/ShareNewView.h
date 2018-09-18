//
//  ShareNewView.h
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/10/24.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger
{
    //可以当作任务分享
    CanBeSharedType,
    //不可当作任务分享
    CanNotSharedType,
    //已经分享过了
    HasBeenSharedType
    
}
ShareIsType;

typedef enum : NSUInteger
{
    //网页分享
    ShareWebPlatformType,
    //图片分享
    SharePhotoPlatformType,
    //文本分享
    ShareTextPlatformType
    
}
ShareNewPlatformType;


typedef enum : NSUInteger
{
    //正常分享展示
    ShareViewType,
    //任务分享展示
    ShareTaskViewType,
    //截屏分享展示
    ShareScreenshotsType
    
}
ShareViewPlatformType;

typedef enum : NSUInteger
{
    //查看攻略
    ShareLookClickType,
    //任务收益
    ShareTasClickType,
    //登录
    ShareLoginClickType,
    //任务分享
    ShareTaskWieXinClickType,
    //正常分享
    ShareTaskClickType,
    //分享失败
    ShareErrorClickType,
    //任务分享失败
    ShareTaskErrorClickType,
    //不可当作任务分享
    CanNotSharedTaskErrorType,
    //已经分享过了
    HasBeenSharedTaskErrorType,
    //取消分享
    CancelSharedTaskErrorType
    
}
ShareViewClickType;

@protocol ShareNewDelegate <NSObject>

@optional
-(void)shareCompletion;
-(void)shareDismiss;
-(void)shareClickType:(ShareViewClickType)shareClickType;

@end
/*
 * 是否检测到本地有可分享的软件 
 *
 * index : 0:没有 1:有
 */
//typedef  void (^IsShareBlock)(NSInteger index);

typedef  void (^ShareEditBlock)();

@interface ShareNewView : UIView

@property (nonatomic, assign) ShareNewPlatformType sharePlatform;//!<跳转分类功能页

@property (nonatomic, assign) ShareViewPlatformType shareType;//!<分享展示页样式

@property (nonatomic, assign) ShareViewClickType shareClickType;//!<分享功能区分

@property (nonatomic, assign) ShareIsType shareIsType;//!<是否可以当作任务分享

@property (nonatomic,copy) ShareEditBlock  shareEditBlock;


@property (nonatomic, weak)   id<ShareNewDelegate>delegate;

//=================================================================
@property (nonatomic,assign) BOOL isShow;//!<正在展示
@property (nonatomic,assign) BOOL isQQ;//!<QQ
@property (nonatomic,assign) BOOL isWX;//!<微信
@property (nonatomic,assign) BOOL isSina;//!<新浪
//=================================================================
@property (nonatomic,strong) UIWindow *window;//!<window
@property (nonatomic,strong) UIView *backgroundGrayView;//!<透明背景View
@property (nonatomic,strong) UIView * shareView;//!<分享背景

@property (nonatomic,strong) UIImageView * imageView;//图片
@property (nonatomic,strong) UIImageView * screenShotsImage;//截屏图片

@property (nonatomic,strong) UIImage * imageSe;//图片

@property (nonatomic,strong)UIButton * bianjiBtn;//!<编辑图片
@property (nonatomic,strong)UIButton * cancelShare;//!<取消
@property (nonatomic,strong)UILabel * lableShare;//!<没有分享app

@property (nonatomic,strong) NSString * titleShare;//!<分享标题
@property (nonatomic,strong) NSString * bodyShare;//!<分享内容
@property (nonatomic,strong) NSString * imageShare;//!<分享图片
@property (nonatomic,strong) NSData * imageData;//!<分享图片
@property (nonatomic, retain) id shareImage;

@property (nonatomic,strong) NSString * urlShare;//!<分享网址

//=================================================================

@property (nonatomic,strong) UIView * shareTaskView;//!<分享任务背景
@property (nonatomic,strong) UIView * descriptionView;//!<任务说明背景

@property (nonatomic,strong)UIButton * loginBtn;//!<登录／注册（按钮）

@property (nonatomic,strong)UIButton * wechatSessionBtn;//!<微信好友（按钮）
@property (nonatomic,strong)UIButton * WechatTimeLineBtn;//!<微信朋友圈（按钮）
@property (nonatomic,strong)UILabel * descriptionlable;//!<今日参与转发任务数量 0/5


@property (nonatomic,strong)UIButton * taskIncome;//!<任务收益
@property (nonatomic,strong)UIButton * taskDescription;//!<查看攻略

//=================================================================
/*
 *任务数据
 */

@property (nonatomic,strong) NSString * urlTaskShare;//!<分享任务网址
@property (nonatomic,strong) NSString * tid;//!<文章唯一Id
@property (nonatomic,strong) NSString * docid;//!<服务器文章唯一Id
@property (nonatomic,strong) NSString * shareTo;//!<分享类别 （0:朋友圈 1:微信好友 ）
@property (nonatomic,strong) NSString * ifShare;//!<任务是否可以分享 (0:分享已达上限 1:可以分享 2:已经分享过了 3:不能分享)
@property (nonatomic,strong) NSString * ifShareTwo;//!<新闻是否可以分享 (1可分享，0不可分享)

@property (nonatomic,strong) NSString * maxNumber;//!<最大任务数量
@property (nonatomic,strong) NSString * number;//!<已经做的任务数量


//=================================================================

/**
 *  分享样式 自定义 0:网页分享 1:图片分享
 */
//@property (nonatomic,strong) NSString *  sharePlatform;//!<分享样式 自定义


-(instancetype)initWithFrame:(CGRect)frame title:(NSArray *)itemTitleNameArray imager:(NSArray *)itemImageNameArray titleColor:(UIColor *)color;
+ (ShareNewView *)newShare;

-(void)show;
-(void)dismiss;
-(void)myBlockcompletion:(void(^)(void))completion;
-(void)newLablenumber:(NSString *)number maxNumber:(NSString *)maxNumber;
-(void)newShareBtnImage;


@end
