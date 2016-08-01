//
//  CityInputCell.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "CityInputCell.h"

@implementation CityInputCell

- (void)awakeFromNib {
    // Initialization code
    _f1.delegate =_f2.delegate =_f3.delegate = self;
    UIPickerView * pick = [[UIPickerView alloc] init];
    pick.frame =CGRectMake(0, 0, SCREENWIDTH, 216);
    pick.dataSource = self;
    pick.delegate = self;
    _f1.inputView = _f1.inputView = _f1.inputView = pick;
    
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
        return  3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"xx";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
