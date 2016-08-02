//
//  SaveTableViewCell.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaveTableViewCell.h"

@implementation SaveTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)headClicked:(UIButton*)sender
{
    
    if (_saveBlk) {
        _saveBlk();
    }
}
@end
