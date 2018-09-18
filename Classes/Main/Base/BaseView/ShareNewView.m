//
//  ShareNewView.m
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/10/24.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import "ShareNewView.h"
#import <UMShare/UMShare.h>
//#import <UMSocialCore/UMSocialCore.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
//#import "WeiboSDK.h"
#import "UIImageView+WebCache.h"

/*
 title:@[@"微信朋友圈",@"微信好友",@"QQ好友",@"QQ空间",@"新浪微博"] imager:@[@"share_1",@"share_2",@"share_3",@"share_4",@"share_5"] titleColor:[UIColor colorWithHexString:@"#333333"]
 */


@implementation ShareNewView

-(instancetype)initWithFrame:(CGRect)frame title:(NSArray *)itemTitleNameArray imager:(NSArray *)itemImageNameArray titleColor:(UIColor *)color{
    if (self = [super initWithFrame:frame]) {
        
        
        //        [self p_UI];
        //        [self p_layoutFrame];
        //        [self p_Init];
        //        [self p_AllColor];
        //        [self createKeyboardSToolsButton:itemTitleNameArray image:itemImageNameArray LableColor:color];
        
    }
    return self;
    
}
+ (ShareNewView *)newShare
{
    
    static ShareNewView* updateappearances = nil;
    static dispatch_once_t onceUpdateToken;
    dispatch_once(&onceUpdateToken, ^{
        updateappearances = [[ShareNewView alloc] init];
    });
    
    return updateappearances;
}

-(void)isDisPaly:(void (^)(void))disPaly Hide:(void (^)(void))hide{
    
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        //模拟器
         disPaly();
//         hide();
    }else{
        
        //真机
        if ([WXApi isWXAppInstalled]) {
            _isWX = YES;
        }else{
            _isWX = NO;
        }
        if ([QQApiInterface isQQInstalled]) {
            _isQQ = YES;
        }else{
            _isQQ = NO;
        }

        if(_isQQ == YES || _isWX == YES ){
            disPaly();
        }
        else
        {
            hide();
        }
    }

   
}

-(void)p_Init{
    
    NSMutableArray * titleArr = [[NSMutableArray alloc]init];
    NSMutableArray * imageArr = [[NSMutableArray alloc]init];
    
//    if ([WXApi isWXAppInstalled]) {
//        //没有安装微信
//        //        NSLog(@"安装微信");
//        [titleArr addObject:@"微信朋友圈"];
//        [titleArr addObject:@"微信好友"];
//        [imageArr addObject:@"share_1"];
//        [imageArr addObject:@"share_2"];
//    }
//    if ([QQApiInterface isQQInstalled]) {
//        //没有安装QQ
//        //        NSLog(@"安装QQ");
//        [titleArr addObject:@"QQ好友"];
//        [titleArr addObject:@"QQ空间"];
//        [imageArr addObject:@"share_3"];
//        [imageArr addObject:@"share_4"];
//    }
    
    [titleArr addObject:@"微信朋友圈"];
    [titleArr addObject:@"微信好友"];
    [imageArr addObject:@"share_1"];
    [imageArr addObject:@"share_2"];
    [titleArr addObject:@"QQ好友"];
    [titleArr addObject:@"QQ空间"];
    [imageArr addObject:@"share_3"];
    [imageArr addObject:@"share_4"];
    
    if (titleArr.count == 0) {
        [_shareView addSubview:self.lableShare];
    }else{
        [self createKeyboardSToolsButton:titleArr image:imageArr LableColor:[UIColor colorWithHexString:@"#777777"]];
    }
    if (self.shareType == ShareScreenshotsType)
    {
        
        _screenShotsImage.image = self.imageSe;
       
    }
}
-(void)p_UI{
    [self.window becomeKeyWindow];
    [self.window addSubview:self.backgroundGrayView];
    [self.window addSubview:self.cancelShare];
    [self.window addSubview:self.shareView];
    
        if(_isWX != NO){
            if(self.shareType == ShareTaskViewType){
                if ([STool isLogin] == NO) {
                    [_shareTaskView removeFromSuperview];
                    [_shareView addSubview:self.descriptionView];
        //            [self newShareBtnImage];
                }
                else
                {
                    [_shareTaskView removeFromSuperview];
                   
                        [_shareView addSubview:self.shareTaskView];
                }
            }else if (self.shareType == ShareScreenshotsType)
            {
                [self.window addSubview:self.screenShotsImage];
//                [window addSubview:self.bianjiBtn];
            }
        }
}

-(void)p_AllColor{
    
    
}

-(void)cencelViewClick{
    [self dismiss];
}


