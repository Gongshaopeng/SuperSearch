//
//  SearchVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/14.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//
#import "searchProtocolLmpl.h"

#import "SearchVC.h"

#import "GoodsSetVC.h"
#import "HistorySearchVC.h"
#import "SupSearchTopView.h"
#import "PopularSearchesCell.h"
#import "DirectionsCell.h"

#import "GSFeatured.h"

@interface SearchVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,MySupSearchTopDelegate,MySupSearchCellDelegate>
{
   CGFloat  PopularSearchesCellHieght;
    NSArray * heightD;//教程图片高度
}
@property (nonatomic,strong) SupSearchTopView * ssTopView;
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@property (nonatomic,strong)id<searchProtocol>searchImpl;

@property (nonatomic,strong) NSMutableArray * hotArr;
@end
/* cell */
static NSString *const PopularSearchesCellID = @"PopularSearchesCell";
static NSString *const DirectionsCellID = @"DirectionsCell";

/* head */
static NSString *const SupSearchTopViewID = @"SupSearchTopView";

/* foot */

@implementation SearchVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = [DEFAULTS integerForKey:__DEF_KEY_SearchsTatusBarStyle];

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
    [self s_Init];
    [self requestEditConfi];
    [self.myView addSubview:self.collectionView];
}

-(void)s_Init{
    heightD = @[@"583",@"653",@"655",@"657",@"719"];
    self.searchImpl = [[searchProtocolLmpl alloc]init];
    
    if ([EntireManageMent isExisedManager:EditConfig_TWO]) {
        [self cacheDataEditConfig:[STool strTransformArr:[EntireManageMent readCacheDataWithName:EditConfig_ONE]]];
    }
}
#pragma mark - Cache
-(void)cacheDataEditConfig:(NSArray *)dataArr{
    for (NSDictionary * dict in dataArr) {
        GSFeatured * featModel = [[GSFeatured alloc] initWithDictionary:dict error:nil];
        [self.hotArr addObject:featModel.Title];
    }
    [_collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 搜索详情页面

-(void)pushGoodsSet:(NSString *)title favoritesId:(NSString *)favoritesId isCouponOrUatm:(BOOL)isCouponOrUatm{
    GoodsSetVC * gSetVc = [[GoodsSetVC alloc]init];
    gSetVc.searchStr = title;
    gSetVc.favoritesId = favoritesId;
    gSetVc.isCouponOrUatm = isCouponOrUatm;
    [self.navigationController pushViewController:gSetVc animated:YES];
    
}
#pragma mark - 通知处理
- (void)clipbosrdSearchPop:(NSNotification *)notification
{
    GSLog(@"通知中心");
    NSDictionary * dict = notification.userInfo;
    TBKCouponModel * iModel = [[TBKCouponModel alloc]initWithDictionary:dict error:nil];
    [self pushGoodsSet:iModel.Title favoritesId:@"" isCouponOrUatm:YES];
}
- (void)clipbosrdGoodsPop:(NSNotification *)notification
{
//    __kWeakSelf__;
    NSDictionary * dict = notification.userInfo;
    ItemModel * iModel = [[ItemModel alloc]initWithDictionary:dict error:nil];
    [ALBCPush pushALBCSDK:pushALBCTypeMyCoupon openType:ALBCOpenTypeNative data:iModel complete:^(UIViewController *vc) {
        DetailVC * dvc = (DetailVC *)vc;
//        dvc.delegate = weakSelf;
        [[SSpeedy ss_getCurrentVC].navigationController pushViewController:dvc animated:YES];
    }];
    GSLog(@"通知中心");
}
#pragma mark - 搜索
-(void)requestEditConfi{
    __kWeakSelf__;
    [self.searchImpl r_Search_EditConfig:[RequestModel modelWithDictionary:@{@"cate":@"2"}] complete:^(ResponseModel *model) {
        GSLog(@"requestEditConfi %@",model);
       
        if (weakSelf.hotArr.count != 0) {
            [_hotArr removeAllObjects];
        }
        [EntireManageMent addCacheName:EditConfig_TWO jsonString:[STool arrTransformString:model.Datas] updataTime:nil];
        [self cacheDataEditConfig:model.Datas];
    } failed:^(RequestFailedError error) {
        
    }];
}

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
            searShopVC.resultListArray = self.hotArr?:tempArray;
        });
    }];
    
    [searShopVC resultListViewDidSelectedIndex:^(UITableView *tableView, NSInteger index) {
        searchStr = self.hotArr[index]?:tempArray[index];
        [self pushGoodsSet:searchStr favoritesId:@"16466111"isCouponOrUatm:YES];
    }];
    
    [self.navigationController presentViewController:searShopVC animated:nil completion:nil];
}
#pragma mark - myDelegate
-(void)mySupSearchSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content{
    [self pushGoodsSet:content favoritesId:@""isCouponOrUatm:YES];

}
-(void)mySupSearchTopClicked{
    [self searchButtonClick];
}
#pragma mark - <UICollectionViewDataSource>
//- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.row == 0) {//10
        PopularSearchesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PopularSearchesCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        GSLog(@"%f",cell.tagList.contentSize.height);
        cell.delegate = self;
        if (self.hotArr.count != 0) {
            cell.listHot = self.hotArr;
//            if (PopularSearchesCellHieght == 0) {
//                PopularSearchesCellHieght = cell.tagList.contentSize.height;
//                [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil]];
//            }
        }
        gridcell = cell;
