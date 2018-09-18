//
//  ShareImageVC.m
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/5/31.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "ShareImageVC.h"
#import "ImageItmeCell.h"
#import "ImgQRView.h"


@interface ShareImageVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
@property (strong , nonatomic)NSMutableArray *imageArrData;
@property (strong , nonatomic)ImgQRView *imageQRV;

@end
/* cell */
static NSString *const ImageItmeCellID = @"ImageItmeCell";

@implementation ShareImageVC
-(ImgQRView *)imageQRV{
    if(!_imageQRV){
        _imageQRV = [[ImgQRView alloc]init];
        _imageQRV.itemM = self.model;
        _imageQRV.layer.borderWidth = 1;
        _imageQRV.layer.borderColor=[UIColor whiteColor].CGColor;

    }
    return _imageQRV;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

//        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        /* cell */
        
        [_collectionView registerClass:[ImageItmeCell class] forCellWithReuseIdentifier:ImageItmeCellID];
        
        /* head */
        //        [_collectionView registerClass:[GoodsToolsView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GSGoodsToolsViewID];
        
        /* foot */
        
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDataSource>
//- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return self.imageArrData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    
    ImageItmeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageItmeCellID forIndexPath:indexPath];
   
    cell.imgUrl = self.imageArrData[indexPath.row];
    gridcell = cell;
    gridcell.backgroundColor = [UIColor whiteColor];
    
    return gridcell;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    return CGSizeMake(__kScreenWidth__/4 , __kScreenWidth__/4 );
}


#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
   
    
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//定义每个UICollectionView 的边距
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    
    return  UIEdgeInsetsMake(20, 20, 20, 20);

}
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat X = 20.0;
    
    
    return  X;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat Y = 20.0;
   
    return  Y;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        _imageQRV.imageUrl = _imageArrData[indexPath.row];
}
#pragma mark — Click
-(void)dowImageClick:(UIButton *)btn{
    UIImage *img = [UIImage imageWithScreenshotView:_imageQRV SHWidth:__kNewSize(546) SHHeight:__kNewSize(768)];
 UIImageWriteToSavedPhotosAlbum(img, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
#pragma mark --- UIActionSheetDelegate---

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
    
    NSString *message = @"成功";
    
    if (!error) {
        
        message = @"成功保存到相册";
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
        
        
    }else
    
    {
        
        message = [error description];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存失败！请重试。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self i_Init];
    [self i_UI];
    [self i_Frame];
}

-(void)i_Init{
    self.baseNavigationBar.titleLabel.text = @"生成图片";
    self.myView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    [self createRightBarButton:@"保存" WithSelector:@selector(dowImageClick:)];

}
-(void)i_UI{
    [self.myView addSubview:self.collectionView];
    [self.myView addSubview:self.imageQRV];

}
-(void)i_Frame{
    _collectionView.frame = CGRectMake(20, __kNewSize(100), __kScreenWidth__-40, __kScreenWidth__/4 );
    _imageQRV.frame = CGRectMake((__kScreenWidth__-__kNewSize(546))/2, _collectionView.dc_bottom+20, __kNewSize(546), __kNewSize(768));

}

#pragma mark - 小图片
-(NSMutableArray *)imageArrData{
    if(!_imageArrData){
       _imageArrData = [[NSMutableArray alloc]init];
        [_imageArrData addObject:self.model.PictUrl];
        for (NSString *imgurl  in self.model.SmallImages) {
            [_imageArrData addObject:imgurl];
        }
    }
    return _imageArrData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