//隐藏
-(void)p_hideView{
    

    if (_isWX == NO) {
        _shareView.frame =CGRectMake(0,__kScreenHeight__, __kScreenWidth__, __kNewSize(274-40));
        _cancelShare.frame = CGRectMake(0, __kScreenHeight__, __kScreenWidth__, __kTabBarHeight__);
    }else{
        if(self.shareType == ShareTaskViewType){
            _shareView.frame =CGRectMake(0,__kScreenHeight__, __kScreenWidth__, __kNewSize(532-121));
            
            if ([STool isLogin] == NO) {
                _descriptionView.frame = CGRectMake(0, __kNewSize(205), __kScreenWidth__, __kNewSize(205));
            }else{
                _shareTaskView.frame = CGRectMake(0, __kNewSize(205), __kScreenWidth__, __kNewSize(205));
            }
            _cancelShare.frame = CGRectMake(0, __kScreenHeight__, __kScreenWidth__, __kTabBarHeight__);
        }else{
            if (self.shareType == ShareScreenshotsType)
            {
                _screenShotsImage.frame = CGRectMake(__kNewSize(100), __kScreenHeight__, __kScreenWidth__- __kNewSize(200), __kScreenHeight__ - __kNewSize(425));
                _bianjiBtn.frame = CGRectMake(30, 30, __kNewSize(0), __kNewSize(0));
            }
            _shareView.frame =CGRectMake(0,__kScreenHeight__, __kScreenWidth__, __kNewSize(274-40));
            _cancelShare.frame = CGRectMake(0, __kScreenHeight__, __kScreenWidth__, __kTabBarHeight__);
        }
    }

}
//展示
-(void)p_display{
    
    if (_isWX == NO) {
        _cancelShare.frame = CGRectMake(0, __kNewSize(940+274), __kScreenWidth__, __kNewSize(120));
        _shareView.frame =CGRectMake(0,__kNewSize(940+40), __kScreenWidth__, __kNewSize(274-40));
    }else{
            if(self.shareType == ShareTaskViewType){
            _shareView.frame =CGRectMake(0,__kScreenHeight__-__kNewSize(530), __kScreenWidth__, __kNewSize(532-121));

            if ([STool isLogin] == NO) {
                _descriptionView.frame = CGRectMake(0, __kNewSize(205), __kScreenWidth__, __kNewSize(205));
            }else{
                _shareTaskView.frame = CGRectMake(0, __kNewSize(205), __kScreenWidth__, __kNewSize(205));
            }
            _cancelShare.frame = CGRectMake(0, __kScreenHeight__-__kNewSize(120), __kScreenWidth__, __kNewSize(120));

        }else{
            if (self.shareType == ShareScreenshotsType)
            {
                _screenShotsImage.frame = CGRectMake(__kNewSize(100), __kNewSize(60), __kScreenWidth__- __kNewSize(200), __kScreenHeight__ - __kNewSize(425));
                _bianjiBtn.frame = CGRectMake(30, 30, __kNewSize(120), __kNewSize(60));

            }
            _cancelShare.frame = CGRectMake(0, __kNewSize(940+274), __kScreenWidth__, __kNewSize(120));
            _shareView.frame =CGRectMake(0,__kNewSize(940+40), __kScreenWidth__, __kNewSize(274-40));
        }
    }
}


-(void)setSToolBackgroundColor:(UIColor *)backgroundColor{
    
    _shareView.backgroundColor = backgroundColor;
    
}

