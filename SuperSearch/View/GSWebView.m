
//    Copyright © 2011-2016 向小辉. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.

#import "GSWebView.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#import <WebKit/WebKit.h>
#endif

#define IgnorePerformSelectorLeakWarning(code) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wnonnull\"") \
code \
_Pragma("clang diagnostic pop")

#define IgnoreSelectorWarning(code) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"--Wundeclared-selector\"") \
code \
_Pragma("clang diagnostic pop")


@interface GSWebViewConfiguration : WKWebViewConfiguration @end

@implementation GSWebViewConfiguration

- (instancetype)init
{
    if (self = [super init]) {
        self.userContentController = [[WKUserContentController alloc] init];
        self.allowsInlineMediaPlayback = YES;
        //        self.allowsAirPlayForMediaPlayback = YES;
        //        self.mediaPlaybackRequiresUserAction = false;
        self.preferences.minimumFontSize = 10;
        //        WKProcessPool * process = [[WKProcessPool alloc]init];
        //        self.processPool = process;
        self.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
    }
    return self;
}

@end

/**********************************************************************************************************/

@interface GSWebView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIWebViewDelegate,SlideLeftOrRightDelegate>

@property (nonatomic) BOOL canGoBack;
@property (nonatomic) BOOL canGoForward;
@property (nonatomic) BOOL isNavigator;

@end

@interface GSWebView (GSPrivateMethod)


- (void)excuteJavaScriptWithMethodName:(NSString *)name parameter:(id)param;
- (void)excuteFuncWithName:(NSString *)name;

@end

@implementation GSWebView 
{
    NSPointerArray * _pointers;
//    __strong UIView * _webView;
}
-(void)wkgsDealloc{
    
    if ([_webView isKindOfClass:[WKWebView class]]) {
        ((WKWebView *)_webView).scrollView.delegate = nil;
        ((WKWebView *)_webView).UIDelegate = nil;
        ((WKWebView *)_webView).navigationDelegate = nil;
        [((WKWebView *)_webView) loadHTMLString:@"" baseURL:nil];
        [((WKWebView *)_webView) stopLoading];
        [((WKWebView *)_webView) removeFromSuperview];
        [((WKWebView *)_webView).configuration.userContentController removeAllUserScripts];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        GSLog(@" wkWebView 释放啦");
    }else if([_webView isKindOfClass:[UIWebView class]]){
        [self gsDealloc];
    }
}
- (void)dealloc
{
    if ([_webView isKindOfClass:[WKWebView class]]) {
        ((WKWebView *)_webView).scrollView.delegate = nil;
        ((WKWebView *)_webView).UIDelegate = nil;
        ((WKWebView *)_webView).navigationDelegate = nil;
        [((WKWebView *)_webView) loadHTMLString:@"" baseURL:nil];
        [((WKWebView *)_webView) stopLoading];
        [((WKWebView *)_webView) removeFromSuperview];
        [((WKWebView *)_webView).configuration.userContentController removeAllUserScripts];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        GSLog(@" wkWebView 释放啦");
    }else if([_webView isKindOfClass:[UIWebView class]]){
        [self gsDealloc];
    }
    _webView = nil;
}
-(void)gsDealloc{
    GSLog(@" UIWebView 释放啦");
    if ([_webView isKindOfClass:[UIWebView class]]) {
        ((UIWebView *)_webView).delegate = nil;
        [((UIWebView *)_webView) loadHTMLString:@"" baseURL:nil];
        [((UIWebView *)_webView) stopLoading];
        [((WKWebView *)_webView) removeFromSuperview];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    IgnorePerformSelectorLeakWarning(return [self initWithFrame:frame JSPerformer:nil];)
}

#pragma mark - 补充
//-(YJWebProgressLayer *)webProgressLayer{
//    if (!_webProgressLayer) {
//        _webProgressLayer = [[YJWebProgressLayer alloc] init];
//        _webProgressLayer.frame = CGRectMake(0, __kNewSize(-2), __kScreenWidth__, __kNewSize(1));
////        [_webView.layer addSublayer:self.webProgressLayer];
//    }
//    return _webProgressLayer;
//}
//
//-(UIProgressView *)progressView{
//    if (!_progressView) {
//        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,0, __kScreenWidth__,3)];
//        _progressView.tintColor =[UIColor colorWithHexString:@"#2e96f0"];
//        _progressView.trackTintColor = [UIColor whiteColor];
//
//    }
//return _progressView;
//}
-(PanLoad *)pan{
    if (!_pan) {
        _pan = [[PanLoad alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__)];
        _pan.slideDelegate =self;
        [_pan setPanGestureRecognizer:_webView];
    }
    return _pan;
}
#pragma  mark - 添加左划右划手势

-(BOOL)swipeIsClass{
    if (_webView.canGoBack == YES) {
        return YES;

    }else{
        return NO;

    }
//    if (_webView.canGoForward == YES) {
//        return NO;
//    }else{
//        return YES;
//    }
}
//-(void)swipePoint:(CGPoint)point pan:(UIPanGestureRecognizer *)pan{
//    //    NSLog(@"point:%f",point.x);
//    if ([self.delegate respondsToSelector:@selector(gsPoint:pan:)]) {
//        [self.delegate gsPoint:point pan:pan];
//    }
//}
//-(void)swipeLeft{
//
//}
//-(void)swipeRight{
//
//}

static long const kGSJSValueKey    = 1100;
static long const kGSJSContextKey  = 1000;

- (JSContext *)jsContext
{
    return objc_getAssociatedObject(self, &kGSJSContextKey);
}

- (JSValue *)jsValue
{
    return objc_getAssociatedObject(self, &kGSJSValueKey);
}

- (instancetype)initWithFrame:(CGRect)frame JSPerformer:(nonnull id)performer
{
    if (self = [super initWithFrame:frame]) {
        _pointers = [NSPointerArray weakObjectsPointerArray];
        [_pointers addPointer:(__bridge void * _Nullable)(performer)];
        if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0)
            //            [self configureUIWebViewWithFrame:frame];
        [self configureWKWebViewWithFrame:frame];
    }else{
        [self configureUIWebViewWithFrame:frame];
        
    }
    return self;
}
- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    [self loadURL:[NSURL URLWithString:URLString]];
    
}

