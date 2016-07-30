//
//  AppDelegate+ShareSDK.h
//  Saiya
//
//  Created by jp007 on 16/7/14.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <RennSDK/RennSDK.h>


@interface AppDelegate (ShareSDK)
-(void)setupShareSDK;

@end
