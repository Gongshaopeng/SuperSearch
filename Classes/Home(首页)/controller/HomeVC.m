//
//  HomeVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/7.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "HomeVC.h"

#import "tbkProtocolImpl.h"
#import "searchProtocolLmpl.h"

// Controllers
#import "DetailVC.h"
#import "GoodsSetVC.h"
#import "HistorySearchVC.h"

// Models
#import "GSGridItem.h"
#import "GSFeatured.h"
// Views
#import "GSCollectionViewFlowLayout.h"

#import "GSHomeTopToolView.h"
#import "GSHomeRefreshGifHeader.h"
/* cell */
#import "GSGoodsGridCell.h"
#import "GSFeaturedCell.h"
#import "GSGoodsYouLikeCell.h"
/* head */
#import "GSSlideshowHeadView.h"
#import "GSYouLikeHeadView.h"
/* foot */

// Vendors
#import <MJExtension.h>

// Categories

// Others
#import "ALBCPush.h"

@interface HomeVC ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,MyGSSlideshowHeadViewDelegate,MyGSGoodsGridDelegate,MyGSFeaturedDelegate,DetailVCDelegate>
{
    NSInteger _indexPage;
    NSArray * featuredArr;
    NSInteger _itmeCount;//按钮的个数
    NSString *_favoritesId;//选品库ID

}
@property (nonatomic, strong) dispatch_semaphore_t        topscrollSema;   //!<top部广告型号量
@property (nonatomic, strong) dispatch_semaphore_t        gridItemlSema;    //!<top导航型号量
@property (nonatomic, strong) dispatch_semaphore_t        featuredSema;    //!<精选专题数据型号量
@property (nonatomic, strong) dispatch_semaphore_t        setLibrarySema;    //!<底部推荐选品库数据型号量
@property (nonatomic, strong) dispatch_semaphore_t        setDataSema;    //!<底部推荐详情数据型号量

//请求代理
@property (nonatomic,strong)id<searchProtocol>searchImpl;

@property (nonatomic,strong)id<tbkProtocol>tbkProtocolImpl;


/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
//top滚动视图数据
@property (strong , nonatomic)NSMutableArray *goodsHomeSilderArray;//头部滚动视图数据
@property (strong , nonatomic)NSMutableArray *goodsHomeSilderImagesArray;//头部滚动图片
/* 精选专题 */
@property (strong , nonatomic)NSMutableArray<GSGridItem *> *featured;
@property (strong , nonatomic)NSMutableArray *featuredImage;
/* top导航 */
@property (strong , nonatomic)NSMutableArray<GSGridItem *> *gridItem;
//底部推荐数据
@property (nonatomic,strong) NSMutableArray * dataArr;

/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 搜索 */
@property (strong , nonatomic) GSHomeTopToolView * homeTopToolView;

@end

/* cell */
static NSString *const GSGoodsGridCellID = @"GSGoodsGridCell";
static NSString *const GSFeaturedCellID = @"GSFeaturedCell";
static NSString *const GSGoodsYouLikeCellID = @"GSGoodsYouLikeCell";

/* head */
static NSString *const GSSlideshowHeadViewID = @"GSSlideshowHeadView";
static NSString *const GSYouLikeHeadViewID = @"GSYouLikeHeadView";

/* foot */