- (void)loadHTMLString:(NSString *)HTMLString {
    [self loadHTMLString:HTMLString baseURL:nil];
}

- (void)loadRequest:(NSURLRequest *)request
{
    _request = request;
    if ([_webView isKindOfClass:[WKWebView class]])
    {
        [(WKWebView *)_webView loadRequest:request];
    }else{
        [(UIWebView *)_webView loadRequest:request];
    }
    
    
}

- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL
{
    if ([_webView isKindOfClass:[WKWebView class]]){
        [(WKWebView *)_webView loadHTMLString:string baseURL:baseURL];
    }else{
        [(UIWebView *)_webView loadHTMLString:string baseURL:baseURL];
        
    }
}

- (id)performer
{
    return [_pointers pointerAtIndex:0];
}

- (void)excuteJavaScript:(NSString *)javaScriptString completionHandler:(void(^)(id params, NSError * error))completionHandler
{
    if ([_webView isKindOfClass:[WKWebView class]]) {
        [(WKWebView *)_webView evaluateJavaScript:javaScriptString completionHandler:^(id param, NSError * error){
            if (completionHandler) {
                completionHandler(param,error);
            }
        }];
    }else{

        JSValue * value = [self.jsContext evaluateScript:javaScriptString];
        if (value && completionHandler) {
            completionHandler([value toObject],NULL);
        }
    }
}

