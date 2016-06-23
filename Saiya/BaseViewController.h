//
//  BaseViewController.h
//  ewj
//
//  Created by jp007 on 15/8/11.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import <UIKit/UIKit.h>


#define pro [UIScreen mainScreen].bounds.size.width/320


@interface BaseViewController : UIViewController
@property (nonatomic,strong) UIImage *backImage;
-(UIBarButtonItem *)backItem;
-(void)dissmiss;

-(void)goHome;
@end
