//
//  MySignatureTableViewCell.h
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySignatureTableViewCell : UITableViewCell<UITextViewDelegate>

@property IBOutlet UITextView *infoLabel;
@property __weak SaiyaUser * user;

@end
