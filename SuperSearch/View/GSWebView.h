
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

#import <UIKit/UIKit.h>
#import "PanLoad.h"
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The type of action triggering a navigation.
 */
typedef NS_ENUM(NSInteger,GSWebViewNavigationType) {
    /**
     *  A link with an href attribute was activated by the user.
     */
    GSWebViewNavigationTypeLinkClicked,
    /**
     *  A form was submitted.
     */
    GSWebViewNavigationTypeFormSubmitted,
    /**
     *  An item from the back-forward list was requested.
     */
    GSWebViewNavigationTypeBackForward,
    /**
     *  The webpage was reloaded.
     */
    GSWebViewNavigationTypeReload,
    /**
     *  A form was resubmitted (for example by going back, going forward, or reloading).
     */
    GSWebViewNavigationTypeFormResubmitted,
    /**
     *  Navigation is taking place for some other reason.
     */
    GSWebViewNavigationTypeOther
};

/**
 *  GSDataDetectorTypes
 */
typedef NS_OPTIONS(NSUInteger,GSDataDetectorTypes) {
    /**
     *  Disable detection.
     */
    GSDataDetectorTypeNone                  = 0,
    /**
     *  Phone number detection.
     */
    GSDataDetectorTypePhoneNumber           = 1 << 0,
    /**
     *  URL detection.
     */
    GSDataDetectorTypeLink                  = 1 << 1,
    /**
     *  Street address detection.
     */
    GSDataDetectorTypeAddress               = 1 << 2,
    /**
     *  Event detection.
     */
    GSDataDetectorTypeCalendarEvent         = 1 << 3,
    /**
     *  Shipment tracking number detection.
     */
    GSDataDetectorTypeTrackingNumber        = 1 << 4,
    /**
     *  Flight number detection.
     */
    GSDataDetectorTypeFlightNumber          = 1 << 5,
    /**
     *  Information users may want to look up.
     */
    GSDataDetectorTypeLookupSuggestion      = 1 << 6,
    /**
     *  Enable all types, including types that may be added later.
     */
    GSDataDetectorTypeAll = NSUIntegerMax
};

@protocol GSWebViewDelegate,GSWebViewJavaScript;

#pragma mark - GSWebView

NS_CLASS_AVAILABLE(10_10, 7_0)
@interface GSWebView : UIView

/**
 *  The web view's user interface delegate
 */
@property (nonatomic, weak) id<GSWebViewDelegate> delegate;

/**
 *  The web view's javascript interactive delegate.
 */
@property (nonatomic, weak) id<GSWebViewJavaScript> script;
//**
//@property WKWebViewJavascriptBridge* bridge;

- (instancetype)new __IOS_PROHIBITED;
- (instancetype)init __IOS_PROHIBITED;
- (void)gsDealloc;
- (void)wkgsDealloc;
/**
 *  Specifies the constructor
 *
 *  @param performer Used for function pointers to callback
 */
- (instancetype)initWithFrame:(CGRect)frame JSPerformer:(nonnull id)performer;

/**
 *  Navigates to a requested URL.
 *
 *  @param request request The request specifying the URL to which to navigate.
 */
- (void)loadRequest:(NSURLRequest *)request;

// Load a NSURL to web view
// Can be called any time after initialization
- (void)loadURL:(NSURL *)URL;

// Loads a URL as NSString to web view
// Can be called any time after initialization
- (void)loadURLString:(NSString *)URLString;


// Loads an string containing HTML to web view
// Can be called any time after initialization
- (void)loadHTMLString:(NSString *)HTMLString;

/**
 *  Sets the webpage contents and base URL.
 *
 *  @param string   The string to use as the contents of the webpage.
 *  @param baseURL  A URL that is used to resolve relative URLs within the document.
 */
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;

//清除缓存
- (void)removeCache;

/**
 *  进度条.
 */
//@property (nonatomic, strong) YJWebProgressLayer *webProgressLayer;  //  进度条
@property (nonatomic, strong) GSWebView * webView;  //

/**
 *  手势动画.
 */
@property (nonatomic,strong) PanLoad * pan;//!<滑动返回

//@property (nonatomic,strong) UIProgressView * progressView;

/**
 *  The page URLRequest.
 */
@property (nullable, nonatomic, readonly, strong) NSURLRequest *request;

/**
 *  The page title.
 */
@property (nullable, nonatomic, readonly, copy) NSString * title;

