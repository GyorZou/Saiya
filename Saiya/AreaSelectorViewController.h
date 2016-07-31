//
//  AreaSelectorViewController.h
//  Saiya
//
//  Created by zougyor on 16/7/31.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "BaseViewController.h"

@interface AreaSelectorViewController : BaseViewController


@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentHeight;

@property (nonatomic,strong) IBOutlet UIView * contentView,*areas;
@property (nonatomic,strong) IBOutlet UIButton * c1,*c2,*c3;
@property (nonatomic,strong) IBOutlet UIPickerView * piker;
@property IBOutlet UITextField * filed;

@property (nonatomic,copy) void(^doSearchBlk)(NSString* regionID);

@property (nonatomic,strong) NSArray * areasData,*statesData;

@end
