//
//  MyHeadCell.h
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeadCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView * headImgeView;
@property (nonatomic,weak) IBOutlet UILabel * nameLabel,*countLabel;
@property (nonatomic,copy) void (^QRCodeBlk)();
@end
