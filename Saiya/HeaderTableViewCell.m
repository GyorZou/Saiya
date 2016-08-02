//
//  HeaderTableViewCell.m
//  Saiya
//
//  Created by zougyor on 16/8/2.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)headClicked:(UIButton*)sender
{

    if (_headBlk) {
        _headBlk();
    }
}
@end
