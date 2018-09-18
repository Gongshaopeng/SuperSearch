//
//  UatmFavoritesModel.h
//  SuperSearch
//
//  Created by 巩小鹏 on 2018/3/21.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "BaseModel.h"

@interface UatmFavoritesModel : BaseModel

@property (nonatomic,strong) NSString * FavoritesId;
@property (nonatomic,strong) NSString * FavoritesTitle;
@property (nonatomic,strong) NSString * Type;

@end
/*
 FavoritesId = 16465992;
 FavoritesTitle = "\U6dd8\U5b9d\U6c47\U5403";
 Type = 1;
 */
