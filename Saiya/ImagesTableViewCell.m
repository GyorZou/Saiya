//
//  ImagesTableViewCell.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "ImagesTableViewCell.h"

@implementation ImagesTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)addBtn:(id)sender
{
    if (_addBlk) {
        _addBlk();
    }
}
-(IBAction)deleBtn:(id)sender
{
    if (_deleteBlk) {
        _deleteBlk();
    }
}
@end
