//
//  PanLoad.h
//  PanGestureTEST
//
//  Created by 巩小鹏 on 16/9/18.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SwipeType)
{
    SwipeLeftType = 0,
    
    SwipeRightType,
};
@protocol SlideLeftOrRightDelegate <NSObject>

@optional
-(void)swipeLeft;
-(void)swipeRight;
-(void)swipePoint:(CGPoint)point pan:(UIPanGestureRecognizer*)pan;
-(BOOL)swipeIsClass;

@end

@interface PanLoad : UIView <UIGestureRecognizerDelegate>
@property (nonatomic,weak) id<SlideLeftOrRightDelegate> slideDelegate;
@property (nonatomic, assign) SwipeType swipeType;
@property (nonatomic,strong)UIPanGestureRecognizer * pan;
@property (nonatomic,strong) UIView * leftView;
@property (nonatomic,strong) UIView * rightView;
@property (nonatomic,strong) UIImageView * leftImageView;
@property (nonatomic,strong) UIImageView * rightImageView;
@property (nonatomic,assign) BOOL isHideLeft;
@property (nonatomic,assign) BOOL isHideRight;

-(void)setPanGestureRecognizer:(UIView *)view;
-(void)setHideLeftOrRightIs:(BOOL)isHide;
-(void)removeGestureRecognizer:(UIView *)view;

@end