- (void)setDataDetectorTypes:(GSDataDetectorTypes)dataDetectorTypes
{
    if ([_webView isKindOfClass:[UIWebView class]]){
        ((UIWebView *)_webView).dataDetectorTypes = (UIDataDetectorTypes)dataDetectorTypes;
    }else{
        if ([((WKWebView *)_webView).configuration respondsToSelector:@selector(setDataDetectorTypes:)]) {
            [((WKWebView *)_webView).configuration setDataDetectorTypes:(WKDataDetectorTypes)dataDetectorTypes];
        }
    }
}

/***********************************************************************************************************************/

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * url = [NSString stringWithFormat:@"%@",request.URL];
    NSString *str = @"itunes";
    NSString *yidian = @"yidian";
    NSString * about = @"about";
    
    if ([request.URL.scheme isEqualToString:about]) {
        return NO;
    }
    if ([request.URL.scheme isEqualToString:yidian]) {
        return NO;
    }
    
    if ([url containsString:str]) {
        if ([DEFAULTS integerForKey:__DEF_KEY_OPENAPP] == 0) {
            [self.delegate gswebView:self shouldStartLoadWithRequest:request navigationType:(GSWebViewNavigationType)navigationType];
            return NO;
        }
        else  if ([DEFAULTS integerForKey:__DEF_KEY_OPENAPP] == 1)
        {
            [self.delegate gswebView:self shouldStartLoadWithRequest:request navigationType:(GSWebViewNavigationType)navigationType];
            if([STCModel stcModel].isAlert == 0){
                return NO;
            }else{
                return YES;
            }
        }
        else if ([DEFAULTS integerForKey:__DEF_KEY_OPENAPP] == 2)
        {
            return YES;
        }
        return NO;
    }
    return [self delegate:webView shouldStartLoadWithRequest:request navigationType:(GSWebViewNavigationType)navigationType];
    //    if ([self.delegate respondsToSelector:@selector(gswebView:shouldStartLoadWithRequest:navigationType:)]) {
    //        return [self.delegate gswebView:self shouldStartLoadWithRequest:request navigationType:(GSWebViewNavigationType)navigationType];
    //    }
    //    return YES;
}
-(BOOL)delegate:(UIWebView *)web shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(GSWebViewNavigationType)navigationType
{
    //back delegate
//    if([MaqueTool newIsHttp:request.URL.scheme]){
//        //        NSLog(@"是吗");
    
        return [self.delegate gswebView:self shouldStartLoadWithRequest:request navigationType:(GSWebViewNavigationType)navigationType];
//    }else{
//        //        NSLog(@"不是吗");
//        return [MaqueTool newIsHttp: request.URL.scheme];
//    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //    self.webProgressLayer.frame = CGRectMake(0, __kNewSize(-2), __kScreenWidth__, __kNewSize(1));
    //    [self.webProgressLayer startLoad];
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if ([self.delegate respondsToSelector:@selector(gswebViewDidStartLoad:url:Title:)]) {
        [self.delegate gswebViewDidStartLoad:self url:webView.request.URL.absoluteString Title:title];
    }
}

static NSString * const kJavaScriptContext = @"documentView.webView.mainFrame.javaScriptContext";
static NSString * const kDocumentTitle = @"document.title";

static NSString * const kWebKitCacheModelPreferenceKey = @"WebKitCacheModelPreferenceKey";
static NSString * const kWebKitDiskImageCacheEnabled = @"WebKitDiskImageCacheEnabled";
static NSString * const kWebKitOfflineWebApplicationCacheEnabled = @"WebKitOfflineWebApplicationCacheEnabled";

- (void)cleanWebCacheValues
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kWebKitCacheModelPreferenceKey];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kWebKitDiskImageCacheEnabled];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kWebKitOfflineWebApplicationCacheEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)generateTitle
{
    _title = [(UIWebView *)_webView stringByEvaluatingJavaScriptFromString:kDocumentTitle];
}

