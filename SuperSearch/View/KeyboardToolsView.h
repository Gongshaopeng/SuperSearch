//
//  KeyboardToolsView.h
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/10/18.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyKeyboardToolsViewClickedDelegate <NSObject>

- (void)myKeyboardToolsViewBtnClicked:(NSInteger)index;

@end
@interface KeyboardToolsView : UIView
@property(nonatomic,weak) id<MyKeyboardToolsViewClickedDelegate> delegate;
@property(nonatomic,strong) UIView * keyboardTools;//!<工具View
@property(nonatomic,strong) NSString * imageName;//!<
@property(nonatomic,strong) UIView * xianBottom;//!<工具View


-(instancetype)initWithFrame:(CGRect)frame ItmeArr:(NSArray *)itmeArr lableTextColor:(UIColor *)color;
-(void)p_layoutFrame;
-(void)show:(CGRect)frame ;
- (void)dismiss:(CGRect)frame;
-(void)setToolBackgroundColor:(UIColor *)backgroundColor;
-(void)createKeyboardToolsButton:(NSArray *)itmeArr LableColor:(UIColor *)color;

@end
