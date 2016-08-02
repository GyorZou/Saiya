//
//  ImagesTableViewCell.h
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"
@interface ImagesTableViewCell : UITableViewCell
@property IBOutlet EScrollerView * imageViews;
@property IBOutlet UIButton * deleteBtn,*addBtn;
@property (nonatomic,copy) void (^deleteBlk)();
@property (nonatomic,copy) void (^addBlk)();


@end