- (void)bindingCtxAndValue
{
    JSContext * JSCtx = [(UIWebView *)_webView valueForKeyPath:kJavaScriptContext];
    JSValue * JSVlu = [JSCtx globalObject];
    objc_setAssociatedObject(self, &kGSJSValueKey, JSVlu, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self,&kGSJSContextKey, JSCtx, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [self generateTitle];
    [self bindingCtxAndValue];
    [self cleanWebCacheValues];
    
    if([self.script respondsToSelector:@selector(gswebViewRegisterObjCMethodNameForJavaScriptInteraction)]){
        __weak typeof(self) weakSelf = self;
        [[self.script gswebViewRegisterObjCMethodNameForJavaScriptInteraction] enumerateObjectsUsingBlock:
         ^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
             __strong typeof(weakSelf) strongSelf = weakSelf;
             strongSelf.jsContext[name] = ^(id body){
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [strongSelf excuteJavaScriptWithMethodName:name parameter:body];
                 });
             };
         }];
    }
    
    NSString * userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//    GSLog(@"userAgent\n %@",userAgent);
//    if (![userAgent containsString:[HistoryData ua]] ) {
//        [MaqueTool newUserAgent:[HistoryData ua]];
//
//    }
    if (webView.canGoBack) {
        _pan.isHideLeft = YES;
    }else{
        _pan.isHideLeft = NO;
    }
    if (webView.canGoForward) {
        _pan.isHideRight = YES;
    }else{
        _pan.isHideRight = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(gswebViewDidFinishLoad:url:Title:)]) {
        [self.delegate gswebViewDidFinishLoad:self url:webView.request.URL.absoluteString Title:_title];
    }
    //    [_webProgressLayer finishedLoadWithError:nil];
    //    [_webProgressLayer closeTimer];
    //    [self deallocProgress];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if ([self.delegate respondsToSelector:@selector(gswebView:url:Title:didFailLoadWithError:)]) {
        [self.delegate gswebView:self url:webView.request.URL.absoluteString Title:title didFailLoadWithError:error];
    }
    //    [_webProgressLayer finishedLoadWithError:nil];
    //    [_webProgressLayer closeTimer];
    //    [self deallocProgress];
}

- (double)estimatedProgress
{
    return ((WKWebView *)_webView).estimatedProgress;
}

/************************************************************************************************************************/
/**
 处理WKContentView的crash
 [WKContentView isSecureTextEntry]: unrecognized selector sent to instance 0x101bd5000
 */
+ (void)progressWKContentViewCrash {
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)) {
        const char *className = @"WKContentView".UTF8String;
        Class WKContentViewClass = objc_getClass(className);
        SEL isSecureTextEntry = NSSelectorFromString(@"isSecureTextEntry");
        SEL secureTextEntry = NSSelectorFromString(@"secureTextEntry");
        BOOL addIsSecureTextEntry = class_addMethod(WKContentViewClass, isSecureTextEntry, (IMP)isSecureTextEntryIMP, "B@:");
        BOOL addSecureTextEntry = class_addMethod(WKContentViewClass, secureTextEntry, (IMP)secureTextEntryIMP, "B@:");
        if (!addIsSecureTextEntry || !addSecureTextEntry) {
            NSLog(@"WKContentView-Crash->修复失败");
        }
    }
}

/**
 实现WKContentView对象isSecureTextEntry方法
 @return NO
 */
BOOL isSecureTextEntryIMP(id sender, SEL cmd) {
    return NO;
}

/**
 实现WKContentView对象secureTextEntry方法
 @return NO
 */
BOOL secureTextEntryIMP(id sender, SEL cmd) {
    return NO;
}

#pragma mark - WKWebView

