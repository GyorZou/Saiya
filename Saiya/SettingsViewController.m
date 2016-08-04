//
//  SettingsViewController.m
//  Saiya
//
//  Created by zougyor on 16/8/4.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    [self updateView];
}
-(void)updateView{
    if([[SaiyaUser curUser] isLogined]){
        self.unloginView.hidden = YES;
    }else{
        self.unloginView.hidden = NO;
    }
}
-(void)logout
{
    [LoginPage cleanWhenLogout];
    [self updateView];
    [[NSNotificationCenter defaultCenter] postNotificationName:[SaiyaUser notificationString] object:nil];
    
}
-(IBAction)logOutClick:(id)sender
{
    [self logout];
}
-(IBAction)aboutSaiya:(id)sender
{
    
}
-(IBAction)changePwd:(id)sender
{
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
