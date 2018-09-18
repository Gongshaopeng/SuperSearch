//
//  MyAlertView.h
//  NBSDK
//
//  Created by nieyun on 5/26/16.
//  Copyright © 2016 com.alibaba. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MyAlertView : UIAlertView<UIAlertViewDelegate>

+ (MyAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                       oALinClicked:(void(^)(NSInteger btnIndex))oALinClicked
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end