/**
 *  Customize the alert box title
 */
@property (nullable, nonatomic, copy) NSString * pageAlertTitle;
//当拦截到JS中的alter方法，自定义弹出框的标题

/**
 *  Customize the confirm box title
 */
@property (nullable, nonatomic, copy) NSString * pageConfirmTitle;
//当拦截到JS中的confirm方法，自定义弹出框的标题

/**
 *  An estimate of what fraction of the current navigation has been completed.
 *  This value ranges from 0.0 to 1.0 based on the total number of
 *  bytes expected to be received, including the main document and all of its
 *  potential subresources. After a navigation completes, the value remains at 1.0
 *  until a new navigation starts, at which point it is reset to 0.0.
 */
@property (nonatomic, readonly) double estimatedProgress NS_AVAILABLE_IOS(8_0); //8.0才支持获取进度,8.0之下版本可以根据回调模拟虚假进度

/**
 *  The scroll view associated with the web view.
 */
@property (nonatomic, readonly, strong) UIScrollView *scrollView;

/**
 *  An enum value indicating the type of data detection desired.
 *  The default value is WKDataDetectorTypeNone.
 
 ***********************************  SORRY  ***********************************
 
 *  Sorry, I try to solve WKWebView internal dataDetector problem,             *
 *  however, WKWebView only in iOS10 above support dataDetectorTypes.          *
 *  I try to find the implementation of dataDetectorTypes from Apple's         *
 *  open source code, but the new features of WKWebView IOS10 are not          *
 *  open source.                                                               *
 *  If you find a better way, please tell me, thank you for understanding.     *
 
 ***********************************  SORRY  ***********************************
 */
@property (nonatomic) GSDataDetectorTypes dataDetectorTypes;

/**
 *  The server must intercept this method, or a non-crashing error will occur
 *
 *  @param javaScriptString  javaScript method
 *  @param completionHandler callback
 */
- (void)excuteJavaScript:(NSString *)javaScriptString completionHandler:(void(^)(id params, NSError * error))completionHandler;
/**
 处理WKContentView的crash
 [WKContentView isSecureTextEntry]: unrecognized selector sent to instance 0x101bd5000
 */
+ (void)progressWKContentViewCrash;
@end

#pragma mark - Navigation

@interface GSWebView (Navigation)
/**
 *  A Boolean value indicating whether there is a back item in
 *  the back-forward list that can be navigated to.
 */
@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;

/**
 *  A Boolean value indicating whether there is a forward item in
 *  the back-forward list that can be navigated to.
 */
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;

/**
 *  A Boolean value indicating whether the view is currently
 *  loading content.
 */
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

/**
 *  Reloads the current page.
 */
- (void)reload;

/**
 *  Stops loading all resources on the current page.
 */
- (void)stopLoading;

/**
 *  Navigates to the back item in the back-forward list.
 */
- (void)goBack;

/**
 *  Navigates to the forward item in the back-forward list.
 */
- (void)goForward;


@end

#pragma mark - Protocol:GSWebViewDelegate GSWebViewJavaScript

/********************************************************************************
 *  user interface protocol
 */
@protocol GSWebViewDelegate <NSObject>
@optional

- (BOOL)gswebView:(GSWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(GSWebViewNavigationType)navigationType;
- (void)gswebViewDidStartLoad:(GSWebView *)webView url:(NSString *)url Title:(NSString *)title;
- (void)gswebViewDidFinishLoad:(GSWebView *)webView url:(NSString *)url Title:(NSString *)title;
- (void)gswebView:(GSWebView *)webView url:(NSString *)url Title:(NSString *)title didFailLoadWithError:(NSError *)error;
- (void)gsPoint:(CGPoint)point pan:(UIPanGestureRecognizer *)pan;
- (void)gsWKNavigationTypeBackForward;

@end

/********************************************************************************
 *  JavaScriptn interactive protocol
 */
@protocol GSWebViewJavaScript <NSObject>
@optional

/**
 call objc method
 
 - (NSArray<NSString *>*)gswebViewRegisterObjCMethodNameForJavaScriptInteraction
 {
 return @[@"getCurrentUserId"];
 }
 
 - (void)getCurrentUserId:(NSString *)Id
 {
 NSLog(@"JS调用到OC%@",Id);
 }
 */
- (NSArray<NSString *>*)gswebViewRegisterObjCMethodNameForJavaScriptInteraction;

@end

NS_ASSUME_NONNULL_END
