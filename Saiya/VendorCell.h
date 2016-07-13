//
//  VendorCell.h
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VendorCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView * avartarImage ;
@property (nonatomic,weak) IBOutlet UILabel *vendorNameLB,*countLB,*detailLB;
@end
