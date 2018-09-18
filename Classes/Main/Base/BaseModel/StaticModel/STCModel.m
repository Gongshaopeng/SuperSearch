//
//  STCModel.m
//  TESTDome
//
//  Created by 巩继鹏 on 16/6/13.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import "STCModel.h"

@implementation STCModel

static id _STC;
+ (instancetype)stcModel{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _STC = [[[self class] alloc] init];
        //        [_STC p_InitNew];
    });
    return _STC;
}
-(id)init{
    if (self = [super init]) {
//        self.channelID = @"0";
//        self.uName = @"麻雀君";
//        //        self.adpid = __kURLTencentPID__;
//        //        self.newshareurl = __URL_Details_Task__;
//        self.isPopVideo = 1;
//        self.isPopAppstore = 0;
//        self.isPopGesture = 0;
//        self.isChannelCreate = 0;
//        self.isHomeOrChannel = 1;
//        self.isChannel = 0;
//        self.nowIndex = @"1";
//        self.homeSel = @"0";
//        self.titleHomeGG = @"广告";
//        self.urlHomeGG = @"http://m.91maque.com";
//        //        self.imgUrlHomeGG = @"http://testadmin.91maque.com/AdInfo/ADInfoImg/20161230/2016123016171478331.png";
//        self.netWorkNEW = 1;
//        self.cardIndex = 0;
//        self.isView = 1;
//        self.baidupid = @"1013059f";
//        self.ua = @"XiaoMi/MiuiBrowser/8.5.6 MaqueBrowser/";
//        self.apiurl = @"";
//        self.configError = @"0";
//        self.baiduChannelAppId = @"f7b64fd5";
//        self.homenavi = @"0";
//        self.feedback = @"0";
//        self.Userprotocol = @"0";
//        //        self.scoredomain = @"^((http://news\\.91maque\\.com/)|(http://video\\.91maque\\.com/))";
//        //        self.scorexs = @"0.0004";
//        //        self.minnewstime = @"10";
//        //        self.videotime = @"30-60";
//        //        self.newstime = @"1-5";
//        self.seamlessBrowsing = [DEFAULTS integerForKey:__DEF_KEY_SeamlessBrowsing]?:0;
//        self.addViewArr = [[NSMutableArray alloc] init];
//        self.addImageArr = [[NSMutableArray alloc] init];
//        self.allSelectArr = [[NSMutableArray alloc] init];
        //        self.raver = [NewTimeTool getTime];
        
    }
    return self;
}

@end

