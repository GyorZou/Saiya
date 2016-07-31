//
//  CategoryViewController.h
//  Saiya
//
//  Created by zougyor on 16/7/31.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "BaseViewController.h"

@interface CategoryViewController : BaseViewController
@property (nonatomic,strong) NSArray * areasData;
@property (nonatomic,copy) void(^doSearchBlk)(NSString* regionID);
@end
