//
//  MyAlertView.m
//  NBSDK
//
//  Created by nieyun on 5/26/16.
//  Copyright © 2016 com.alibaba. All rights reserved.
//

#import "MyAlertView.h"

@interface MyAlertView()
@property (nonatomic, strong) void (^btnClickCallback)(NSInteger index);
@end

@implementation MyAlertView

+ (MyAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                       oALinClicked:(void(^)(NSInteger btnIndex))oALinClicked
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    MyAlertView *ret = nil;
    if(otherButtonTitles) {
        ret = [[MyAlertView alloc] initWithTitle:title
                                         message:message
                                        delegate:self
                               cancelButtonTitle:cancelButtonTitle
                               otherButtonTitles:otherButtonTitles, nil];
        
        va_list vl;
        va_start(vl, otherButtonTitles);
        NSString *arg = va_arg(vl, NSString*);
        while(arg) {
            arg = va_arg(vl, NSString*);
            [ret addButtonWithTitle:arg];
        }
        va_end(vl);
    } else {
        ret = [[MyAlertView alloc] initWithTitle:title
                                         message:message
                                        delegate:self
                               cancelButtonTitle:cancelButtonTitle
                               otherButtonTitles:nil];
    }
    
    ret.btnClickCallback = oALinClicked;
    ret.delegate = ret;
    return ret;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(self.btnClickCallback) {
        self.btnClickCallback(buttonIndex);
        self.btnClickCallback = nil;
    }
}

@end
