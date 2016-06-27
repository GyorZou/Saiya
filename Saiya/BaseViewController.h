//
//  BaseViewController.h
//  ewj
//
//  Created by jp007 on 15/8/11.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWFToastView.h"
#import "EaseUI.h"
#import "EMSDK.h"
#import "EMClient.h"
#import "EMClientDelegate.h"
#import "NetworkManagementRequset.h"

#define pro [UIScreen mainScreen].bounds.size.width/320
//RGB颜色
#define RGBColor(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface BaseViewController : UIViewController
@property (nonatomic,strong) UIImage *backImage;
-(UIBarButtonItem *)backItem;
-(void)dissmiss;

-(void)goHome;
@end
