//
//  GoodsSetVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/16.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "GoodsSetVC.h"
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
#import "GoodsToolsView.h"
/* foot */

// Vendors
#import <MJExtension.h>
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "MyAlertView.h"
#import <AlibabaAuthSDK/albbsdk.h>
// Categories

// Others


@interface GoodsSetVC ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DetailVCDelegate,MyGoodsToolsDelegate>

{
    NSInteger _indexPage;
}
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 工具栏 */
@property (strong , nonatomic)GoodsToolsView *goodsToolsView;
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
static NSString *const GSGoodsToolsViewID = @"GoodsToolsView";

@implementation GoodsSetVC

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        if (_isCouponOrUatm == YES) {
            _collectionView.frame = CGRectMake(0, __kNewSize(80), __kScreenWidth__, __kScreenHeight__ - __TabBarH__-__kNewSize(80));
            [self.myView addSubview:self.goodsToolsView];
//        }else{
//            _collectionView.frame = CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__ - __TabBarH__);

//        }
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        
        
        /* cell */
    
        [_collectionView registerClass:[GSGoodsYouLikeCell class] forCellWithReuseIdentifier:GSGoodsYouLikeCellID];
        
        /* head */
//        [_collectionView registerClass:[GoodsToolsView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GSGoodsToolsViewID];
        
        /* foot */
  
        [self.myView addSubview:_collectionView];
        
    }
    return _collectionView;
}

-(GoodsToolsView *)goodsToolsView{
    if (!_goodsToolsView) {
        _goodsToolsView = [[GoodsToolsView alloc]init];
        _goodsToolsView.frame = CGRectMake(0, 0, __kScreenWidth__, __kNewSize(80));
        _goodsToolsView.delegate = self;
        [self bottomLayerButton:_goodsToolsView];
    }
    return _goodsToolsView;
}
-(void)bottomLayerButton:(UIView *)view{
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0, view.bounds.size.height-__kNewSize(1), view.bounds.size.width, __kNewSize(1));
    leftBorder.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
    [view.layer addSublayer:leftBorder];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    // 添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clipbosrdSearchPop:) name:CLIPBOARDREQUESTPOPSearch object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clipbosrdGoodsPop:) name:CLIPBOARDREQUESTPOPGoods object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLIPBOARDREQUESTPOPSearch object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLIPBOARDREQUESTPOPGoods object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self newConfig];
    [self lodingStar];
    [self setUpBase];
    [self setUpNav];
    [self setUpGIFRrfresh];
    [self setUpScrollToTopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newConfig{
    
}
-(void)lodingStar{
    [EasyLodingView showLodingText:@"正在加载..." config:^EasyLodingConfig *{
        return [EasyLodingConfig shared].setLodingType(LodingShowTypeIndicator).setBgColor([UIColor colorWithHexString:@"#000000"] ).setTintColor([UIColor colorWithHexString:@"#ffffff"]).setBgAlpha(0.7);
    }];
}
- (void)setUpBase
{
    
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    self.baseNavigationBar.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.searchImpl = [[searchProtocolLmpl alloc]init];
    self.dataArr = [[NSMutableArray alloc]init];
}

#pragma mark - 导航栏
- (void)setUpNav
{
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"输入淘宝/天猫 商品标题或关键词" forState:0];
    [_searchButton setTitleColor:[UIColor colorWithHexString:@"#777777"] forState:0];
//    _searchButton.backgroundColor = [[UIColor colorWithHexString:@"#ffffff"]colorWithAlphaComponent:0.85];
    _searchButton.titleLabel.font = PFR13Font;
    [_searchButton setImage:[UIImage imageNamed:@"discount_search_icon"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * 6, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    _searchButton.frame = CGRectMake((__kScreenWidth__ -  __kNewSize(440))/2, 28, __kNewSize(440), __kNewSize(56));

    _searchButton.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    _searchButton.layer.cornerRadius = __kNewSize(56/2);
    //将多余的部分切掉
    _searchButton.layer.masksToBounds = YES;
//    [_topSearchView addSubview:_searchButton];
    [self.baseNavigationBar addSubview:_searchButton];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.baseNavigationBar).offset(__kNewSize(108));
        make.right.mas_equalTo(self.baseNavigationBar).offset(__kNewSize(-26));
//        make.centerX.mas_equalTo(self.baseNavigationBar);
        make.centerY.mas_equalTo(self.baseNavigationBar).offset(__kNewSize(18));
        make.size.mas_equalTo(CGSizeMake(__kScreenWidth__- __kNewSize(134), __kNewSize(62)));
    }];
    
}

#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"first_icon_top_return"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    [_backTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.myView).insets(UIEdgeInsetsMake(0, __kScreenWidth__ - __kNewSize(120), 0, __kNewSize(20)));
        make.centerY.mas_equalTo(self.myView.mas_centerY).offset(__kScreenWidth__/2+__kNewSize(100));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(100)));
    }];
 

}

