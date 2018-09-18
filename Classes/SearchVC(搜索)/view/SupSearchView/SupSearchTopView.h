//
//  supSearchTopView.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/26.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MySupSearchTopDelegate <NSObject>

- (void)mySupSearchTopClicked;

@end
@interface SupSearchTopView : UICollectionReusableView

@property(nonatomic, assign) id<MySupSearchTopDelegate>delegate;

@end