@implementation HomeVC

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        GSCollectionViewFlowLayout *layout = [GSCollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, __kScreenWidth__, __kBarHeight__);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
    
        
        /* cell */
        [_collectionView registerClass:[GSGoodsGridCell class] forCellWithReuseIdentifier:GSGoodsGridCellID];
        [_collectionView registerClass:[GSFeaturedCell class] forCellWithReuseIdentifier:GSFeaturedCellID];
        [_collectionView registerClass:[GSGoodsYouLikeCell class] forCellWithReuseIdentifier:GSGoodsYouLikeCellID];

        /* head */
        [_collectionView registerClass:[GSSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GSSlideshowHeadViewID];

      
        /* foot */
           [_collectionView registerClass:[GSYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GSYouLikeHeadViewID];
        
        [self.myView addSubview:_collectionView];

    }
    return _collectionView;
}
-(GSHomeTopToolView *)homeTopToolView{
    if (!_homeTopToolView) {
        _homeTopToolView = [[GSHomeTopToolView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kNavigationBarHeight__)];
        [_homeTopToolView.searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _homeTopToolView;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = [DEFAULTS integerForKey:__DEF_KEY_statusBarStyle];
    // 添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clipbosrdSearchPop:) name:CLIPBOARDREQUESTPOPSearch object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clipbosrdGoodsPop:) name:CLIPBOARDREQUESTPOPGoods object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLIPBOARDREQUESTPOPSearch object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLIPBOARDREQUESTPOPGoods object:nil];

}
-(void)viewDidLoad{
    [super viewDidLoad];
//    self.baseNavigationBar.titleLabel.text = @"麻雀优惠券";
//    [self hideNavigationBar:NO];

    [self setUpBase];
    
    [self setUpNav];
//
//    [self setUpGoodsData];
    [self setUpGIFRrfresh];
    
    [self setUpScrollToTopView];
    
    [self getNetwork];
    
//    [self requestEditConfi];
    [self requestWirelessShareTpwdQuery];
}

-(void)setUpGoodsData{
    
    
    __kWeakSelf__;
    _topscrollSema      = dispatch_semaphore_create(0);
    _gridItemlSema      = dispatch_semaphore_create(0);
    _featuredSema       = dispatch_semaphore_create(0);
    _setLibrarySema     = dispatch_semaphore_create(0);
    _setDataSema        = dispatch_semaphore_create(0);

    //    //创建一个组
    dispatch_group_t group = dispatch_group_create();
    
    //获取全局并行队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // topScroll
    dispatch_group_async(group, globalQueue, ^{

        [weakSelf requestEditConfi];
       
        dispatch_semaphore_wait(weakSelf.topscrollSema, DISPATCH_TIME_FOREVER);
        
    });
    
    dispatch_group_async(group, globalQueue, ^{

        [weakSelf requestUatmFavorites:@{@"cate":@"1"}];
        dispatch_semaphore_wait(weakSelf.gridItemlSema, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, globalQueue, ^{
            
            [weakSelf requestUatmFavorites:@{@"cate":@"2"}];
            dispatch_semaphore_wait(weakSelf.featuredSema, DISPATCH_TIME_FOREVER);
            dispatch_group_async(group, globalQueue, ^{
                
                [weakSelf requestUatmFavorites:@{@"cate":@"3"}];
                dispatch_semaphore_wait(weakSelf.setLibrarySema, DISPATCH_TIME_FOREVER);
                dispatch_group_async(group, globalQueue, ^{
                    
                    if (_dataArr.count != 0) {
                        [_dataArr removeAllObjects];
                    }
                    _indexPage = 1;
                    [weakSelf requestUatmFavoritesItemGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"favorites_id":_favoritesId,@"page_no":[NSString stringWithFormat:@"%ld",(long)_indexPage]}];
                    dispatch_semaphore_wait(weakSelf.setDataSema, DISPATCH_TIME_FOREVER);
                    
                });
            });
        });
    });
   
   
    
    dispatch_group_notify(group, globalQueue, ^{
        //在线程组里面的所有线程执行完成之后调用的代码
        
        //回到主线程刷新进度条
        dispatch_async(dispatch_get_main_queue(), ^{
//            [_collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil]];
            [weakSelf.collectionView reloadData];
            GSLog(@"回到主线程刷新进度条");
        });
    });

//
//    if(_gridItem.count <= 4){
//        _itmeCount = 4;
//    }else{
//        _itmeCount= _gridItem.count;
//    }
//    [self requestDgItemCouponGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"q":@"女装",@"page_no":@"1"}];

}
#pragma mark - 数据请求

-(void)requestWirelessShareTpwdQuery{
    
//    [self.searchImpl r_Search_WirelessShareTpwdQuery:[RequestModel modelWithDictionary:@{@"password_conten":@"【新款汽车盲区行车记录仪双镜头高清夜视360度全景倒车影像一体机】，复制这条信息￥xCMZ0FFleIB￥后打开👉手淘👈"} appType:@"1"] complete:^(ResponseModel *model) {
//        GSLog(@"%@",model);
//    } failed:^(RequestFailedError error) {
//
//    }];
//    
}
-(void)requestEditConfi{
    __kWeakSelf__;
    [self.searchImpl r_Search_EditConfig:[RequestModel modelWithDictionary:@{@"cate":@"1"}] complete:^(ResponseModel *model) {
        GSLog(@"requestEditConfi %@",model);
        if (_goodsHomeSilderArray.count != 0) {
            [_goodsHomeSilderArray removeAllObjects];
        }
        if (_goodsHomeSilderImagesArray.count != 0) {
            [_goodsHomeSilderImagesArray removeAllObjects];
        }
        [EntireManageMent addCacheName:EditConfig_ONE jsonString:[STool arrTransformString:model.Datas] updataTime:nil];
        [weakSelf cacheDataEditConfig:model.Datas];
        dispatch_semaphore_signal(weakSelf.topscrollSema);

    } failed:^(RequestFailedError error) {
        
    }];
}

-(void)requestDgItemCouponGet:(NSDictionary *)dic{
    
    __kWeakSelf__;
    [self.searchImpl r_Search_DgItemCouponGet:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
        for (NSDictionary * dict in model.Datas) {
            TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
//            GSLog(@"\n name: %@ \n 优惠券: %@ \n 现价: %@",iModel.Title,iModel.CouponInfo,iModel.ZkFinalPrice);
            if (iModel.CouponClickUrl != nil) {
                [weakSelf.dataArr addObject:iModel];
            }
        }

//        [self.collectionView reloadData];
    } failed:^(RequestFailedError error) {
        
    }];

    
    
    //         [self m_newData];
}
//选品库
-(void)requestUatmFavoritesItemGet:(NSDictionary *)dic{
    __kWeakSelf__;
    [self.searchImpl r_Search_UatmFavoritesItemGet:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {
//        GSLog(@"%@",model);
        [EntireManageMent addCacheName:FavoritesItem jsonString:[STool arrTransformString:model.Datas] updataTime:nil];
        [weakSelf cacheDataTBKCouponModel:model.Datas];
        dispatch_semaphore_signal(weakSelf.setDataSema);
        [weakSelf.collectionView reloadData];
    } failed:^(RequestFailedError error) {
        if (error == RequestFailedNoDataType) {
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        dispatch_semaphore_signal(weakSelf.setDataSema);

    }];
}
-(void)requestUatmFavorites:(NSDictionary *)dic{
    __kWeakSelf__;
    [self.searchImpl r_Search_UatmFavorites:[RequestModel modelWithDictionary:dic] complete:^(ResponseModel *model) {


        static NSInteger indexType = 0;
//        GSLog(@"requestUatmFavorites_Category %@",[model.Datas[0] objectForKey:@"Category"]);
        
            switch ([[model.Datas[0] objectForKey:@"Category"] integerValue]) {
                case 1:
                    {
                        [EntireManageMent addCacheName:UatmFavorites_ONE jsonString:[STool arrTransformString:model.Datas] updataTime:nil];

                        indexType = 1;
                        if (_gridItem.count != 0) {
                            [_gridItem removeAllObjects];
                        }
                    }
                    break;
                case 2:
                {
                       [EntireManageMent addCacheName:UatmFavorites_TWO jsonString:[STool arrTransformString:model.Datas] updataTime:nil];
                     indexType = 2;
                    if (_featuredImage.count != 0) {
                        [_featuredImage removeAllObjects];
                    }
                    if (_featured.count != 0) {
                        [_featured removeAllObjects];
                    }
                }
                    break;
                case 3:
                {
                      [EntireManageMent addCacheName:UatmFavorites_THREE jsonString:[STool arrTransformString:model.Datas] updataTime:nil];
                    indexType = 3;
                }
                    break;
                default:
                    break;
            }
        
        [weakSelf cacheDataGSGridItem:model.Datas];
        
        switch (indexType) {
            case 1:
                {
                    _itmeCount= _gridItem.count;
                    dispatch_semaphore_signal(weakSelf.gridItemlSema);

                }
                break;
            case 2:
            {
//                 [_collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil]];
                dispatch_semaphore_signal(weakSelf.featuredSema);
            }
                break;
            case 3:
            {
                
//                 [weakSelf setUpGIFRrfresh];
                dispatch_semaphore_signal(weakSelf.setLibrarySema);
                
            }
                break;
                
            default:
                break;
        }
        
       
    } failed:^(RequestFailedError error) {
        
    }];
}

#pragma mark - 导航栏
- (void)setUpNav
{

    [self.myView addSubview:self.homeTopToolView];
//    self.baseNavigationBar.backgroundColor = [UIColor clearColor];
//    self.xian.hidden = YES;
}

#pragma mark - initialize
- (void)setUpBase
{

    self.tbkProtocolImpl = [[tbkProtocolImpl alloc] init];
    
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    self.searchImpl = [[searchProtocolLmpl alloc]init];
    self.dataArr = [[NSMutableArray alloc]init];
    self.gridItem = [[NSMutableArray alloc]init];
    self.featured = [[NSMutableArray alloc]init];
    self.featuredImage = [[NSMutableArray alloc]init];
    self.goodsHomeSilderArray = [[NSMutableArray alloc]init];
    self.goodsHomeSilderImagesArray = [[NSMutableArray alloc]init];

//    featuredArr = __FeaturedArr__;
    if ([EntireManageMent isExisedManager:EditConfig_ONE]) {
        [self cacheDataEditConfig:[STool strTransformArr:[EntireManageMent readCacheDataWithName:EditConfig_ONE]]];
        [self cacheDataGSGridItem:[STool strTransformArr:[EntireManageMent readCacheDataWithName:UatmFavorites_ONE]]];
        [self cacheDataGSGridItem:[STool strTransformArr:[EntireManageMent readCacheDataWithName:UatmFavorites_TWO]]];
        [self cacheDataGSGridItem:[STool strTransformArr:[EntireManageMent readCacheDataWithName:UatmFavorites_THREE]]];
        [self cacheDataTBKCouponModel:[STool strTransformArr:[EntireManageMent readCacheDataWithName:FavoritesItem]]];
        [_collectionView reloadData];
    }
   
}

#pragma mark - Cache
-(void)cacheDataEditConfig:(NSArray *)dataArr{
    for (NSDictionary * dict in dataArr) {
        GSFeatured * featModel = [[GSFeatured alloc] initWithDictionary:dict error:nil];
        [_goodsHomeSilderArray addObject:featModel];
        [_goodsHomeSilderImagesArray addObject:featModel.Image];
        [EntireManageMent onjson:dict fileName:@"Edit"];
    }
}
-(void)cacheDataTBKCouponModel:(NSArray *)dataArr{
    for (NSDictionary * dict in dataArr) {
        TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
//        GSLog(@"\n name: %@ \n 优惠券: %@ \n 现价: %@",iModel.Title,iModel.CouponInfo,iModel.ZkFinalPrice);
        if (iModel.CouponClickUrl != nil) {
            [self.dataArr addObject:iModel];
        }
        [EntireManageMent onjson:dict fileName:@"TBKCoupon"];

    }
}
-(void)cacheDataGSGridItem:(NSArray *)dataArr{
    for (NSDictionary * dict in dataArr) {
        GSGridItem * gridModel = [[GSGridItem alloc] initWithDictionary:dict error:nil];
//        GSLog(@"indexType \n%@",gridModel.Category);
        [EntireManageMent onjson:dict fileName:@"GSGridItem"];

        switch ([gridModel.Category integerValue]) {
            case 1:
            {
                [_gridItem addObject:gridModel];
            }
                break;
            case 2:
            {
                if (gridModel.Image) {
                    [_featuredImage addObject:gridModel.Image];
                }
                [_featured addObject:gridModel];
                
            }
                break;
            case 3:
            {
                _favoritesId = gridModel.FavoritesId;
                
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myView addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"first_icon_top_return"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
//    _backTopButton.frame = CGRectMake(__kScreenWidth__ - __kNewSize(100), __kScreenHeight__ - __kNewSize(220), __kNewSize(80), __kNewSize(80));
    [_backTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.myView).insets(UIEdgeInsetsMake(0, __kScreenWidth__ - __kNewSize(120), 0, __kNewSize(20)));
        make.centerY.mas_equalTo(self.myView.mas_centerY).offset(__kScreenWidth__/2+__kNewSize(120));
        make.size.mas_equalTo(CGSizeMake(__kNewSize(100), __kNewSize(100)));
    }];
    
    //    _backTopButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    //    [_backTopButton setTitle:@"顶部" forState:UIControlStateNormal];
    //    [_backTopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

#pragma mark - 获取网络
- (void)getNetwork
{
    if ([[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { //网络
        [EasyTextView showErrorText:@"您现在暂无可用网络"];

    }
}


#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    __kWeakSelf__;
//    self.collectionView.mj_header = [GSHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecHeaderData)];
//    self.collectionView.mj_footer = [GSHomeRefreshGifHeader footerWithRefreshingTarget:self refreshingAction:@selector(setUpRecFooterData)];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_collectionView.mj_footer resetNoMoreData];

            [self setUpGoodsData];

        [_collectionView.mj_header endRefreshing];
        
        
    }];
    //
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _indexPage ++;

        [weakSelf requestUatmFavoritesItemGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"favorites_id":_favoritesId?:@"",@"page_no":[NSString stringWithFormat:@"%ld",(long)_indexPage]}];

        [_collectionView.mj_footer endRefreshing];
    }];
    [_collectionView.mj_header beginRefreshing];

}

