//
//  AppDelegate.h
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) MainViewController * mainController;
@property (readonly) BOOL isLogin;

+(BOOL) isLogin;//仅仅判断accToken
+(NSString*)accToken;

@end