- (void)removeCache
{
    
    if ([[[UIDevice currentDevice]systemVersion]intValue ] > 8) {
        
        NSArray * types =@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache]; // 9.0之后才有的
        
        NSSet *websiteDataTypes = [NSSet setWithArray:types];
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
        }];
        
    }else{
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        
        
        
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        
        NSLog(@"%@", cookiesFolderPath);
        
        NSError *errors;
        
        [[NSFileManager defaultManager]removeItemAtPath:cookiesFolderPath error:&errors];
        
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIViewController * currentVC = [self getTopViewController];
    if (currentVC) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.pageAlertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completionHandler();
        }]];
        [currentVC presentViewController:alert animated:YES completion:NULL];
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIViewController * currentVC = [self getTopViewController];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.pageConfirmTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [currentVC presentViewController:alert animated:YES completion:NULL];
    
}
//异常网址 跳转
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    
    return nil;
}
// 在发送请求之前，决定是否跳转

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    __kWeakSelf__;
    
    if ([self.delegate respondsToSelector:@selector(gswebView:shouldStartLoadWithRequest:navigationType:)]) {
        
        switch (navigationAction.navigationType) {
            case WKNavigationTypeLinkActivated: {
                [self setCallphone:navigationAction Complete:^{
                    _isNavigator = YES;
                    _isNavigator = [weakSelf.delegate gswebView:weakSelf shouldStartLoadWithRequest:navigationAction.request navigationType:(GSWebViewNavigationType)(navigationAction.navigationType < 0? navigationAction.navigationType : 5)];
                } failed:^{
                    _isNavigator = NO;
                }];
                break;
            }
            case WKNavigationTypeFormSubmitted: {
                [self setCallphone:navigationAction Complete:^{
                    _isNavigator = YES;
                    _isNavigator = [weakSelf.delegate gswebView:weakSelf shouldStartLoadWithRequest:navigationAction.request navigationType:(GSWebViewNavigationType)(navigationAction.navigationType < 0? navigationAction.navigationType : 5)];
                } failed:^{
                    _isNavigator = NO;
                }];
                break;
            }
            case WKNavigationTypeBackForward: {
                
                if ([weakSelf.delegate respondsToSelector:@selector(gsWKNavigationTypeBackForward)]) {
                    [weakSelf.delegate gsWKNavigationTypeBackForward];
                }
                _isNavigator = YES;
                break;
                //            }
            }
            case WKNavigationTypeReload: {
                _isNavigator = YES;
                break;
            }
            case WKNavigationTypeFormResubmitted: {
                _isNavigator = YES;
                break;
            }
            case WKNavigationTypeOther: {
                [self setCallphone:navigationAction Complete:^{
                    _isNavigator = YES;
                    _isNavigator = [weakSelf.delegate gswebView:weakSelf shouldStartLoadWithRequest:navigationAction.request navigationType:(GSWebViewNavigationType)(navigationAction.navigationType < 0? navigationAction.navigationType : 5)];
                } failed:^{
                    _isNavigator = NO;
                }];
                break;
            }
            default: {
                break;
            }
        }
        
        
    }
    if (!_isNavigator) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
#pragma mark - 是否返回或者前进

//-(BOOL)setReturnWkWeb:(WKWebView *)webView{
//
//    if ([[NewModel newModel].goIsBack isEqualToString:@"1"])
//    {
//        if ([webView.backForwardList.backItem.title isEqualToString:@""] || webView.backForwardList.backItem.title == nil)
//        {
//            //            webView.canGoBack = NO;
//            return NO;
//        }else{
//            return YES;
//        }
//
//    }
//    else if ([[NewModel newModel].goIsBack isEqualToString:@"0"])
//    {
//        if ([webView.backForwardList.forwardItem.title isEqualToString:@""] || webView.backForwardList.forwardItem.title == nil) {
//            //            webView.canGoForward = NO;
//            return NO;
//        }else{
//            return YES;
//        }
//
//    }
//
//
//    return NO;
//}

#pragma mark - 添加功能

