//
//  LoginPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "LoginPage.h"
#import "RegisterPage.h"

#import "MBProgressHUD+Add.h"
#import "TTGlobalUICommon.h"
#import "ChatDemoHelper.h"
#import "MainViewController.h"
@interface LoginPage ()<UITextFieldDelegate>
{
    IBOutlet UIButton * _loginBtn;
}
@end

@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.backBarButtonItem = [self backItem];
    self.navigationItem.rightBarButtonItem = [self rightItem];
    
    self.view.backgroundColor = APPCOLOR_GRAY; //[UIColor whiteColor];
    self.quickLabel.backgroundColor = APPCOLOR_GRAY;
    _nameFiled.delegate = _pwdField.delegate = self;
    _loginBtn.backgroundColor = [UIColor grayColor];
    _loginBtn.enabled = [self checkName:_nameFiled.text] && [self checkPwd:_pwdField.text];
    if (_loginBtn.enabled) {
        _loginBtn.backgroundColor = APPCOLOR_ORINGE;
    }
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.clipsToBounds = YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * pwd = _pwdField.text;
    NSString * name = _nameFiled.text;
    NSString * or = textField.text;

    long count = or.length;
    if (range.location>=count) {
        or = [or stringByAppendingString:string];
        
    }else{
        or = [or stringByReplacingCharactersInRange:range withString:string];
    }
    [UIView animateWithDuration:0 animations:^{
        
    }];
    if (_pwdField == textField) {
        pwd = or;
    }else{
        if (or.length > 11) {
            return NO;
        }
        name = or;
    }
    if ([self checkName:name]&&[self checkPwd:pwd]) {
        _loginBtn.backgroundColor = APPCOLOR_ORINGE;
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.backgroundColor = [UIColor grayColor];
        _loginBtn.enabled = NO;
    }
    return YES;
}

-(void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)registBtnClick
{
        RegisterPage * p2 = [RegisterPage new];
        [self.navigationController pushViewController:p2 animated:YES];
    


}
-(UIBarButtonItem *)rightItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    
    [backBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[backBtn setImage:[UIImage imageNamed:@"icon-release"] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];;
    
}
-(UIBarButtonItem *)backItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];

    [backBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[backBtn setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];;
}
-(NSString*)normalLoginUrl
{
    return @"http://saiya.tv/api/customer/Login";
}
-(NSString*)thirdLoginUrl
{
    return @"http://saiya.tv/api/customer/Login";
}
-(BOOL)checkName:(NSString*)name
{
    
    return name.length >= 11;
}
-(BOOL)checkPwd:(NSString*)pwd
{
    return pwd.length >=6;
}
-(IBAction)loginBtnClick:(id)sender
{

    
    [NWFToastView showProgress:@"正在登录..."];
    NSDictionary * dict = @{@"Account":_nameFiled.text,@"Password":_pwdField.text};
    [[NetworkManagementRequset manager] requestPostData:[self normalLoginUrl] postData:dict complation:^BOOL(BOOL result, id returnData) {
        [NWFToastView dismissProgress];
        if (result && [[returnData objectForKey:@"result"] boolValue] != NO) {
            
             NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
            [def setObject:[returnData objectForKey:@"data"] forKey:@"acc_token"];
            [def synchronize];
            
             [self huanxinLogin];
            NSLog(@"%@",returnData);
        }else{
            [NWFToastView showToast:@"用户名或密码错误"];
        }
        
        return YES;
    }];
    
}

-(IBAction)forgetPwdClick:(id)sender
{

}
-(IBAction)weixinClick:(id)sender
{
    
}
-(IBAction)qqClick:(id)sender
{
    
}
-(IBAction)weiboClick:(id)sender
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

-(void)huanxinLogin
{

    [self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];
    //异步登陆账号
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:_nameFiled.text password:_pwdField.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself hideHud];
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                //获取数据库中数据
                [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[EMClient sharedClient] dataMigrationTo3];
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [[ChatDemoHelper shareHelper] asyncGroupFromServer];
//                        [[ChatDemoHelper shareHelper] asyncConversationFromDB];
//                        [[ChatDemoHelper shareHelper] asyncPushOptions];
                        
                        
                        
                        [MBProgressHUD hideAllHUDsForView:weakself.view animated:YES];
                        //发送自动登陆状态通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                        
                        //保存最近一次登录用户名
                        //[weakself saveLastLoginUsername];
                    });
                });
                
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                switch (error.code)
                {
                        //                    case EMErrorNotFound:
                        //                        TTAlertNoTitle(error.errorDescription);
                        //                        break;
                    case EMErrorNetworkUnavailable:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                        break;
                    case EMErrorServerNotReachable:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                        break;
                    case EMErrorUserAuthenticationFailed:
                        TTAlertNoTitle(error.errorDescription);
                        break;
                    case EMErrorServerTimeout:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                        break;
                    default:
                        TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                        break;
                }
            }
        });
    });

}
+(void)show
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
   // NSString * s = [def objectForKey:@"acc_token"];
    [def setObject:nil forKey:@"acc_token"];
    
    [def synchronize];
    
    if ([[EMClient sharedClient]  isLoggedIn]) {
        [[EMClient sharedClient]  logout:YES];
    }
    
    LoginPage * lg = [LoginPage new];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:lg];

    
    [[MainViewController currentInstance] presentViewController:navi animated:YES completion:nil];

}
+(BOOL)showIfNotLogin
{

    BOOL isLogin = [EMClient sharedClient].isLoggedIn;
    if (isLogin == NO || [AppDelegate isLogin] == NO) {
        [LoginPage show];
        return NO;
    }
    return YES;
}
@end
