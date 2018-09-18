//
//  PopularSearchesCell.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/26.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMTagListView.h"
@protocol MySupSearchCellDelegate <NSObject>

- (void)mySupSearchSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content;

@end
@interface PopularSearchesCell : UICollectionViewCell <KMTagListViewDelegate>
/*标签*/
@property (strong ,nonatomic)KMTagListView *tagList;
@property(nonatomic, assign) id<MySupSearchCellDelegate>delegate;
@property (strong ,nonatomic)NSArray *listHot;


@end