-(void)show{
    __kWeakSelf__;
    [self isDisPaly:^{
        [weakSelf p_UI];
        [weakSelf p_layoutFrame];
        [weakSelf p_Init];
        [weakSelf p_AllColor];
//        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf p_display];
            _shareView.alpha = 1;
            _cancelShare.alpha = 1;
            _backgroundGrayView.alpha = 0.8;
            
        } completion:^(BOOL finished) {
            if (finished) {
                [weakSelf.imageView sd_setImageWithURL:[NSURL URLWithString:weakSelf.imageShare] placeholderImage:[UIImage imageNamed:@"about_bird_1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                }];
                
//                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        }];
        
        [UIView commitAnimations];
    } Hide:^{
        [weakSelf shareNative];
    }];
    self.isShow = YES ;

}

-(void)dismiss{
    __kWeakSelf__;
     [self isDisPaly:^{
//         [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
         [UIView animateWithDuration:0.3 animations:^{
             [weakSelf p_hideView];
             weakSelf.alpha = 0;
             _shareView.alpha = 0;
             _cancelShare.alpha = 0;
             _backgroundGrayView.alpha = 0;
             _screenShotsImage.alpha = 0;
         } completion:^(BOOL finished) {
             if (finished) {
              
                 [_shareView removeFromSuperview];
                 [_backgroundGrayView removeFromSuperview];
                 [_cancelShare removeFromSuperview];
                 [_lableShare removeFromSuperview];
                 [_screenShotsImage removeFromSuperview];
                 [weakSelf removeFromSuperview];
                 _shareView = nil;
                 _screenShotsImage = nil;
//                 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
             }
         }];
         [self.window resignKeyWindow];

         [UIView commitAnimations];
     } Hide:^{
         
     }];
    [self shareDelegateDismiss];
    self.isShow = NO ;
}

-(void)myBlockcomplvoidetion:(void(^)(void))completion {
    
    [UIView animateWithDuration:0.3 animations:^{
        [self p_hideView];
    } completion:^(BOOL finished) {
        
        if (finished) {
            completion();
        }
    }];
    [UIView commitAnimations];
    
    [self shareDelegateDismiss];
}


-(void)p_layoutFrame{
    
    [self p_hideView];
}

-(void)show:(CGRect)frame {
    //    [window addSubview:self];
    [self.window addSubview:self.shareView];
    [self.window addSubview:self.cancelShare];
    
//    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3 animations:^{
        _shareView.alpha = 1;
        _shareView.frame = frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
           
//            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }];
    [UIView commitAnimations];
}

- (void)dismiss:(CGRect)frame
{
//    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.2 animations:^{
        _shareView.frame = frame;
        self.alpha = 0;
        _shareView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            
            [_shareView removeFromSuperview];
            [_lableShare removeFromSuperview];
            [_cancelShare removeFromSuperview];
            [self removeFromSuperview];
//            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }];
    [UIView commitAnimations];
}
-(void)createKeyboardSToolsButton:(NSArray *)itmeArr image:(NSArray *)imageArr LableColor:(UIColor *)color
{
    for (NSInteger r = 0; r < itmeArr.count; r++) {
        UIControl * con = [_shareView viewWithTag:401+r];
        UIImageView * img = [con viewWithTag:601+r];
        UILabel * lab = [con viewWithTag:501+r];
        [img removeFromSuperview];
        [lab removeFromSuperview];
        [con removeFromSuperview];
    }
    
    CGFloat _hig ;
    
    if (self.shareType == ShareTaskViewType) {
        _hig = __kNewSize(40);
    }else{
        _hig = __kNewSize(74);
    }
    
    for (NSInteger i = 0; i < itmeArr.count; i++) {
        
        UIControl *control = [[UIControl alloc]init];
        
    
            control.frame =CGRectMake(__kNewSize(30)+(__kScreenWidth__ - __kNewSize(60))/itmeArr.count*i, _hig, (__kScreenWidth__ - __kNewSize(60))/itmeArr.count, __kNewSize(126));

        
        control.tag = 401+i;
        [control addTarget:self action:@selector(shareNewClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:control];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(((__kScreenWidth__ - __kNewSize(60))/itmeArr.count-__kNewSize(74))/2, 0, __kNewSize(74), __kNewSize(74))];
        imageView.tag = 601+i;
        imageView.image= [UIImage imageNamed:imageArr[i]];
        [control addSubview:imageView];
        
        UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, __kNewSize(74+30), control.bounds.size.width, __kNewSize(22))];
        titleLable.textColor = color;
        titleLable.text = itmeArr[i];
        titleLable.font = [UIFont systemFontOfSize:__kNewSize(22)];
        titleLable.adjustsFontSizeToFitWidth = YES;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        //        [self sizeToFit];
        titleLable.tag = 501+i;
        [control addSubview:titleLable];
        
    }
}
-(void)createTaskButton:(NSArray *)itmeArr image:(NSArray *)imageArr LableColor:(UIColor *)color
{
    for (NSInteger r = 0; r < itmeArr.count; r++) {
        UIControl * con = [_shareView viewWithTag:40001+r];
        UIImageView * img = [con viewWithTag:60001+r];
        UILabel * lab = [con viewWithTag:50001+r];
        [img removeFromSuperview];
        [lab removeFromSuperview];
        [con removeFromSuperview];
    }
    
    CGFloat _hig ;
    
    if (self.shareType == ShareTaskViewType) {
        _hig = __kNewSize(40);
    }else{
        _hig = __kNewSize(74);
    }
    
    for (NSInteger i = 0; i < itmeArr.count; i++) {
        
        UIControl *control = [[UIControl alloc]init];
        
        control.frame =CGRectMake(__kNewSize(30)+(__kScreenWidth__/2 - __kNewSize(93))/itmeArr.count*i, _hig, (__kScreenWidth__/2 - __kNewSize(93))/itmeArr.count, __kNewSize(126));
       
        control.tag = 40001+i;
        [control addTarget:self action:@selector(shareTaskClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareTaskView addSubview:control];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((control.bounds.size.width-__kNewSize(74))/2, 0, __kNewSize(93), __kNewSize(74))];
        imageView.tag = 60001+i;
        imageView.image= [UIImage imageNamed:imageArr[i]];
        [control addSubview:imageView];
        UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, __kNewSize(74+30), control.bounds.size.width, __kNewSize(22))];
        titleLable.textColor = color;
        titleLable.text = itmeArr[i];
        titleLable.font = [UIFont systemFontOfSize:__kNewSize(22)];
        titleLable.adjustsFontSizeToFitWidth = YES;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        //        [self sizeToFit];
        titleLable.tag = 50001+i;
        [control addSubview:titleLable];
        
    }
}
#pragma mark - 代理 事件
-(void)shareDelegateClickType:(ShareViewClickType)shareClickType{
    if ([self.delegate respondsToSelector:@selector(shareClickType:)])
    {
        [self.delegate shareClickType:shareClickType];
    }
    [self dismiss];
}
-(void)shareDelegateDismiss{

    if ([self.delegate respondsToSelector:@selector(shareDismiss)])
    {
        [self.delegate shareDismiss];
    }
}