//        if (PopularSearchesCellHieght == 0) {
//            PopularSearchesCellHieght = cell.tagList.contentSize.height-(cell.tagList.contentSize.height/5);
//            [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil]];
//
//        }

    }else{
        DirectionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DirectionsCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        NSString *first_step = [NSString stringWithFormat:@"first_step_%ld",indexPath.row];
        cell.directionImageView.image = [UIImage imageNamed:first_step];
        
        [cell.directionImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cell.mas_top).offset(__kNewSize(2));
            make.centerX.mas_equalTo(cell);
            //        make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(__kNewSize(417), __kNewSize([heightD[indexPath.row-1] integerValue])));
        }];
        gridcell = cell;
    }
    
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    SupSearchTopView *headerView ;
    headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SupSearchTopViewID forIndexPath:indexPath];
    headerView.delegate =self;

 
    return headerView;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {//猜你喜欢
    
        return CGSizeMake(__kScreenWidth__, PopularSearchesCellHieght?:__kNewSize(126+196));
    }else{
        return CGSizeMake(__kScreenWidth__, __kNewSize([heightD[indexPath.row-1] integerValue]+__kNewSize(106)));

    }
    return CGSizeZero;
}


#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(__kScreenWidth__, __kNewSize(510)); //图片滚动的宽高

}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
 
    
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//定义每个UICollectionView 的边距
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {

    return UIEdgeInsetsMake ( 0 , 0 , 0 , 0 );
    
}
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return  0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
   
    
    return  0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10

    }
    if (indexPath.section == 1) {
        
    }
    if (indexPath.section == 2) {
     
    }
}
#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setScrollViewContentOffsetY:scrollView.contentOffset.y];
}

-(void)setScrollViewContentOffsetY:(CGFloat)y{
    if ( y > __kScreenHeight__) {
        [DEFAULTS setInteger:0 forKey:__DEF_KEY_SearchsTatusBarStyle];
        
    }else{
        [DEFAULTS setInteger:1 forKey:__DEF_KEY_SearchsTatusBarStyle];
        
    }
    [UIApplication sharedApplication].statusBarStyle = [DEFAULTS integerForKey:__DEF_KEY_SearchsTatusBarStyle];

}
#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, __kScreenWidth__, __kBarHeight__);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;
        /* cell */
        [_collectionView registerClass:[PopularSearchesCell class] forCellWithReuseIdentifier:PopularSearchesCellID];
        [_collectionView registerClass:[DirectionsCell class] forCellWithReuseIdentifier:DirectionsCellID];
//        [_collectionView registerClass:[GSGoodsYouLikeCell class] forCellWithReuseIdentifier:GSGoodsYouLikeCellID];
//
//        /* head */
        [_collectionView registerClass:[SupSearchTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SupSearchTopViewID];
//
//
//        /* foot */
//        [_collectionView registerClass:[GSYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GSYouLikeHeadViewID];
        
//        [self.myView addSubview:_collectionView];
        
    }
    return _collectionView;
    
}
-(SupSearchTopView *)ssTopView{
    if (!_ssTopView) {
        _ssTopView = [[SupSearchTopView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth__, __kNewSize(510))];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"first_search_bg-@2x"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        _ssTopView.layer.contents = (id)image.CGImage;
    }
    return _ssTopView;
}
-(NSMutableArray *)hotArr{
    if (!_hotArr) {
        _hotArr = [[NSMutableArray alloc]initWithArray:@[@"女装",@"男装",@"手机",@"电脑"]];
    }
    return _hotArr;
}
@end
