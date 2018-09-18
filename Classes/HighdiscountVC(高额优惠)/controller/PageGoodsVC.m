//
//  PageGoodsVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/21.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "PageGoodsVC.h"
#import "searchProtocolLmpl.h"

// Controllers
#import "DetailVC.h"
#import "HistorySearchVC.h"
// Models
#import "GSGridItem.h"

// Views

/* cell */
#import "GSGoodsYouLikeCell.h"
/* head */

/* foot */

@interface PageGoodsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    NSInteger _indexPage;
}
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<GSGridItem *> *gridItem;

@property (nonatomic,strong)id<searchProtocol>searchImpl;

@property (nonatomic,strong) NSMutableArray * dataArr;

@end

static NSString *const GSGoodsYouLikeCellID = @"GSGoodsYouLikeCell";

@implementation PageGoodsVC

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, __kScreenWidth__,__kContentHeight__);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        
        
        /* cell */
        
        [_collectionView registerClass:[GSGoodsYouLikeCell class] forCellWithReuseIdentifier:GSGoodsYouLikeCellID];
        
        /* head */
        
        
        /* foot */
        
        [self.myView addSubview:_collectionView];
        
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self myViewFrameIsNavi:NO];
    [self setUpBase];
    [self setUpNav];
    [self setUpGIFRrfresh];
    [self setUpScrollToTopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpBase
{
    _indexPage = 1;
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    self.baseNavigationBar.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    self.searchImpl = [[searchProtocolLmpl alloc]init];
    self.dataArr = [[NSMutableArray alloc]init];
}

#pragma mark - 导航栏
- (void)setUpNav
{
//    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_searchButton setTitle:@"搜索商品/店铺" forState:0];
//    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
//    _searchButton.titleLabel.font = PFR13Font;
//    [_searchButton setImage:[UIImage imageNamed:@"search"] forState:0];
//    [_searchButton adjustsImageWhenHighlighted];
//    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * 10, 0, 0);
//    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    _searchButton.frame = CGRectMake((__kScreenWidth__ -  __kNewSize(440))/2, 28, __kNewSize(440), __kNewSize(56));
//    _searchButton.backgroundColor = [UIColor whiteColor];
//    _searchButton.layer.cornerRadius = __kNewSize(56/2);
//    //将多余的部分切掉
//    _searchButton.layer.masksToBounds = YES;
//    //    [_topSearchView addSubview:_searchButton];
//    [self.baseNavigationBar addSubview:_searchButton];
    
}

#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myView addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"first_icon_top_return"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    [_backTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.myView).insets(UIEdgeInsetsMake(0, __kScreenWidth__ - __kNewSize(100), 0, __kNewSize(20)));
        make.centerY.mas_equalTo(self.myView.mas_centerY).offset(__kScreenWidth__/2+__kNewSize(50));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(80), __kNewSize(80)));
    }];
//        _backTopButton.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:0.6];
    //    [_backTopButton setTitle:@"顶部" forState:UIControlStateNormal];
    //    [_backTopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)setUpGIFRrfresh
{
    __kWeakSelf__;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_dataArr.count != 0) {
            [_dataArr removeAllObjects];
        }
        _indexPage = 1;
  [weakSelf requestUatmFavoritesItemGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"favorites_id":self.favoritesOBJ.FavoritesId,@"page_no":[NSString stringWithFormat:@"%ld",(long)_indexPage]}];
        [_collectionView.mj_header endRefreshing];

    }];
    //
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _indexPage ++;
        
        [weakSelf requestUatmFavoritesItemGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"favorites_id":self.favoritesOBJ.FavoritesId,@"page_no":[NSString stringWithFormat:@"%ld",(long)_indexPage]}];
        
        
        //        }
        [_collectionView.mj_footer endRefreshing];
    }];
    [_collectionView.mj_header beginRefreshing];
    
}
-(void)requestUatmFavoritesItemGet:(NSDictionary *)dic{
    [self.searchImpl r_Search_UatmFavoritesItemGet:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
        GSLog(@"%@",model);
        for (NSDictionary * dict in model.Datas) {
            TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
            GSLog(@"\n name: %@ \n 优惠券: %@ \n 现价: %@",iModel.Title,iModel.CouponInfo,iModel.ZkFinalPrice);
            if (iModel.CouponClickUrl != nil) {
                [self.dataArr addObject:iModel];
            }
        }
        [self.collectionView reloadData];
    } failed:^(RequestFailedError error) {
        
    }];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    
    GSGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GSGoodsYouLikeCellID forIndexPath:indexPath];
    if (self.dataArr.count != 0) {
        cell.youLikeItem = self.dataArr[indexPath.row];
    }
    cell.backgroundColor = [UIColor whiteColor];
    //        cell.layer.borderWidth = __kNewSize(1);
    //        cell.layer.borderColor = [UIColor blackColor].CGColor;
    gridcell = cell;
    
    
    return gridcell;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((__kScreenWidth__-12)/2, __kNewSize(516));
    
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
//定义每个UICollectionView 的边距
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake ( 4 , 4 , 4 , 4 );
    
}
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(cellIndexPathPageGoods:)])
    {
        ItemModel *model;
        if (_dataArr.count != 0) {
            model = _dataArr[indexPath.row];
        }
        [self.delegate cellIndexPathPageGoods:model];
        }
//    [self alerClick:indexPath.row];
    
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > __kContentHeight__) ? NO : YES;//判断回到顶部按钮是否隐藏
    //    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    //    if (scrollView.contentOffset.y > 44) {
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    //    }else{
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    //    }
}
#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
#pragma mark - 百川SDK
-(void)alerClick:(NSInteger)index{
    ItemModel *model;
    if (_dataArr.count != 0) {
        model = _dataArr[index];
    }
    GSLog(@"%@",model);
    __kWeakSelf__;
    [ALBCPush pushALBCSDK:pushALBCTypeMyCoupon openType:ALBCOpenTypeNative data:model complete:^(UIViewController *vc) {
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
}

@end