#pragma mark - Click 事件
-(void)bianjiClick{
//    GSLog(@"啦啦啦啦啦啦啊啦啦啦啦啦啦啦啦啦啦啦啦啦啦");
    _shareEditBlock();
}
//descriptionCkick taskCkick  loginCkick
-(void)descriptionCkick{
    [self shareDelegateClickType:ShareLookClickType];
}
-(void)taskCkick{
    [self shareDelegateClickType:ShareTasClickType];
}
-(void)loginCkick{
    [self shareDelegateClickType:ShareLoginClickType];
}
-(void)shareNewClick:(UIButton *)btn{
    self.shareClickType = ShareTaskClickType;
    UMSocialPlatformType platformType;
//    GSLog(@"[ShareNewView newShare].ifShare2 %@",[ShareNewView newShare].ifShareTwo);

//    if ([self isShare2] == 1 ||self.sharePlatform == SharePhotoPlatformType ) {
  
    NSInteger _indexTyp = 0;
    _indexTyp = btn.tag - 401;
//        NSLog(@"------%ld",_indexTyp);
        
        
    switch (_indexTyp) {
        case 0:
        {
            if (_isWX == NO) {
                if (_isQQ == NO) {
//                    if (_isSina == NO) {
                    
//                    }else{
//                        platformType = UMSocialPlatformType_Sina;
//                        [self shareWithPlatformType:platformType];
//                    }
                }else{
                    platformType = UMSocialPlatformType_QQ;
                    [self shareWithPlatformType:platformType];
                }
            }else{
                platformType = UMSocialPlatformType_WechatTimeLine;
                [self shareWithPlatformType:platformType];

            }
        }
            break;
        case 1:
        {
            
            if (_isWX == NO) {
                if (_isQQ == NO) {
//                    if (_isSina == NO) {
//
//                    }else{
//                        platformType = UMSocialPlatformType_Sina;
//                        [self shareWithPlatformType:platformType];
//                    }
                }else{
                    platformType = UMSocialPlatformType_Qzone;
                    [self shareWithPlatformType:platformType];
                }
            }else{
                platformType = UMSocialPlatformType_WechatSession;
                [self shareWithPlatformType:platformType];
                
            }
        }
            break;
        case 2:
        {
            
                if (_isQQ == NO) {
//                    if (_isSina == NO) {
//
//                    }else{
//                        platformType = UMSocialPlatformType_Sina;
//                        [self shareWithPlatformType:platformType];
//                    }
                }else{
                    if(_isWX == NO){
                        platformType = UMSocialPlatformType_Sina;
                        [self shareWithPlatformType:platformType];
                    }else{
                        platformType = UMSocialPlatformType_QQ;
                        [self shareWithPlatformType:platformType];
                    }
                  
                }
           
        }
            break;
        case 3:
        {
            if (_isQQ == NO) {
//                if (_isSina == NO) {
//
//                }else{
//                    platformType = UMSocialPlatformType_Sina;
//                    [self shareWithPlatformType:platformType];
//                }
            }else{
                platformType = UMSocialPlatformType_Qzone;
                [self shareWithPlatformType:platformType];
            }

        }
            break;
        case 4:
        {
            if (_isSina == NO) {
                
            }else{
                platformType = UMSocialPlatformType_Sina;
                [self shareWithPlatformType:platformType];
            }
        }
            break;
            
        default:
            break;
    }
        
//    }else{
//        [self shareDelegateClickType:CanNotSharedTaskErrorType];
//
//    }
    
    
}


-(void)shareTaskClick:(UIButton *)btn{
    if([self isShare] == 1){
        self.shareClickType = ShareTaskWieXinClickType;
        
        UMSocialPlatformType platformType;
        
        NSInteger _indexTyp = 0;
        _indexTyp = btn.tag - 40001;
        //    NSLog(@"------%ld",_indexTyp);
        switch (_indexTyp) {
            case 0:
            {
                self.shareTo = @"0";
                platformType = UMSocialPlatformType_WechatTimeLine;
                [self shareWithPlatformType:platformType];
            }
                break;
            case 1:
            {
                self.shareTo = @"1";
                platformType = UMSocialPlatformType_WechatSession;
                [self shareWithPlatformType:platformType];
            }
                break;
                
            default:
                break;
        }

    }
    else if ([self isShare] == 3)
    {
        [self shareDelegateClickType:ShareTaskErrorClickType];
    }
    else if ([self isShare] == 2)
    {
        [self shareDelegateClickType:HasBeenSharedTaskErrorType];
    }
    else if ([self isShare] == 4)
    {
        [self shareDelegateClickType:CanNotSharedTaskErrorType];
    }
    else if ([self isShare] == 0)
    {
        [self shareDelegateClickType:ShareTaskErrorClickType];
    }
    
    
}
-(void)shareWithPlatformType:(UMSocialPlatformType)platformType
{
    [self shareWithPlatformIsERRORType:platformType];
}

-(void)shareWithPlatformIsERRORType:(UMSocialPlatformType)platformType
{
    [STCModel stcModel].openUrlType = 0;
        switch (self.sharePlatform) {
            case ShareWebPlatformType:
            {
                [self shareWebPageToPlatformType:platformType];
            }
                break;
            case SharePhotoPlatformType:
            {
                [self shareImageToPlatformType:platformType];
            }
                break;
            case ShareTextPlatformType:
            {
                [self shareTextToPlatformType:platformType];
            }
                break;
            default:
                break;
        }

    
}
#pragma mark - 公有方法


#pragma mark - 调用原生分享

-(void)shareNative{
//    __kWeakSelf__;
    
    if ([self.titleShare isEqualToString:@""]) {
        self.titleShare =__ShareTitle__;
    }
    if ([self.bodyShare isEqualToString:@""] ||self.bodyShare == nil) {
        self.bodyShare = __ShareBody__;
    }
    if ([self.imageShare isEqualToString:@""] ||self.imageShare == nil) {
        self.imageSe = [UIImage imageNamed:@"about_bird_1"];
    }else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageShare] placeholderImage:[UIImage imageNamed:@"about_bird_1"]];
    }
    //    self.imageSe = [UIImage imageNamed:@"about_bird_1"];
    
    //设置网页地址
