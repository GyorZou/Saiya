//
//  AppDelegate.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "AppDelegate+EaseMob.h"
#define EaseMobAppKey @"junfeng2016#saiya"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
#warning 初始化环信SDK，详细内容在AppDelegate+EaseMob.m 文件中
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"push_dev";
#else
    apnsCertName = @"push_dis";
#endif
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appkey = [ud stringForKey:@"identifier_appkey"];
    if (!appkey) {
        appkey = EaseMobAppKey;
        [ud setObject:appkey forKey:@"identifier_appkey"];
    }
    
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:appkey
                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:APPCOLOR_ORINGE];

    NSArray * arr = self.window.rootViewController.childViewControllers;
    int index = 1;
    for (UIViewController *vc in arr) {
        NSString * name = APPENDSTRING(@"icon-nav", NSStringFromInt(index));
        NSString * name_s = APPENDSTRING(@"icon-nav", NSStringFromInt(index));
        name_s =APPENDSTRING(name_s, @"-visited");
        vc.tabBarItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:name_s] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : APPCOLOR_ORINGE }forState:UIControlStateSelected];
        index++;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