#pragma mark - 刷新
- (void)setUpRecData
{
//    __kWeakSelf__;
//    [SSpeedy ss_callFeedback]; //触动
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
//        [self requestDgItemCouponGet:@{@"adzone_id":__al_MM_Adzone_Id__,@"q":@"女装",@"page_no":@"1"}];
//
//        [weakSelf.collectionView.mj_header endRefreshing];
//    });
}

#pragma mark - 加载数据


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //属性
        return _gridItem.count?:4;
    }else if (section == 1) {
        return _featured.count?:4;
    }else if (section == 2) {
        return self.dataArr.count?:4;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//10
        GSGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GSGoodsGridCellID forIndexPath:indexPath];
        if (_gridItem.count != 0) {
            cell.gridItem = _gridItem[indexPath.row];
        }
//        [cell setBCreateButton:_gridItem];
//        cell.gridItemArr = _gridItem;
        cell.delegate = self;
//        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
        
    }else if(indexPath.section == 1){
        GSFeaturedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GSFeaturedCellID forIndexPath:indexPath];
//        cell.featArr = _featuredImage;
        if (_featured.count != 0) {
            cell.gridItem = _featured[indexPath.row];
        }
        cell.delegate = self;

        gridcell = cell;
    }else if (indexPath.section == 2){
        GSGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GSGoodsYouLikeCellID forIndexPath:indexPath];
        if (self.dataArr.count != 0) {
            cell.youLikeItem = self.dataArr[indexPath.row];
        }
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.layer.borderWidth = __kNewSize(1);
//        cell.layer.borderColor = [UIColor blackColor].CGColor;
        gridcell = cell;
    }
    gridcell.backgroundColor = [UIColor whiteColor];

    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            GSSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GSSlideshowHeadViewID forIndexPath:indexPath];
            headerView.imageGroupArray = _goodsHomeSilderImagesArray;