//    NSString * url;
//    if (self.shareClickType == ShareTaskClickType) {
//        url = self.urlShare;
//    }else{
//        url = self.urlTaskShare;
//    }
    if (self.sharePlatform == ShareWebPlatformType) {
//        [ShareSTool itmeTitle:self.titleShare Icon:self.imageShare  placeholderImage:@"about_bird_1" Url:self.urlShare Complete:^(NSArray *itme) {
//            if (itme.count != 0) {
//                [ShareSTool shareWithItem:itme MySelf:[MaqueSTool getCurrentVC] completionHandler:^(UIActivityType  _Nullable activityType, BOOL completed) {
//                    GSLog(@"activityType %@",activityType);
//                    if (completed == YES) {
//                        //                    [weakSelf showHUDAddedTo:@"分享成功"];
////                        [self alertWithError:nil];
//
//                    }else{
//                        //                    [weakSelf showHUDAddedTo:@"取消分享"];
//                    }
//                }];
//            }
//
//        } error:^(NSString *errorStr) {
//
//            //        [weakSelf showHUDAddedTo:errorStr];
//        }];
        

    }
    else if (self.sharePlatform == SharePhotoPlatformType)
    {
        NSArray * arr = @[self.imageView];
//        [ShareSTool shareWithItem:arr MySelf:[MaqueSTool getCurrentVC] completionHandler:^(UIActivityType  _Nullable activityType, BOOL completed) {
//            GSLog(@"activityType %@",activityType);
//            if (completed == YES) {
//                //                    [weakSelf showHUDAddedTo:@"分享成功"];
////                [self alertWithError:nil];
//
//            }else{
//                //                    [weakSelf showHUDAddedTo:@"取消分享"];
//
//
//            }
//        }];

    }
   
}

#pragma mark - 私有方法

-(void)newLablenumber:(NSString *)number maxNumber:(NSString *)maxNumber
{
//    NSString *text = @"今日参与转发任务 ";
//    NSString * str = [NSString stringWithFormat:@"%@%@/%@",text,number,maxNumber];
//    [MaqueSTool gsNewLable:_descriptionlable Stringtext:str detailStrColor:[UIColor colorWithHexString:@"#ff3c51"] font:__kNewSize(24) MakeRangeLeft:[text length] MakeRangeRight:[number length]];
}

-(NSInteger)isShare{
    if ([ShareNewView newShare].ifShare == nil) {
        [ShareNewView newShare].ifShare = @"3";
    }
    return [[ShareNewView newShare].ifShare integerValue];
}
-(NSInteger)isShare2{
    if ([ShareNewView newShare].ifShareTwo == nil) {
        [ShareNewView newShare].ifShareTwo = @"1";
    }
    return [[ShareNewView newShare].ifShareTwo integerValue];
}

-(void)newShareBtnImage
{
    UIControl * con = [_shareTaskView viewWithTag:40001];
    UIControl * con2 = [_shareTaskView viewWithTag:40002];

    UIImageView * img = [con viewWithTag:60001];
    UIImageView * img2 = [con2 viewWithTag:60002];
    
    if([self isShare] == 0){
        img.image= [UIImage imageNamed:@"share_frind_noun"];
        img2.image= [UIImage imageNamed:@"share_wechat_noun"];
    }else{
        if ( _isWX == NO) {
            img.image= [UIImage imageNamed:@"share_frind_noun"];
            img2.image= [UIImage imageNamed:@"share_wechat_noun"];
        }else{
            img.image= [UIImage imageNamed:@"share_friend"];
            img2.image= [UIImage imageNamed:@"share_wechat"];
        }
    }
   

}

-(void)createLable:(UIView *)view{
    UILabel * lable1 = [[UILabel alloc]initWithFrame:CGRectMake(__kNewSize(44), __kNewSize(40), __kScreenWidth__/2, __kNewSize(26))];
    UILabel * lable2 = [[UILabel alloc]initWithFrame:CGRectMake(__kNewSize(44), __kNewSize(40+26+18), __kScreenWidth__/2, __kNewSize(26))];
    UILabel * lable3 = [[UILabel alloc]initWithFrame:CGRectMake(__kNewSize(44), __kNewSize(40+(26*2)+(18*2)), __kScreenWidth__/2, __kNewSize(26))];
    lable1.text = @"参加转发任务，朋友有效阅读,";lable2.text = @"每次送10～30小米，收益叠加";lable3.text = @"赶紧登录吧";
    lable1.textColor = [UIColor colorWithHexString:@"#777777"];
    lable2.textColor = [UIColor colorWithHexString:@"#ff3c51"];
    lable3.textColor = [UIColor colorWithHexString:@"#777777"];
    lable1.font = [UIFont systemFontOfSize:__kNewSize(24)];
    lable2.font = [UIFont systemFontOfSize:__kNewSize(24)];
    lable3.font = [UIFont systemFontOfSize:__kNewSize(24)];

    [view addSubview:lable1];[view addSubview:lable2];[view addSubview:lable3];
}

-(void)topLayer:(UIView *)view{
    
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(__kNewSize(44), 0,__kScreenWidth__-__kNewSize(44*2), __kNewSize(1));
    leftBorder.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    [view.layer addSublayer:leftBorder];
    
}