-(void)setCallphone:(WKNavigationAction *)navigationAction Complete:(void (^)())complete failed:(void (^)())failed{
//    GSLog(@"push with request %@",navigationAction.request);
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
//    UIApplication *app = [UIApplication sharedApplication];
    if ([scheme isEqualToString:@"thunder"]) {
        
//        [KSAlertView showWithTitle:@"监测到迅雷种子" message1:URL.absoluteString cancelButton:@"取消" customButton:@"复制" commitAction:^(UIButton *button) {
//            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//            pasteboard.string = URL.absoluteString;
//
//        }];
       
         failed();
        return ;
    }
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        // 这种拨打电话的写法，真机可显示效果，模拟器不显示
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        [self newOpenURL:[NSURL URLWithString:callPhone]];
        complete();
        return ;
    }
    
    // 打开appstore
    if ([URL.absoluteString containsString:@"itunes.apple.com"]) {
        
        if ([DEFAULTS integerForKey:__DEF_KEY_OPENAPP] == 0) {
            //            [self.delegate gswebView:self shouldStartLoadWithRequest:request navigationType:(GSWebViewNavigationType)navigationType];
            complete();
            return ;
        }
        else  if ([DEFAULTS integerForKey:__DEF_KEY_OPENAPP] == 1)
        {
            //            [self.delegate gswebView:self shouldStartLoadWithRequest:request navigationType:(GSWebViewNavigationType)navigationType];
            complete();
            if([STCModel stcModel].isAlert == 0){
                return ;
            }else{
                    [self newOpenURL:URL];
                return;
            }
        }
        else if ([DEFAULTS integerForKey:__DEF_KEY_OPENAPP] == 2)
        {
            [self newOpenURL:URL];
            return;
        }
        
        complete();
        return ;
    }
    
//    if([MaqueTool newisHttpOrHttps:URL.absoluteString] == NO){
//        failed();
//        return;
//    }
    if ([URL.absoluteString isEqualToString:@"about:blank"]) {
        failed();
        return;
    }
    
    complete();
}
-(NSString *)newUrl:(NSString *)url
{
    NSString * str ;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
        str = [NSString stringWithFormat:@"App-Prefs:root=%@",url];
    }else{
        str = [NSString stringWithFormat:@"prefs:root=%@",url];
    }
    return str;
}

-(void)newOpenURL:(NSURL *)url
{
    if( [[UIApplication sharedApplication] canOpenURL:url] ) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
//    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
//    [self.bridge setWebViewDelegate:self];
//    [self bridgeCallHandler:@"getPasstheValueIDFA" data:[IphoneType IDFA]];
//    [self.bridge setWebViewDelegate:nil];


       if ([self.delegate respondsToSelector:@selector(gswebViewDidStartLoad:url:Title:)]) {
        [self.delegate gswebViewDidStartLoad:self url:webView.URL.absoluteString Title:webView.title];
    }
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}


// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
//    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
//    [self.bridge setWebViewDelegate:self];
//    if (!_bridge) {
//        self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
//        [self.bridge setWebViewDelegate:self];
//        [self bridgeCallHandler:@"getPasstheValueIDFA" data:[IphoneType IDFA]];
//
//    }
//

    _title = webView.title;
    if (self.delegate && [self.script respondsToSelector:@selector(gswebViewRegisterObjCMethodNameForJavaScriptInteraction)]) {
        __weak typeof(self) weakSelf = self;
        [[self.script gswebViewRegisterObjCMethodNameForJavaScriptInteraction] enumerateObjectsUsingBlock:
         ^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
             __strong typeof(weakSelf) strongSelf = weakSelf;
             [webView.configuration.userContentController removeScriptMessageHandlerForName:name];
             [webView.configuration.userContentController addScriptMessageHandler:strongSelf name:name];
         }];
    }
    if ([self.delegate respondsToSelector:@selector(gswebViewDidFinishLoad:url:Title:)]){
        [self.delegate gswebViewDidFinishLoad:self url:webView.URL.absoluteString Title:webView.title];
    }
    //    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    //    [_webProgressLayer finishedLoadWithError:nil];
    //    [_webProgressLayer closeTimer];
    //    [self deallocProgress];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