//            headerView.imageGroupArray = GoodsHomeSilderImagesArray;

            headerView.delegate = self;
            reusableview = headerView;
            
        }else if (indexPath.section == 1){
            GSYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GSYouLikeHeadViewID forIndexPath:indexPath];
            //            headerView.imageGroupArray = GoodsHomeSilderImagesArray;
//            headerView.backgroundColor = [UIColor redColor];
            reusableview = headerView;
        }
    }
    if (kind == UICollectionElementKindSectionFooter){
        if (indexPath.section == 0) {
            GSYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GSYouLikeHeadViewID forIndexPath:indexPath];
            headerView.likeImageView.image = [UIImage imageNamed:@"discount_title_1"];
            headerView.backgroundColor = [UIColor whiteColor];
            reusableview = headerView;
        }else if (indexPath.section == 1){
            GSYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GSYouLikeHeadViewID forIndexPath:indexPath];
            headerView.likeImageView.image = [UIImage imageNamed:@"discount_title_2"];
            headerView.backgroundColor = [UIColor whiteColor];
            reusableview = headerView;
        }
    }
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//9宫格组

        return CGSizeMake(__kScreenWidth__/4 , __kScreenWidth__/4 );

    }else if (indexPath.section == 1){
//        NSInteger  num = [STool returnCountFirstNumber:self.featuredImage.count andSecondNumber:2];
//        return CGSizeMake(__kScreenWidth__ , __kNewSize(160)*num);
        return CGSizeMake((__kScreenWidth__-1)/2 , __kNewSize(160) );

    }
    if (indexPath.section == 2) {//猜你喜欢
        return CGSizeMake((__kScreenWidth__-12)/2, __kNewSize(558));
    }
    return CGSizeZero;
}


