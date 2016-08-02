//
//  InputTableViewCell.h
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputTableViewCell : UITableViewCell<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property IBOutlet UILabel * titleLabel;
@property IBOutlet UITextField *infoLabel;
@property __weak SaiyaUser * user;

@end