//    if ([self.delegate respondsToSelector:@selector(gswebView:url:Title:didFailLoadWithError:)]) {
//        [self.delegate gswebView:self url:webView.URL.absoluteString Title:webView.title didFailLoadWithError:error];
//    }
    
    //    [_webProgressLayer finishedLoadWithError:error];
    //    [_webProgressLayer closeTimer];
    //    [self deallocProgress];
}
// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    //    NSLog(@"页面加载超时");
    if ([self.delegate respondsToSelector:@selector(gswebView:url:Title:didFailLoadWithError:)]) {
        [self.delegate gswebView:self url:webView.URL.absoluteString Title:webView.title didFailLoadWithError:error];
    }
    
}
//进程被终止时调用

-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
//    GSLog(@"WKWebView 进程被终止时调用");
}
//关闭webView时调用的方法
-(void)webViewDidClose:(WKWebView *)webView{
//    GSLog(@"WKWebView 关闭webView时调用的方法");

}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self excuteJavaScriptWithMethodName:message.name parameter:message.body];
}

#pragma mark -
 
- (void)configureWKWebViewWithFrame:(CGRect)frame
{
   
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    WKUserContentController* userContentController =[[WKUserContentController alloc]init];
   
    configuration.userContentController = userContentController;
//    [configuration.userContentController addScriptMessageHandler:self name:@"getPasstheValueIDFA"];
    configuration.allowsInlineMediaPlayback = YES;
    //        self.allowsAirPlayForMediaPlayback = YES;
//    configuration.preferences.minimumFontSize = 10;
    WKProcessPool * process = [[WKProcessPool alloc]init];
    configuration.processPool = process;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    configuration.selectionGranularity = WKSelectionGranularityCharacter;
//    //真机无声音解决方案
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    BOOL ok;
//    NSError *setCategoryError = nil;
//    ok = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
//    if (!ok) {
//        NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);
//    }
    
    
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 9.0)
    {
        configuration.mediaPlaybackRequiresUserAction = NO;
        configuration.requiresUserActionForMediaPlayback = NO;
//        configuration.applicationNameForUserAgent = [IphoneType defaultUserAgentString];
    }else{
        
      
    }

    WKWebView * web = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    web.UIDelegate = self;
    web.navigationDelegate = self;
    web.allowsBackForwardNavigationGestures = YES;
    _scrollView = web.scrollView;
    _webView = web;

    [self addSubview:_webView];
    
//    [web evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
//        NSString *oldAgent = result;
////        GSLog(@"userAgent  %@",oldAgent);
//        if([oldAgent rangeOfString:@"MaqueBrowser"].location == NSNotFound){
//
//            [MaqueTool newUserAgent:[HistoryData ua]];
//        }
//    }];
    
}
//-(void)bridgeCallHandler:(NSString *)callHandler data:(NSString *)data
//{
//    [self.bridge callHandler:callHandler data:data responseCallback:^(id responseData) {
//        GSLog(@"调用完JS后的回调：%@",responseData);
//    }];
////        [self.bridge registerHandler:callHandler handler:^(id data, WVJBResponseCallback responseCallback) {
////            // 获取位置信息
////    
////            NSString *location = data;
////            // 将结果返回给js
////            responseCallback(location);
////        }];
//    
//}

- (void)configureUIWebViewWithFrame:(CGRect)frame
{
    UIWebView * web = [[UIWebView alloc] initWithFrame:frame];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    [NSClassFromString(@"WebCache") performSelector:@selector(setDisabled:) withObject:[NSNumber numberWithBool:YES] afterDelay:0];
#pragma clang diagnostic pop
    web.delegate = self;
    _scrollView = web.scrollView;
    _webView = web;
    [self addSubview:_webView];
    //真机无声音解决方案
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL ok;
    NSError *setCategoryError = nil;
    ok = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (!ok) {
        NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);
    }
    
    [self addSubview:web];
}