#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(__kScreenWidth__, HomeTopScrollHeight); //图片滚动的宽高
    }
    if(section == 1){
        return CGSizeZero;  //Top头条的宽高
    }

    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(__kScreenWidth__, HomeFoot_Height);  //Top头条的宽高
    }
    if (section == 1) {
        return CGSizeMake(__kScreenWidth__, HomeFoot_Height); // 滚动广告
    }
  
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
 //定义每个UICollectionView 的边距
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {

    UIEdgeInsets inset = UIEdgeInsetsZero;
    switch (section) {
        case 0:
            inset = UIEdgeInsetsMake(0.0, 0, __kNewSize(12), 0.0);
            break;
        case 1:
            inset = UIEdgeInsetsMake(1, 0.0, __kNewSize(12), 0.0);
            break;
        case 2:
            inset = UIEdgeInsetsMake(4, 4, 4, 4);
            break;
        case 3:
            inset = UIEdgeInsetsMake(0, 0, 0, 0);
            break;
        default:
            break;
    }
        return inset;
}
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat X = 0.0;
    switch (section) {
        case 0:
            X = 0;
            break;
        case 1:
            X = 1;
            break;
        case 2:
            X = 4;
            break;
        default:
            break;
    }
    
    return  X;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat Y = 0.0;
    switch (section) {
        case 0:
            Y = 0.0;
            break;
        case 1:
            Y = 1;
            break;
        case 2:
            Y = 4;
            break;
        default:
            break;
    }
    return  Y;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (_gridItem.count != 0) {
            [self myGSGoodsGridClicked:indexPath.row];
        }
    }
    if (indexPath.section == 1) {
        if (_featured.count != 0) {
        [self myGSFeaturedClicked:indexPath.row];
        }
    }
    if (indexPath.section == 2) {
        [self alerClick:indexPath.row];
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > __kScreenHeight__) ? NO : YES;//判断回到顶部按钮是否隐藏
    self.homeTopToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > __kScreenHeight__) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//        self.baseNavigationBar.hidden = YES;
        [DEFAULTS setInteger:0 forKey:__DEF_KEY_statusBarStyle];
        self.xian.hidden = NO;
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        self.baseNavigationBar.hidden = NO;
        [DEFAULTS setInteger:1 forKey:__DEF_KEY_statusBarStyle];

        self.xian.hidden = YES;
        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - 通知处理
