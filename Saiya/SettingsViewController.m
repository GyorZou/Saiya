//
//  SettingsViewController.m
//  Saiya
//
//  Created by zougyor on 16/8/4.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SettingsViewController.h"
#import "AboutSaiyaViewController.h"
#import "ChangePasswordController.h"
@interface SettingsViewController ()<UIAlertViewDelegate>

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
    
    self.unloginVersionLabel.text = APPENDSTRING(@"v",  [SettingsViewController appVersion]);
    self.versionLabel.text =APPENDSTRING(@"v",  [SettingsViewController appVersion]);
}
-(void)logout
{
    [LoginPage cleanWhenLogout];
    [self updateView];
    [[NSNotificationCenter defaultCenter] postNotificationName:[SaiyaUser notificationString] object:nil];
    
}
-(IBAction)clearClick:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认清空缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [NWFToastView showToast:@"缓存已清除"];
        });
        
    }

}

+(NSString *)appVersion
{
    NSString *version=  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return  version;
}
-(IBAction)logOutClick:(id)sender
{
    [self logout];
}
-(IBAction)aboutSaiya:(id)sender
{
    AboutSaiyaViewController * ab = [AboutSaiyaViewController new];
    [self.navigationController pushViewController:ab animated:YES];
}
-(IBAction)changePwd:(id)sender
{
    ChangePasswordController * vc = [ChangePasswordController new];
    vc.title = @"修改密码";
    [self.navigationController pushViewController:vc animated:YES];
    
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
