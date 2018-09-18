//
//  AppDelegate.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/2/27.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "searchProtocolLmpl.h"

#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
//#import "AEManager.h"
#import "UIImageView+WebCache.h"

#ifndef ALIBCTRADEMINISDK

#import "UTMini/AppMonitor.h"
#import<UTMini/AppMonitor.h>
#import <OpenMtopSDK/TBSDKLogUtil.h>
#import <TUnionTradeSDK/TUnionTradeSDK.h>
#import <AlipaySDK/AlipaySDK.h>
#import <AlipaySDK/APayAuthInfo.h>
#import "UIImageView+WebCache.h"
#import "GSUMShare.h"


#endif
#import "BaseTabBarController.h"
#import "HomeVC.h"
#import "SSAppversionTool.h"
#import "NewFeatureVC.h"
#import "AdpopupsView.h"
#import "PasteboardpopView.h"
#import "GoodsSetVC.h"

@interface AppDelegate ()
@property (nonatomic,strong) PasteboardpopView * pasteboardpopView;
@property (nonatomic,strong) AdpopupsView * popView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   [self initAlibcTrade];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self setUpRootVC]; //跟控制器判断
    [self.window makeKeyAndVisible];
    [self setUpFixiOS11];
    [GSUMShare setShare];
    return YES;
}

-(void)initAlibcTrade{
    
  
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];//开发阶段打开日志开关，方便排查错误信息
    [[AlibcTradeSDK sharedInstance] setIsvVersion:@"1.0.0"];
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    [[AlibcTradeSDK sharedInstance] setIsForceH5:YES];
    
    // 配置全局的淘客参数
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.adzoneId = __al_MM_Adzone_Id__;
    taokeParams.pid = __al_MM_Pid__;
    taokeParams.extParams = @{@"taokeAppkey":__al_MM_AppKey__};
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    [[AlibcTradeSDK sharedInstance] setISVCode:@"SuperSearch_isv_code"];//设置全局的app标识，在电商模块里等同于isv_cod
  
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        GSLog(@"初始化成功");
    } failure:^(NSError *error) {
        GSLog(@"初始化失败");
        
    }];
}

#pragma mark - 根控制器
- (void)setUpRootVC
{
    if ([BUNDLE_VERSION isEqualToString:[SSAppversionTool ss_GetLastOneAppVersion]]) {//判断是否当前版本号等于上一次储存版本号
        
        self.window.rootViewController = [[BaseTabBarController alloc] init];
    }else{
        
        [SSAppversionTool ss_SaveNewAppVersion:BUNDLE_VERSION]; //储存当前版本号
        
        // 设置窗口的根控制器
        NewFeatureVC *dcFVc = [[NewFeatureVC alloc] init];
        [dcFVc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
            
            *imageArray = @[@"welcome_1",@"welcome_2",@"welcome_3",@"welcome_4"];
            *showPageCount = YES;
            *showSkip = YES;
        }];
        self.window.rootViewController = dcFVc;
    }
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 如果百川处理过会返回YES
    if (![[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        // 处理其他app跳转到自己的app
        
    }
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
//    return result;
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

//IOS9.0 系统新的处理openURL 的API
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    GSLog(@"applicationopenURL: %@",url);
    BOOL isSDK;
    if ([STCModel stcModel].openUrlType == 1) {
        isSDK =[[AlibcTradeSDK sharedInstance] application:application openURL:url options:options];//处理其他app跳转到自己的app，如果百川处理过会返回YES
    }else  if ([STCModel stcModel].openUrlType == 0){
        isSDK =   [[UMSocialManager defaultManager] handleOpenURL:url];
    }else{
        isSDK = YES;
    }

    return isSDK;
}

#pragma mark - 当APP接收到内存警告的时候
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager]cancelAll]; //取消所有下载
    [[SDWebImageManager sharedManager].imageCache clearMemory]; //立即清除缓存
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      [NOTIFCATIONCENTER postNotification:[NSNotification notificationWithName:ENTERBACKGRUOUND object:nil userInfo:nil]];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