- (void)clipbosrdSearchPop:(NSNotification *)notification
{
    GSLog(@"通知中心");
    NSDictionary * dict = notification.userInfo;
        TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
        GoodsSetVC * gSetVc = [[GoodsSetVC alloc]init];
        gSetVc.searchStr = iModel.Title;
        gSetVc.isCouponOrUatm = YES;
        [[SSpeedy ss_getCurrentVC].navigationController pushViewController:gSetVc animated:YES];
}
- (void)clipbosrdGoodsPop:(NSNotification *)notification
{
    NSDictionary * dict = notification.userInfo;
    ItemModel * iModel = [[ItemModel alloc]initWithDictionary:dict error:nil];
    [ALBCPush pushALBCSDK:pushALBCTypeMyCoupon openType:ALBCOpenTypeNative data:iModel complete:^(UIViewController *vc) {
        DetailVC * dvc = (DetailVC *)vc;
        dvc.delegate = self;
        [[SSpeedy ss_getCurrentVC].navigationController pushViewController:dvc animated:YES];
    }];
    GSLog(@"通知中心");
}
#pragma mark - 百川SDK
-(void)alerClick:(NSInteger)index{
    
    if (_dataArr.count != 0) {
         ItemModel *model;
        model = _dataArr[index];
        [ALBCPush pushALBCSDK:pushALBCTypeMyCoupon openType:ALBCOpenTypeNative data:model complete:^(UIViewController *vc) {
            DetailVC * dvc = (DetailVC *)vc;
            dvc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        GSLog(@"%@",model);

    }
  
}
     
#pragma mark - Delegate
-(void)myDetailVCpop:(NSDictionary *)dict{
    GSGridItem * itme = [[GSGridItem alloc]initWithDictionary:dict error:nil];
//    GoodsSetVC * gSetVc = [[GoodsSetVC alloc]init];
//    gSetVc.searchStr = iModel.Title;
//    gSetVc.isCouponOrUatm = YES;
//    [[SSpeedy ss_getCurrentVC].navigationController pushViewController:gSetVc animated:NO];
    
    [self pushGoodsSet:itme.Title favoritesId:itme.FavoritesId isCouponOrUatm:YES];

}
-(void)myGSGoodsGridClicked:(NSInteger)index{
    if (_gridItem != 0) {
        
   
    GSGridItem * itme = _gridItem[index];
    GSLog(@"%@",itme.Title);
//    NSString * favoritesId;
//    switch (index) {
//        case 0:
//        {
//            favoritesId = @"16466111";
//        }
//            break;
//        case 1:
//        {
//            favoritesId = @"16465754";
//        }
//            break;
//        case 2:
//        {
//            favoritesId = @"16465835";
//        }
//            break;
//        case 3:
//        {
//            favoritesId = @"16466080";
//        }
//            break;
//        case 4:
//        {
//            favoritesId = @"";
//        }
//            break;
//        default:
//            break;
//    }
    [self pushGoodsSet:itme.Title favoritesId:itme.FavoritesId isCouponOrUatm:NO];
         }
}
-(void)myGSFeaturedClicked:(NSInteger)index{
//    NSArray * arr =__FeaturedArr__;
//    GSLog(@"%@",arr[index]);
//    NSString * favoritesId;
//    switch (index) {
//        case 0:
//            {
//                favoritesId = @"16466136";
//            }
//            break;
//        case 1:
//        {
//            favoritesId = @"16550043";
//        }
//            break;
//        case 2:
//        {
//            favoritesId = @"16465942";
//        }
//            break;
//        case 3:
//        {
//            favoritesId = @"16465992";
//        }
//            break;
//        case 4:
//        {
//            favoritesId = @"16466037";
//        }
//            break;
//        case 5:
//        {
//            favoritesId = @"16466049";
//        }
//            break;
//        case 6:
//        {
//            favoritesId = @"16466065";
//        }
//            break;
//        case 7:
//        {
//            favoritesId = @"16465970";
//        }
//            break;
//
//        default:
//            break;
//    }
    if (_featured != 0) {
        GSGridItem * itmeModel = _featured[index];
        [self pushGoodsSet:@"男装"favoritesId:itmeModel.FavoritesId isCouponOrUatm:NO];
    }
}
-(void)myGSSlideshowHeadViewClicked:(NSInteger)index{
    NSString * favoritesId;
    switch (index) {
        case 0:
        {
            favoritesId = @"";
        }
            break;
        case 1:
        {
            favoritesId = @"";
        }
            break;
        case 2:
        {
            favoritesId = @"";
        }
            break;
        case 3:
        {
            favoritesId = @"";
        }
            break;
        case 4:
        {
            favoritesId = @"";
        }
            break;
        default:
            break;
    }
    if (_goodsHomeSilderArray != 0) {
        GSFeatured * featModel  = _goodsHomeSilderArray[index];
        GSLog(@"滚动广告 ：%@",featModel.Title);
        [self pushGoodsSet:featModel.Title favoritesId:favoritesId isCouponOrUatm:YES];
    }
}

-(void)pushDetailVC{
//    DetailVC * view = [[DetailVC alloc]init];
//    view.shopTitle = model.Title;
//    view.openUrl = url;
//    view.num_iid = model.NumIid;
//    view.CouponInfo = model.CouponInfo;
//    view.ZkFinalPrice = model.ZkFinalPrice;
//    view.PictUrl = model.PictUrl;
    
//    [view requestloadWeb:url];
    
    
}

-(void)pushGoodsSet:(NSString *)title favoritesId:(NSString *)favoritesId isCouponOrUatm:(BOOL)isCouponOrUatm{
    
    GoodsSetVC * gSetVc = [[GoodsSetVC alloc]init];
    gSetVc.searchStr = title;
    gSetVc.favoritesId = favoritesId;
    gSetVc.isCouponOrUatm = isCouponOrUatm;
    [self.navigationController pushViewController:gSetVc animated:YES];
    
}

#pragma mark - 搜索

-(void)searchButtonClick{
    GSLog(@"搜索");
    static NSString * searchStr;

    HistorySearchVC *searShopVC = [HistorySearchVC new];
   
//    __kWeakSelf__;
    @LLWeakObj(searShopVC);
    //(1)点击分类 (2)用户点击键盘"搜索"按钮  (3)点击历史搜索记录
    [searShopVC beginSearch:^(NaviBarSearchType searchType,NBSSearchShopCategoryViewCellP *categorytagP,UILabel *historyTagLabel,LLSearchBar *searchBar) {
        @LLStrongObj(searShopVC);
        
        if(historyTagLabel.text != nil)
        {
            searchStr = historyTagLabel.text;
        }
        if(searchBar.text != nil)
        {
            searchStr = searchBar.text;
        }
        if(categorytagP.categotyTitle != nil)
        {
            searchStr = categorytagP.categotyTitle;
        }
        if(categorytagP.categotyID != nil)
        {
           searchStr = categorytagP.categotyID;
        }
        
        
//        NSLog(@"historyTagLabel:%@--->searchBar:%@--->categotyTitle:%@--->%@",historyTagLabel.text,searchBar.text,categorytagP.categotyTitle,categorytagP.categotyID);
        
        searShopVC.searchBarText = searchStr;
        [self pushGoodsSet:searchStr favoritesId:@"16466111"isCouponOrUatm:YES];

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
        searchStr = tempArray[index];
        [self pushGoodsSet:searchStr favoritesId:@"16466111"isCouponOrUatm:YES];
    }];
    
    [self.navigationController presentViewController:searShopVC animated:nil completion:nil];
}
@end