- (void)setUpGIFRrfresh
{
    __kWeakSelf__;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer resetNoMoreData];
            [weakSelf newRequest:self.searchStr];
     
    }];
    //
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _indexPage ++;
        if (_isCouponOrUatm == YES) {

            [self requestSearch:self.searchStr];

        }else{
             [weakSelf requestUatmFavoritesItemGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"favorites_id":self.favoritesId,@"page_no":[NSString stringWithFormat:@"%ld",(long)_indexPage]}];

        }
        [_collectionView.mj_footer endRefreshing];
    }];
    [_collectionView.mj_header beginRefreshing];
    
}

-(void)newRequest:(NSString *)title{
    if (_dataArr.count != 0) {
        [_dataArr removeAllObjects];
    }
    _indexPage = 1;
    if (_isCouponOrUatm == YES) {
       
        [self requestSearch:title];
    }else{
         [self requestUatmFavoritesItemGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"favorites_id":self.favoritesId,@"page_no":[NSString stringWithFormat:@"%ld",(long)_indexPage]}];
    }
   
    [self ScrollToTop];
}
#pragma mark - 刷新请求
-(void)requestSearch:(NSString *)title{
    NSString * strIsOn = [EntireManageMent readConfigDataWithConfigKey:__Config_SearchChannelKey__];
    if ([strIsOn isEqualToString:@"1"]) {
        [self requestSearchItmeGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"q":title,@"sort":@"tk_rate",@"page_no":[NSString stringWithFormat:@"%ld",(long)_indexPage]}];
    }else{
        [self requestDgItemCouponGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"q":title,@"page_no":[NSString stringWithFormat:@"%ld",(long)_indexPage]}];
    }
    
}
-(void)addModel:(id)model{
    TBKCouponModel * iModel = (TBKCouponModel *)model;
//        if (_isCouponOrUatm == YES)
//        {
            if ([[EntireManageMent readConfigDataWithConfigKey:__Config_NO_CouponKey__] isEqualToString:@"YES"]) {
                if (iModel.CouponClickUrl != nil) {
                    [self.dataArr addObject:iModel];
                }
            }else{
                [self.dataArr addObject:iModel];
            }
//        }else{
//            if (iModel.CouponClickUrl != nil) {
//                [self.dataArr addObject:iModel];
//            }
//        }
  
}

-(void)requestDgItemCouponGet:(NSDictionary *)dic{
    
    __kWeakSelf__;
    [self.searchImpl r_Search_DgItemCouponGet:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
        for (NSDictionary * dict in model.Datas) {
            TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
//            GSLog(@"\n name: %@ \n 优惠券: %@ \n 现价: %@",iModel.Title,iModel.CouponInfo,iModel.ZkFinalPrice);
                [weakSelf addModel:iModel];
           
        }
        [weakSelf.collectionView reloadData];
        [EasyLodingView hidenLoding];

    } failed:^(RequestFailedError error) {
        if (error == RequestFailedNoDataType) {
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [EasyLodingView hidenLoding];

    }];
    
    
    
    //         [self m_newData];
}

-(void)requestUatmFavoritesItemGet:(NSDictionary *)dic{
    __kWeakSelf__;
    [self.searchImpl r_Search_UatmFavoritesItemGet:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
//        GSLog(@"%@",model);
        for (NSDictionary * dict in model.Datas) {
            TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
            [weakSelf addModel:iModel];
        }
        [weakSelf.collectionView reloadData];
        [EasyLodingView hidenLoding];

    } failed:^(RequestFailedError error) {
        if (error == RequestFailedNoDataType) {
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [EasyLodingView hidenLoding];

    }];
}
//商品搜索
-(void)requestSearchItmeGet:(NSDictionary *)dic{
    __kWeakSelf__;
    [self.searchImpl r_Search_ItmeGet:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
        GSLog(@"%@",model);
        for (NSDictionary * dict in model.Datas) {
            TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
            [weakSelf addModel:iModel];
        }
        [weakSelf.collectionView reloadData];
        [EasyLodingView hidenLoding];
    } failed:^(RequestFailedError error) {
        if (error == RequestFailedNoDataType) {
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [EasyLodingView hidenLoding];

    }];
}


#pragma mark - <UICollectionViewDataSource>
//- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}

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


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//  GoodsToolsView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GSGoodsToolsViewID forIndexPath:indexPath];
//    headerView.delegate = self;
//    return headerView;
//}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
        return CGSizeMake((__kScreenWidth__-12)/2, __kNewSize(558));

}


#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

//    if (section == 0) {
//        return CGSizeMake(__kScreenWidth__, __kNewSize(80)); //宽高
//    }
//    if(section == 1){
        return CGSizeZero;  //Top头条的宽高
//    }

