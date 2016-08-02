//
//  MySignatureTableViewCell.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "MySignatureTableViewCell.h"

@implementation MySignatureTableViewCell

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
    _infoLabel.delegate = self;
}
-(void)textViewDidChange:(UITextView *)textView
{
    _user.Description = textView.text;
}
@end
