//
//  CityInputCell.h
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityInputCell : UITableViewCell<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UITextField * _f1,*_f2,*_f3;
    UIPickerView * _piker;
    
}
@property __weak SaiyaUser * user;
@property NSArray * states,*citys,*distris;
@property IBOutlet UILabel * titleLabel;
@end
