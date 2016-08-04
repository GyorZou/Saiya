//
//  LoginPage.h
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginPage : BaseViewController
@property (nonatomic,weak) IBOutlet UILabel * quickLabel;
@property (nonatomic,weak) IBOutlet UITextField * nameFiled,*pwdField;
@property (nonatomic,copy) void (^blk)(void);

+(void)show;

+(void)showWithCompletion:(void(^)(void))blk;
+(void)cleanWhenLogout;

/**
 *  未登录就显示，返回是否登录结果
 *
 *  @return 是否已登录，yes是已登录
 */
+(BOOL)showIfNotLogin;
@end
