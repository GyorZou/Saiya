//
//  HotEventTableViewCell.m
//  Saiya
//
//  Created by jp007 on 16/7/12.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "HotEventTableViewCell.h"

@implementation HotEventTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avartarImage.layer.cornerRadius = self.avartarImage.frame.size.width/2;
    self.avartarImage.clipsToBounds = YES;
}

@end