-(void)boomLayer:(UIView *)view{
    
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(__kNewSize(44), view.bounds.size.height-__kNewSize(1),__kScreenWidth__-__kNewSize(44*2), __kNewSize(1));
    leftBorder.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
    [view.layer addSublayer:leftBorder];
    
}

#pragma mark - 初始化UI
-(UIWindow *)window{
    if (!_window) {
        _window = [UIApplication sharedApplication].keyWindow;
    }
    return _window;
}
-(UIImageView *)screenShotsImage{
    if (!_screenShotsImage) {
        _screenShotsImage = [[UIImageView alloc]init];
        _screenShotsImage.alpha = 1;
        _screenShotsImage.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        //设置圆角
        _screenShotsImage.layer.cornerRadius = 6;
        //将多余的部分切掉
        _screenShotsImage.layer.masksToBounds = YES;
    }
    return _screenShotsImage;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
-(UILabel *)lableShare{
    if (!_lableShare) {
        _lableShare = [[UILabel alloc]initWithFrame:CGRectMake(0, (_shareView.frame.size.height-__kNewSize(100))/2, __kScreenWidth__, __kNewSize(100))];
        _lableShare.text = @"未检测到可分享APP！";
        _lableShare.font = [UIFont systemFontOfSize:__kNewSize(33)];
        _lableShare.textColor = [UIColor blackColor];
        _lableShare.textAlignment = NSTextAlignmentCenter;
    }
    return _lableShare;
}
-(UILabel *)descriptionlable{
    if (!_descriptionlable) {
        _descriptionlable = [[UILabel alloc]initWithFrame:CGRectMake(__kNewSize(458),__kNewSize(68), __kScreenWidth__-__kNewSize(458+44), __kNewSize(26))];
//        _descriptionlable.text = @"今日参与转发任务 0/5";
        _descriptionlable.font = [UIFont systemFontOfSize:__kNewSize(24)];
        _descriptionlable.textColor = [UIColor colorWithHexString:@"#777777"];
        _descriptionlable.textAlignment = NSTextAlignmentCenter;
//        [MaqueSTool gsNewLable:_descriptionlable Stringtext:@"今日参与转发任务 0/5" detailStrColor:[UIColor colorWithHexString:@"#ff3c51"] font:__kNewSize(24) MakeRangeLeft:9 MakeRangeRight:1];
    }
    return _descriptionlable;
}

-(UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc]init];
        _shareView.backgroundColor = [UIColor whiteColor];
    }
    return _shareView;
}