- (UIViewController *)getTopViewController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * win in windows) {
            if (win.windowLevel == UIWindowLevelNormal) {
                window = win;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] firstObject];
    id nextResponder = [frontView nextResponder];
    UIViewController * top = nil;
    if ([nextResponder isKindOfClass:[UIViewController class]])
        top = nextResponder;
    else
        top = window.rootViewController;
    return top;
}
//-(void)deallocProgress{
//    [_webProgressLayer removeFromSuperlayer];
//    _webProgressLayer = nil;
//}
@end

#pragma mark - Navigation

@implementation GSWebView (Navigation)

#pragma  mark - 添加左划右划手势
-(void)swipePoint:(CGPoint)point pan:(UIPanGestureRecognizer *)pan{
    //    NSLog(@"point:%f",point.x);
//    if ([self.delegate respondsToSelector:@selector(gsPoint:pan:)]) {
//        [self.delegate gsPoint:point pan:pan];
//    }
}
-(void)swipeRight{
    [self GSGoForward];
}

-(void)swipeLeft{
    
    [self GSGoBack];
}
-(void)GSGoBack{
    //    NSLog(@"后退");
    if (self.canGoBack) {
        [self goBack];
    }
}
-(void)GSGoForward{
    // NSLog(@"前进");
    if (self.canGoForward) {
        [self goForward];
    }
}
-(void)GSStopLoaging{
    [self stopLoading];
    //    [_webProgressLayer finishedLoadWithError:nil];
    //    [self deallocProgress];
}
-(void)GSRelod{
    //    NSLog(@"刷新");
    //    [_webProgressLayer finishedLoadWithError:nil];
    //    [self deallocProgress];
    [self reload];
    //    [self.webProgressLayer startLoad];
    
}


- (BOOL)isLoading
{
    if ([_webView isKindOfClass:[UIWebView class]])
        return [((UIWebView *)_webView) isLoading];
    return [((WKWebView *)_webView) isLoading];
}

- (BOOL)canGoBack
{
    if ([_webView isKindOfClass:[UIWebView class]])
        return [((UIWebView *)_webView) canGoBack];
    return [((WKWebView *)_webView) canGoBack];
}

- (BOOL)canGoForward
{
    if ([_webView isKindOfClass:[UIWebView class]])
        return [((UIWebView *)_webView) canGoForward];
    return [((WKWebView *)_webView) canGoForward];
}


#define ExcuteMethodWith(name) \
[self excuteFuncWithName:name]

- (void)reload
{
    ExcuteMethodWith(@"reload");
    
}

- (void)stopLoading
{
    ExcuteMethodWith(@"stopLoading");
    
}

- (void)goBack
{
    ExcuteMethodWith(@"goBack");
}

- (void)goForward
{
    ExcuteMethodWith(@"goForward");
}

@end

#pragma mark - GSPrivateMethod

@implementation GSWebView (GSPrivateMethod)

typedef void (*GSFunctionPointWithParam)(id, SEL, id);
typedef void (*GSFunctionPointNoParam)(id, SEL);

- (void)excuteJavaScriptWithMethodName:(NSString *)name parameter:(id)param
{
    if (self.performer) {
        SEL selector;
        if ([param isKindOfClass:[NSString class]] && [param isEqualToString:@""])
            selector = NSSelectorFromString(name);
        else
            selector = NSSelectorFromString([name stringByAppendingString:@":"]);
        
        if ([self.performer respondsToSelector:selector]){
            IMP imp = [self.performer methodForSelector:selector];
            if (param){
                GSFunctionPointWithParam f = (void *)imp;
                f(self.performer, selector,param);
            }
            else{
                GSFunctionPointNoParam f = (void *)imp;
                f(self.performer, selector);
            }
        }
    }
}

- (void)excuteFuncWithName:(NSString *)name
{
    SEL selector = NSSelectorFromString(name);
    if ([_webView respondsToSelector:selector]) {
        dispatch_block_t block = ^(void){
            IMP imp = [_webView methodForSelector:selector];
            GSFunctionPointNoParam pfunc = (void *)imp;
            pfunc(_webView, selector);
        };
        if ([[NSThread currentThread] isMainThread]) {
            block();
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    }
}

@end
