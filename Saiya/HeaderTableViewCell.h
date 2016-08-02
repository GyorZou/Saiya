//
//  HeaderTableViewCell.h
//  Saiya
//
//  Created by zougyor on 16/8/2.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell
@property IBOutlet UIButton * headBtn;
@property IBOutlet UIImageView * headImage;
@property (nonatomic,copy) void (^headBlk)();
@end