-(UIView *)backgroundGrayView{
    if (!_backgroundGrayView) {
        _backgroundGrayView = [[UIView alloc]init];
        _backgroundGrayView.frame = CGRectMake(0,0, __kScreenWidth__, __kScreenHeight__);
        _backgroundGrayView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cencelViewClick)];
        [_backgroundGrayView addGestureRecognizer:tap];
        
    }
    return _backgroundGrayView;
}
-(UIButton *)cancelShare{
    if (!_cancelShare) {
        _cancelShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelShare setImage:[UIImage imageNamed:@"STool_bird_11"] forState:UIControlStateNormal];
        //                [_cancelShare setTitle:@"取消" forState:UIControlStateNormal];
        //                [_cancelShare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelShare.backgroundColor = [UIColor whiteColor];
        //        _determineBtn.layer.masksToBounds = YES;
        //        _determineBtn.layer.cornerRadius = 2.0;
        //        _cancelBtn.layer.borderWidth = 1.0;
        //        CGColorRef colorref = [UIColor blackColor].CGColor;
        //        [_cancelBtn.layer setBorderColor:colorref];
        //        _deleteTMVBtn.jsonTheme.imageWithState(@"ident_14",UIControlStateNormal);
        
        _cancelShare.titleLabel.font = [UIFont systemFontOfSize: __kNewSize(36)];
//        UIView * xian = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, 1)];
//        xian.backgroundColor = [UIColor colorWithHexString:@"#e4e6eb"];
        //        [_cancelShare addSubview:xian];
        [_cancelShare addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _cancelShare;
}
-(UIButton *)bianjiBtn{
    if (!_bianjiBtn) {
        _bianjiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bianjiBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_bianjiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _bianjiBtn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(28)];
        _bianjiBtn.layer.masksToBounds = YES;
        _bianjiBtn.layer.cornerRadius = 2.0;
        _bianjiBtn.layer.borderWidth = 1.0;
        CGColorRef colorref = [UIColor whiteColor].CGColor;
        [_bianjiBtn.layer setBorderColor:colorref];
        _bianjiBtn.backgroundColor = [UIColor whiteColor];
        [_bianjiBtn addTarget:self action:@selector(bianjiClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _bianjiBtn;
}
-(UIView *)shareTaskView{
    if (!_shareTaskView) {
        _shareTaskView = [[UIView alloc]initWithFrame:CGRectMake(0, __kNewSize(205), __kScreenWidth__, __kNewSize(205))];
        _shareTaskView.backgroundColor = [UIColor whiteColor];
  
            [self createTaskButton:@[@"微信朋友圈",@"微信好友"] image:@[@"share_friend",@"share_wechat"] LableColor:[UIColor colorWithHexString:@"#777777"]];
    
        
        [_shareTaskView addSubview:self.descriptionlable];
        [_shareTaskView addSubview:self.taskIncome];
        [_shareTaskView addSubview:self.taskDescription];

        [self topLayer:_shareTaskView];
        [self boomLayer:_shareTaskView];
    }
    return _shareTaskView;
}

-(UIView *)descriptionView{
    if (!_descriptionView) {
        _descriptionView = [[UIView alloc]initWithFrame:CGRectMake(0, __kNewSize(205), __kScreenWidth__, __kNewSize(205))];
        _descriptionView.backgroundColor = [UIColor whiteColor];

        [self createLable:_descriptionView];
        [_descriptionView addSubview:self.loginBtn];
        [self topLayer:_descriptionView];
        [self boomLayer:_descriptionView];
    }
    return _descriptionView;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(__kScreenWidth__-__kNewSize(168+44), __kNewSize(205-74)/2, __kNewSize(168), __kNewSize(74));
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(28)];
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#de3031"];
        _loginBtn.layer.cornerRadius = 4;
        [_loginBtn addTarget:self action:@selector(loginCkick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _loginBtn;
}
-(UIButton *)wechatSessionBtn{
    if (!_wechatSessionBtn) {
        _wechatSessionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _wechatSessionBtn.frame = CGRectMake(__kScreenWidth__-__kNewSize(200+55+44), __kNewSize(205-(72+26+47)), __kNewSize(100), __kNewSize(26));
        _wechatSessionBtn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(24)];
        [_wechatSessionBtn setTitle:@"微信好友" forState:UIControlStateNormal];
        [_wechatSessionBtn setTitleColor:[UIColor colorWithHexString:@"#0fb6e8"] forState:UIControlStateNormal];
        
        [_wechatSessionBtn setImage:[UIImage imageNamed:@"share_wechat"] forState:UIControlStateNormal];
        //        _taskIncome.backgroundColor = [UIColor colorWithHexString:@"#de3031"];
        //        _taskIncome.layer.cornerRadius = 4;
    }
    return _wechatSessionBtn;
}
-(UIButton *)WechatTimeLineBtn{
    if (!_WechatTimeLineBtn) {
        _WechatTimeLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _WechatTimeLineBtn.frame = CGRectMake(__kScreenWidth__-__kNewSize(200+55+44), __kNewSize(205-(72+26+47)), __kNewSize(100), __kNewSize(26));
        _WechatTimeLineBtn.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(24)];
        [_WechatTimeLineBtn setTitle:@"微信朋友圈" forState:UIControlStateNormal];
        [_WechatTimeLineBtn setTitleColor:[UIColor colorWithHexString:@"#0fb6e8"] forState:UIControlStateNormal];
        [_WechatTimeLineBtn setImage:[UIImage imageNamed:@"share_friend"] forState:UIControlStateNormal];

        //        _taskIncome.backgroundColor = [UIColor colorWithHexString:@"#de3031"];
        //        _taskIncome.layer.cornerRadius = 4;
    }
    return _WechatTimeLineBtn;
}


-(UIButton *)taskIncome{
    if (!_taskIncome) {
        _taskIncome = [UIButton buttonWithType:UIButtonTypeCustom];
        _taskIncome.frame = CGRectMake(__kNewSize(458), __kNewSize((70+26+47)), __kNewSize(100), __kNewSize(26));
        _taskIncome.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(24)];
        [_taskIncome setTitle:@"任务收益" forState:UIControlStateNormal];
        [_taskIncome setTitleColor:[UIColor colorWithHexString:@"#0fb6e8"] forState:UIControlStateNormal];
//        _taskIncome.backgroundColor = [UIColor colorWithHexString:@"#de3031"];
//        _taskIncome.layer.cornerRadius = 4;
        [_taskIncome addTarget:self action:@selector(taskCkick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _taskIncome;
}
-(UIButton *)taskDescription{
    if (!_taskDescription) {
        _taskDescription = [UIButton buttonWithType:UIButtonTypeCustom];
        _taskDescription.frame = CGRectMake(__kScreenWidth__- __kNewSize(100+44), __kNewSize((70+26+47)), __kNewSize(100), __kNewSize(26));
        _taskDescription.titleLabel.font = [UIFont systemFontOfSize:__kNewSize(24)];
        [_taskDescription setTitle:@"查看攻略" forState:UIControlStateNormal];
        [_taskDescription setTitleColor:[UIColor colorWithHexString:@"#0fb6e8"] forState:UIControlStateNormal];
        //        _taskIncome.backgroundColor = [UIColor colorWithHexString:@"#de3031"];
        //        _taskIncome.layer.cornerRadius = 4;
        [_taskDescription addTarget:self action:@selector(descriptionCkick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _taskDescription;
}

#pragma mark - 分享逻辑
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = self.titleShare?:__ShareTitle__;
    //设置文本
    messageObject.text = self.bodyShare?:__ShareTitle__;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            //            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    
//    if(platformType == UMSocialPlatformType_WechatSession){
//        shareObject.thumbImage = [[UIImage imageWithData:_shareImage] zipGIF];
//        [shareObject setShareImage:[[UIImage imageWithData:_shareImage] zipGIF]];
//
//    }else{
        //如果有缩略图，则设置缩略图
        if (self.imageSe != nil) {
            shareObject.thumbImage = self.imageSe;            
        }else{
            shareObject.thumbImage = [UIImage imageWithData:_shareImage];
        }
        
        if(self.shareType == ShareScreenshotsType){
            [shareObject setShareImage:_imageSe];
        }else{
            if (_shareImage) {
                [shareObject setShareImage:_shareImage];
            }else{
                if (![_imageShare isEqualToString:@""]) {
                    if([_imageShare rangeOfString:@"wap.kuhack.com"].location !=NSNotFound)
                    {
                        NSArray *array = [_imageShare componentsSeparatedByString:@"url="];
                        if (array.count > 1) {
                            [shareObject setShareImage:array[1]];
                            //            GSLog(@"%@ %@",array[0],array[1]);
                        }
                    }else{
                        [shareObject setShareImage:_imageShare];
                    }
                }else{
                    [shareObject setShareImage:_imageSe];
                    
                }
                
            }
        }
        
//    }
   
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//分享图片和文字
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"about_bird_1"];
    [shareObject setShareImage:@"http://dev.umeng.com/images/tab2_1.png"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    __kWeakSelf__;
    if ([self.titleShare isEqualToString:@""]) {
        self.titleShare =__ShareTitle__;
    }
    if ([self.bodyShare isEqualToString:@""] ||self.bodyShare == nil) {
        self.bodyShare = __ShareBody__;
    }
    self.imageSe = [UIImage imageNamed:@"about_bird_1"];

    if ([self.imageShare isEqualToString:@""] ||self.imageShare == nil) {
        [weakSelf shareToPlatformType:platformType Image:self.imageSe];
    }else{
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageShare] placeholderImage:[UIImage imageNamed:@"about_bird_1"]];
        [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:_imageShare] placeholderImage:[UIImage imageNamed:@"about_bird_1"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        NSLog(@" 下载 %f",1.0*receivedSize/expectedSize);
            
            
                    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
                        if (image) {
                            self.imageSe = image;
                            [weakSelf shareToPlatformType:platformType Image:image];

                        }
                        if(error){
//                            weakSelf.imageSe = [UIImage imageNamed:@"about_bird_1"];
                            [weakSelf shareToPlatformType:platformType Image:weakSelf.imageSe];

                        }
                        
                      
                        
                    }];
        

    }
    //    self.imageSe = [UIImage imageNamed:@"about_bird_1"];
    
    
 
}
-(void)shareToPlatformType:(UMSocialPlatformType)platformType Image:(UIImage *)image{
    __kWeakSelf__;

    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象r
    UMShareWebpageObject *shareObject ;
    shareObject  = [UMShareWebpageObject shareObjectWithTitle:weakSelf.titleShare descr:weakSelf.bodyShare thumImage:image?:_imageShare];

    //设置网页地址
    shareObject.webpageUrl = __ShareUrl__;

    if (self.shareClickType == ShareTaskClickType) {
        
//        if ([Helper justWithInitRegularly:[HistoryData Scoredomain] Str:self.urlShare]) {
//            shareObject.webpageUrl =  [MaqueSTool isConfigurationUrl:[HistoryData sharedomainreplace] ReplaceUrl:weakSelf.urlShare];
//
//        }else{
//            shareObject.webpageUrl = weakSelf.urlShare;
//        }
    }else{
    }
    
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
//音乐分享
- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
    
}

//视频分享
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置视频网页播放地址
    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}



- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功！"];
//        [GSUMConfigInstance newGSevent:@"shareSuccess"];
        [self dismiss];
   
        switch (self.shareClickType) {
            case ShareTaskWieXinClickType:
            {
                [self shareDelegateClickType:ShareTaskWieXinClickType];
            }
                break;
            case ShareTaskClickType:
            {
                [self shareDelegateClickType:ShareTaskClickType];
            }
                break;
            default:
                break;
        }
      
    }
    else{
        if (error) {
            
            switch ((NSInteger)error.code) {
                case 2000:
                {
                    result = @"未知错误";
                }
                    break;
                case 2001:
                {
                    result = @"url scheme 没配置，或者没有配置-ObjC， 或则SDK版本不支持或则客户端版本不支持";
                }
                    break;
                case 2002:
                {
                    result = @"授权失败";
                }
                    break;
                case 2003:
                {
                    result = @"分享失败";
                }
                    break;
                case 2004:
                {
                    result = @"请求用户信息失败";
                }
                    break;
                case 2005:
                {
                    result = @"分享内容为空";
                }
                    break;
                case 2006:
                {
                    result = @"分享内容不支持";
                }
                    break;
                case 2007:
                {
                    result = @"schemaurl fail";
                }
                    break;
                case 2008:
                {
                    result = @"应用未安装。下载应用程序，才可赚更多的小米哦！";
                }
                    break;
                case 2009:
                {
                    result = @"取消操作";
                }
                    break;
                case 2010:
                {
                    result = @"网络异常";
                }
                    break;
                case 2011:
                {
                    result = @"第三方错误";
                }
                    break;
                case 2013:
                {
                    result = @"对应的 UMSocialPlatformProvider的方法没有实现";
                }
                    break;
                default:
                    break;
            }
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
//                                                            message:result
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//            [alert show];
//            [KSAlertView showWithTitle:@"分享" message1:result cancelButton:@"取消" commitType:KSAlertViewButtonCommit commitAction:^(UIButton *button) {
//                
//            }];
//            [GXToast showText:result position:GXToastPositionCenter duration:2.0];

        }
        else
        {
            result = [NSString stringWithFormat:@"分享失败！"];
//            [GXToast showText:result position:GXToastPositionCenter duration:2.0];

        }
    }

}


@end
