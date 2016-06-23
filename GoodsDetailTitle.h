//
//  GoodsDetailTitle.h
//  ewj
//
//  Created by jp007 on 15/8/11.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailTitle : UIView
@property (nonatomic,strong) NSArray * titles;
@property (nonatomic,copy) void (^indexChangeBlock)(int,int);
@property (nonatomic,assign) int index;
@property (nonatomic,strong) UIColor * selectedTitleColor, *unselectedTitleColor;
@property (nonatomic,strong) UIFont * selectedTitleFont, *unselectedTitleFont;
-(void)BtnNotToClick;
@end
