//
//  SaveTableViewCell.h
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveTableViewCell : UITableViewCell

@property (nonatomic,copy) void (^saveBlk)();

@end
