//
//  ShoppingCarVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/7.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "HighdiscountVC.h"
#import "PageGoodsVC.h"

#import "searchProtocolLmpl.h"

#import "UatmFavoritesModel.h"

#import "ALBCPush.h"

@interface HighdiscountVC ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate,PageGoodsDelegate>

@property (nonatomic,strong)id<searchProtocol>searchImpl;
@property (nonatomic,strong) NSMutableArray * titleArr;
@property (nonatomic,strong)NSMutableArray *viewControllers;
@property (nonatomic,strong)NSMutableArray *tagTitles;
@property (nonatomic,assign)BOOL fullfillTabs;  /** Fullfilltabs when tabs width less than view width */

@end
@implementation HighdiscountVC
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
//    self.baseNavigationBar.titleLabel.text = @"高额优惠";
//     self.myView.backgroundColor = [UIColor greenColor];
    [self h_Init];
   
    [self h_Request];
}

-(void)h_Init{
    self.searchImpl = [[searchProtocolLmpl alloc]init];
    self.titleArr = [[NSMutableArray alloc]init];
    self.tagTitles = [[NSMutableArray alloc]init];
    self.viewControllers = [[NSMutableArray alloc]init];

    self.dataSource = self;
    self.delegate = self;
    self.fixTabWidth = false;
    self.padding = 10;
    self.leadingPadding = 10;
    self.trailingPadding = 10;
    self.defaultDisplayPageIndex = 0;
    self.tabAnimationType = GLTabAnimationType_whileScrolling;
    self.indicatorColor = [UIColor colorWithRed:255.0/255.0 green:205.0 / 255.0 blue:0.0 alpha:1.0];
    self.supportArabic = NO;
    self.fullfillTabs = NO;
    self.fixIndicatorWidth = YES;
    self.indicatorWidth = 20;
}
-(void)h_UI{
    
}
-(void)h_Request{
    [self requestUatmFavoritesGet:@{}];
}

-(void)cellIndexPathPageGoods:(ItemModel *)indexModle{
    __kWeakSelf__;
    [ALBCPush pushALBCSDK:pushALBCTypeMyCoupon openType:ALBCOpenTypeNative data:indexModle complete:^(UIViewController *vc) {
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}
-(void)initWithControllerArray
{
    for (NSInteger i = 0; i<self.titleArr.count; i++)
    {
        PageGoodsVC *mvc = [[PageGoodsVC alloc]init];
//        mvc.albumProtocol = [[JWContext sharedContext] albumProtocol];
        mvc.delegate      = self;
//        NSArray *pdId     = [DEFAULTS objectForKey:@"PDid"];
        mvc.favoritesOBJ        = _titleArr[i];
//        mvc.typeIndex     = [NSString stringWithFormat:@"%ld",i];
        [_viewControllers addObject:mvc];
    }
}
-(void)requestUatmFavoritesGet:(NSDictionary *)dic{
    [self.searchImpl r_Search_UatmFavoritesGet:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
        for (NSDictionary * dic in model.Datas) {
            UatmFavoritesModel * uaModel = [[UatmFavoritesModel alloc] initWithDictionary:dic error:nil];
            GSLog(@"FavoritesTitle:%@ \n FavoritesId: %@",uaModel.FavoritesTitle,uaModel.FavoritesId);
            [self.titleArr addObject:uaModel];
            [self.tagTitles addObject:uaModel.FavoritesTitle];
//           
        }
        
        [self initWithControllerArray];
        [self h_UI];
    } failed:^(RequestFailedError error) {
        
    }];
}
-(void)requestUatmFavoritesItemGet:(NSDictionary *)dic{
    [self.searchImpl r_Search_UatmFavoritesItemGet:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
        GSLog(@"%@",model);
        
    } failed:^(RequestFailedError error) {
        
    }];
}
#pragma mark - GLViewPagerViewControllerDataSource
- (NSUInteger)numberOfTabsForViewPager:(GLViewPagerViewController *)viewPager {
    return self.viewControllers.count;
}



- (UIView *)viewPager:(GLViewPagerViewController *)viewPager
      viewForTabIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc]init];
    label.text = [self.tagTitles objectAtIndex:index];
    label.font = [UIFont systemFontOfSize:16.0];
    /** 默认紫色 */
    label.textColor =[UIColor colorWithRed:0.5
                                     green:0.0
                                      blue:0.5
                                     alpha:1.0];
    
    label.textAlignment = NSTextAlignmentCenter;
#if 0
    label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
#endif
    return label;
}

- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
contentViewControllerForTabAtIndex:(NSUInteger)index {
    return self.viewControllers[index];
}
#pragma mark - GLViewPagerViewControllerDelegate
- (void)viewPager:(GLViewPagerViewController *)viewPager didChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex {
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
#if 0
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
#endif
    /* 紫色默认颜色 */
    prevLabel.textColor = [UIColor colorWithRed:0.5
                                          green:0.0
                                           blue:0.5
                                          alpha:1.0];
    
    /* 灰色高亮颜色 */
    currentLabel.textColor =   [UIColor colorWithRed:0.3
                                               green:0.3
                                                blue:0.3
                                               alpha:1.0];
}

- (void)viewPager:(GLViewPagerViewController *)viewPager willChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex withTransitionProgress:(CGFloat)progress {
    
    if (fromTabIndex == index) {
        return;
    }
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    
#if 0
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                 1.0 - (0.1 * progress),
                                                 1.0 - (0.1 * progress));
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                    0.9 + (0.1 * progress),
                                                    0.9 + (0.1 * progress));
    
#endif
    
    currentLabel.textColor =[UIColor colorWithRed:0.5 - 0.2 * progress
                                            green:0.0 + 0.3 * progress
                                             blue:0.5 - 0.2 * progress
                                            alpha:1.0];
    
    prevLabel.textColor =[UIColor colorWithRed:0.3 + 0.2 * progress
                                         green:0.3 - 0.3 * progress
                                          blue:0.3 + 0.2 * progress
                                         alpha:1.0];
    
    
}


- (CGFloat)viewPager:(GLViewPagerViewController *)viewPager widthForTabIndex:(NSUInteger)index {
    static UILabel *prototypeLabel ;
    if (!prototypeLabel) {
        prototypeLabel = [[UILabel alloc]init];
    }
    prototypeLabel.text = [self.tagTitles objectAtIndex:index];
    prototypeLabel.textAlignment = NSTextAlignmentCenter;
    prototypeLabel.font = [UIFont systemFontOfSize:16.0];
#if 0
    prototypeLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
#endif
    return prototypeLabel.intrinsicContentSize.width + (self.fullfillTabs == YES ?  [self tabsFulFillToScreenWidthInset] : 0);
}

#pragma mark - funcs

- (CGFloat)tabsFulFillToScreenWidthInset {
    if ([self isTabsWidthGreaterThanScreenWidth]) {
        return 0.0;
    }
    
    return [self screenleftWidthForTabs] / self.tagTitles.count;
}

- (CGFloat)estimateTabsWidthInView {
    static UILabel *prototypeLabel ;
    if (!prototypeLabel) {
        prototypeLabel = [[UILabel alloc]init];
    }
    prototypeLabel.textAlignment = NSTextAlignmentCenter;
    prototypeLabel.font = [UIFont systemFontOfSize:16.0];
    
    CGFloat estimateTabsWidth = 0.0;
    estimateTabsWidth += self.leadingPadding;
    
    for (NSUInteger i = 0; i < self.tagTitles.count; i++) {
        prototypeLabel.text = [self.tagTitles objectAtIndex:i];
        estimateTabsWidth += prototypeLabel.intrinsicContentSize.width;
        if (i == self.tagTitles.count - 1) {
            estimateTabsWidth += 0;
        }
        else {
            estimateTabsWidth += self.padding;
        }
    }
    estimateTabsWidth+=self.trailingPadding;
    return estimateTabsWidth;
}

- (CGFloat)screenleftWidthForTabs {
    CGFloat tabsWidth = [self estimateTabsWidthInView];
    return self.view.bounds.size.width - tabsWidth;
}

- (BOOL)isTabsWidthGreaterThanScreenWidth {
    return [self screenleftWidthForTabs] < 0 ? true : false;
}



//- (NSUInteger)numberOfTabsForViewPager:(GLViewPagerViewController *)viewPager {
//    <#code#>
//}
//
//- (UIView *)viewPager:(GLViewPagerViewController *)viewPager viewForTabIndex:(NSUInteger)index {
//    <#code#>
//}
//
//- (void)viewPager:(GLViewPagerViewController *)viewPager didChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex {
//    <#code#>
//}
//
//- (CGFloat)viewPager:(GLViewPagerViewController *)viewPager widthForTabIndex:(NSUInteger)index {
//    <#code#>
//}
//
//- (void)viewPager:(GLViewPagerViewController *)viewPager willChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex withTransitionProgress:(CGFloat)progress {
//    <#code#>
//}
//
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end
