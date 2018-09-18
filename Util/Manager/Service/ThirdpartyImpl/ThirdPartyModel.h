//
//  ThirdPartyModel.h
//  MQBrowser
//
//  Created by 巩小鹏 on 2017/9/22.
//  Copyright © 2017年 巩小鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ThirdPartyModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *type;
@property (nonatomic,copy) NSString<Optional> *url_short;
@property (nonatomic,copy) NSString<Optional> *url_long;



@end