//    double delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ //执行事件
//    });
        
    [self pastePopView];

  
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)pastePopView{
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    
    GSLog(@"剪切板%@ %@  %@", paste.string,paste.URL,paste.name);
    //2.匹配字符串
    NSString *string =paste.string;
    if (![paste.string isEqualToString:@""]) {
        //如果是淘口令
//        if ([string containsString:@"￥"]) {
//            string = [NSString removeSpaceAndNewline:string];
//            NSRange range = [string rangeOfString:@"￥"];
//            NSString *str2 = [string substringFromIndex:range.location+1];//str4 = "jiemu"
//            NSRange range1 = [str2 rangeOfString:@"￥"];
//            NSString *str3 = [str2 substringToIndex:range1.location];//str3 = "my"
//            NSString *str4 = [NSString stringWithFormat:@"￥%@￥",str3];
//            string = str4;
//            [self requestWirelessShareTpwdQuery:@{@"password_conten":string}];
//
//        }else if([string containsString:@"€"]){
//            string = [NSString removeSpaceAndNewline:string];
//            NSRange range = [string rangeOfString:@"€"];
//            NSString *str4 = [string substringFromIndex:range.location+1];//str4 = "jiemu"
//            NSRange range1 = [str4 rangeOfString:@"€"];
//            NSString *str3 = [str4 substringToIndex:range1.location];//str3 = "my"
//            string = str3;
        
            //如果有麻雀优惠券
            if([string containsString:@"麻雀优惠券"]){
                if ([string containsString:@"（"]) {
                    string = [NSString removeSpaceAndNewline:string];
                    NSRange range = [string rangeOfString:@"（"];
                    NSString *str4 = [string substringFromIndex:range.location+1];//str4 = "jiemu"
                    NSRange range1 = [str4 rangeOfString:@"）"];
                    NSString *str3 = [str4 substringToIndex:range1.location];//str3 = "my"
                    string = str3;

                }
            }else if ([string containsString:@"【"]){
                //如果range.location > 0 是淘宝联盟 反之是 淘宝
                NSRange range = [string rangeOfString:@"【"];
                if (range.location > 0) {
                    if ([string containsString:@"【"]){
                        string = [NSString removeSpaceAndNewline:string];
                        NSRange range = [string rangeOfString:@"【"];
                        NSString *str3 = [string substringToIndex:range.location];//str3 = "my"
                        string = str3;
                    }
                }else{
                    if ([string containsString:@"【"]){
                        string = [NSString removeSpaceAndNewline:string];
                        NSRange range = [string rangeOfString:@"【"];
                        NSString *str4 = [string substringFromIndex:range.location+1];//str4 = "jiemu"
                        NSRange range1 = [str4 rangeOfString:@"】"];
                        NSString *str3 = [str4 substringToIndex:range1.location];//str3 = "my"
                        string = str3;
                    }
                }
            }else{
                //非淘口令
            }
            
//        }
    
        NSLog(@"substringWithRange=====%@",string);
        NSLog(@"截取的值为：%@",string);
        [self requestDgItemCouponGet:string];

    }
}
-(void)requestDgItemCouponGet:(NSString *)string{
    __kWeakSelf__;

    [[[searchProtocolLmpl alloc]init] r_Search_DgItemCouponGet:[RequestModel modelWithDictionary:@{@"adzone_id":__al_MM_Adzone_Id__,@"q":string?:@"",@"page_no":@"1",@"page_size":@"1"}] complete:^(ResponseModel *model) {
        if ([model.Status integerValue] == 1) {
            [UIPasteboard generalPasteboard].string = @"";
            for (NSDictionary * dict in model.Datas) {
                TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
                
                if (iModel.CouponClickUrl != nil) {
                    if([STCModel stcModel].vcType != 1){
                        [weakSelf.pasteboardpopView setCouponModel:iModel];
                        [weakSelf.popView pop];
                        
                        _pasteboardpopView.SearchComplete =^{
                            //通过通知中心发送通知
                            [NOTIFCATIONCENTER postNotification:[NSNotification notificationWithName:CLIPBOARDREQUESTPOPSearch object:nil userInfo:dict]];
                            
                            [weakSelf.popView dismiss];
                        };
                        _pasteboardpopView.GoodsComplete = ^{
                            
                            //通过通知中心发送通知
                            [NOTIFCATIONCENTER postNotification:[NSNotification notificationWithName:CLIPBOARDREQUESTPOPGoods object:nil userInfo:dict]];
                            [weakSelf.popView dismiss];
                        };
                        weakSelf.popView.popComplete = ^(){
                            [NOTIFCATIONCENTER postNotification:[NSNotification notificationWithName:CLIPBOARDREQUESTPOP object:nil userInfo:dict]];
                        };
                        weakSelf.popView.dismissComplete = ^(){
                            [NOTIFCATIONCENTER postNotification:[NSNotification notificationWithName:CLIPBOARDREQUESTPOPDismiss object:nil userInfo:dict]];
                            
                        };
                        
                    }
                }
            }
        }
        
        
    } failed:^(RequestFailedError error) {
        [UIPasteboard generalPasteboard].string = @"";

    }];
}

-(void)requestWirelessShareTpwdQuery:(NSDictionary *)dict{
    [[[searchProtocolLmpl alloc]init] r_Search_WirelessShareTpwdQuery:[RequestModel modelWithDictionary:dict appType:@"1"] complete:^(ResponseModel *model) {
        
    } failed:^(RequestFailedError error) {
        
    }];
}

#pragma mark - 适配
- (void)setUpFixiOS11
{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}
-(PasteboardpopView *)pasteboardpopView{
    if (!_pasteboardpopView) {
        _pasteboardpopView = [[PasteboardpopView alloc]initWithFrame:CGRectMake((__kScreenWidth__ - __kNewSize(580))/2, __kNewSize(40), __kNewSize(580), __kNewSize(390+565))];
        _pasteboardpopView.backgroundColor = [UIColor whiteColor];
        _pasteboardpopView.layer.masksToBounds = YES;
        _pasteboardpopView.layer.cornerRadius = __kNewSize(20);
        
    }
    return _pasteboardpopView;
}
-(AdpopupsView *)popView{
    if (!_popView) {
   
        _popView = [[AdpopupsView alloc] initWithCustomView:_pasteboardpopView popStyle:GSAnimationPopStyleScale dismissStyle:GSAnimationDismissStyleScale newStyle:GSAnimationPopStyledissBtn];
    _popView.popBGAlpha = 0.5f;
    _popView.isClickBGDismiss = YES;
   
         }
    return _popView;
}
@end