//    return CGSizeMake(__kScreenWidth__, __kNewSize(80)); //宽高
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    
    return CGSizeZero;
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

        [self alerClick:indexPath.row];
    
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > __kScreenHeight__) ? NO : YES;//判断回到顶部按钮是否隐藏
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
#pragma mark - Delegate

-(void)myDetailVCpop:(NSDictionary *)dict{
    GSGridItem * itme = [[GSGridItem alloc]initWithDictionary:dict error:nil];
    self.searchStr = itme.Title;
    [self newRequest:self.searchStr];
}
-(void)myGoodsToolsClicked:(GoodsToolsType)type{
    switch (type) {
        case CouponYESType:
        {

        }
            break;
        case CouponNOType:
        {

        }
            break;
        case SearchCouponType:
        {
            
        }
            break;
        case SearchSuperType:
        {
            
        }
            break;
        default:
            break;
    }
    
    [self newRequest:self.searchStr];

}

#pragma mark - 通知处理
- (void)clipbosrdSearchPop:(NSNotification *)notification
{
    GSLog(@"通知中心");
    NSDictionary * dict = notification.userInfo;
    TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
//    GoodsSetVC * gSetVc = [[GoodsSetVC alloc]init];
//    gSetVc.searchStr = iModel.Title;
//    gSetVc.isCouponOrUatm = YES;
//    [[SSpeedy ss_getCurrentVC].navigationController pushViewController:gSetVc animated:YES];
    self.searchStr = iModel.Title;
    [self newRequest:self.searchStr];

}
- (void)clipbosrdGoodsPop:(NSNotification *)notification
{
    NSDictionary * dict = notification.userInfo;
    ItemModel * iModel = [[ItemModel alloc]initWithDictionary:dict error:nil];
    [ALBCPush pushALBCSDK:pushALBCTypeMyCoupon openType:ALBCOpenTypeNative data:iModel complete:^(UIViewController *vc) {
        DetailVC * dvc = (DetailVC *)vc;
        dvc.delegate = self;
        [[SSpeedy ss_getCurrentVC].navigationController pushViewController:vc animated:YES];
    }];
    GSLog(@"通知中心");
}
#pragma mark - 百川SDK
-(void)alerClick:(NSInteger)index{
    ItemModel *model;
    if (_dataArr.count != 0) {
        model = _dataArr[index];
    }
    GSLog(@"%@",model);
    [ALBCPush pushALBCSDK:pushALBCTypeMyCoupon openType:ALBCOpenTypeH5 data:model complete:^(UIViewController *vc) {
        DetailVC * dvc = (DetailVC *)vc;
        dvc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}


-(void)searchButtonClick{
    GSLog(@"搜索");
    _isCouponOrUatm = YES;

    HistorySearchVC *searShopVC = [HistorySearchVC new];
    
    __kWeakSelf__;
    @LLWeakObj(searShopVC);
    //(1)点击分类 (2)用户点击键盘"搜索"按钮  (3)点击历史搜索记录
    [searShopVC beginSearch:^(NaviBarSearchType searchType,NBSSearchShopCategoryViewCellP *categorytagP,UILabel *historyTagLabel,LLSearchBar *searchBar) {
        @LLStrongObj(searShopVC);

        if(historyTagLabel.text != nil)
        {
            weakSelf.searchStr = historyTagLabel.text;
        }
        if(searchBar.text != nil)
        {
            weakSelf.searchStr = searchBar.text;
        }
        if(categorytagP.categotyTitle != nil)
        {
            weakSelf.searchStr = categorytagP.categotyTitle;
        }
        if(categorytagP.categotyID != nil)
        {
            weakSelf.searchStr = categorytagP.categotyID;
        }

        
        NSLog(@"historyTagLabel:%@--->searchBar:%@--->categotyTitle:%@--->%@",historyTagLabel.text,searchBar.text,categorytagP.categotyTitle,categorytagP.categotyID);
        
        searShopVC.searchBarText = weakSelf.searchStr;
        [weakSelf newRequest:weakSelf.searchStr];

    }];
    
    
    //执行即时搜索匹配
    NSArray *tempArray = @[@"女装",@"男装",@"手机",@"电脑",@"键盘"];
    
    
    [searShopVC searchbarDidChange:^(NaviBarSearchType searchType, LLSearchBar *searchBar, NSString *searchText) {
        @LLStrongObj(searShopVC);
        
        //FIXME:这里模拟网络请求数据!!!
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            searShopVC.resultListArray = tempArray;
        });
    }];
    
    [searShopVC resultListViewDidSelectedIndex:^(UITableView *tableView, NSInteger index) {
        weakSelf.searchStr = tempArray[index];
        [weakSelf newRequest:weakSelf.searchStr];
    }];
    
    [self.navigationController presentViewController:searShopVC animated:nil completion:nil];
}


@end
