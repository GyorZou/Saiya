//
//  InputTableViewCell.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "InputTableViewCell.h"

@implementation InputTableViewCell

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
    if ([_titleLabel.text isEqualToString:@"性别"]) {
        UIPickerView * pick = [[UIPickerView alloc] init];
        pick.frame =CGRectMake(0, 0, SCREENWIDTH, 216);
        pick.dataSource = self;
        pick.delegate = self;
        self.infoLabel.inputView = pick;
        if([_user.Gender isEqual:@"男"] == NO&&[_user.Gender isEqual:@"女"] == NO){
            [self pickerView:pick didSelectRow:0 inComponent:0];
        }
    }else{
        self.infoLabel.inputView = nil;
    }
    
    if ([_titleLabel.text isEqualToString:@"年龄"]) {
        _infoLabel.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        _infoLabel.keyboardType = UIKeyboardTypeDefault;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString * text = textField.text;
    if ([_titleLabel.text isEqualToString:@"姓名"]) {
        _user.Username = text;
    }else if ([_titleLabel.text isEqualToString:@"性别"]) {
        
    }else if ([_titleLabel.text isEqualToString:@"年龄"]) {
        _user.Old = @([text intValue]);
    }else if ([_titleLabel.text isEqualToString:@"情感状态"]) {
        _user.EmotionalState = text;
        
    }else if ([_titleLabel.text isEqualToString:@"签名"]) {
        _user.Signature = text;
    }else if ([_titleLabel.text isEqualToString:@"微博"]) {
        _user.Weibo = text;
    }
    
}




-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return 2;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (row == 0) {
        return @"男";
    }
    
    return @"女";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row==0) {
        _user.Gender = @"男";
    
    }else{
        _user.Gender = @"女";
    }
    _infoLabel.text = _user.Gender;
}

@end
