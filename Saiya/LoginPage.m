//
//  LoginPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "LoginPage.h"
#import "RegisterPage.h"
#import "FindPwdPage1.h"
#import "MBProgressHUD+Add.h"
#import "TTGlobalUICommon.h"
#import "ChatDemoHelper.h"
#import "MainViewController.h"

#import <ShareSDK/ShareSDK.h>

@interface LoginPage ()<UITextFieldDelegate>
{
    IBOutlet UIButton * _loginBtn;
    NSString * hxName,*hxPwd;
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
{//http://saiya.tv/api/customer/LoginAuths
    return @"http://saiya.tv/api/customer/LoginAuths";
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
           // [def setObject:@"6208" forKey:@"acc_token"];
            [def synchronize];
            
            hxName = _nameFiled.text;
            hxPwd = _pwdField.text;
            [self huanxinLogin:NO];
            NSLog(@"%@",returnData);
        }else{
           
            [NWFToastView showToast:@"用户名或密码错误"];
        }
        
        return YES;
    }];
    
}

-(IBAction)forgetPwdClick:(id)sender
{
    FindPwdPage1 * p = [FindPwdPage1 new];
    [self.navigationController pushViewController:p animated:YES];
}
-(IBAction)weixinClick:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeWeixiSession authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        NSLog(@"%d",result);
        if (result) {
            //成功登录后，判断该用户的ID是否在自己的数据库中。
            //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
            //[self reloadStateWithType:ShareTypeSinaWeibo];
            
            
            NSDictionary * d = [self thirdPartDictWithOpenId:userInfo.credential.uid token:userInfo.credential.token forType:2];
            [self thirdPartLogin:d];
        }
    }];
}
-(IBAction)qqClick:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        NSLog(@"%d",result);
        if (result) {
            //成功登录后，判断该用户的ID是否在自己的数据库中。
            //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
            //[self reloadStateWithType:ShareTypeSinaWeibo];
            NSDictionary * d = [self thirdPartDictWithOpenId:userInfo.credential.uid token:userInfo.credential.token forType:1];
            [self thirdPartLogin:d];

        }
    }];

    
}
-(IBAction)weiboClick:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        NSLog(@"%d",result);
        if (result) {
            //成功登录后，判断该用户的ID是否在自己的数据库中。
            //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
            //[self reloadStateWithType:ShareTypeSinaWeibo];
            NSDictionary * d = [self thirdPartDictWithOpenId:userInfo.credential.uid token:userInfo.credential.token forType:2];
            [self thirdPartLogin:d];

        }
    }];

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

-(void)huanxinLogin:(BOOL)showHud
{

    if (showHud) {
       // [self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];
        [NWFToastView showProgress:@"登录中..."];
    }

    //异步登陆账号
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:hxName password:@"123456"];//如果未注册，那注册一下吧
        if (error.code == EMErrorUserNotFound) {
            EMError* error = [[EMClient sharedClient] registerWithUsername:hxName  password:@"123456"];
            if (error == nil) {
              dispatch_async(dispatch_get_main_queue(), ^{
                [self huanxinLogin:NO];
              });
                
                return;
            }
            
        }
        [NWFToastView dismissProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[weakself hideHud];
            
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                //获取数据库中数据
                [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[EMClient sharedClient] dataMigrationTo3];
                    dispatch_async(dispatch_get_main_queue(), ^{

                        
                        
                        [MBProgressHUD hideAllHUDsForView:weakself.view animated:YES];
                        //发送自动登陆状态通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];

                    });
                });
                
                if (_blk) {
                    _blk();
                }
                [[SaiyaUser curUser] reloadData];
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
    [self showWithCompletion:nil];

}
+(void)cleanWhenLogout
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    // NSString * s = [def objectForKey:@"acc_token"];
    [def setObject:nil forKey:@"acc_token"];
    
    [def synchronize];
    
    if ([[EMClient sharedClient]  isLoggedIn]) {
        [[EMClient sharedClient]  logout:YES];
    }
}
+(void)showWithCompletion:(void (^)(void))blk
{

    [self cleanWhenLogout];
    
    LoginPage * lg = [LoginPage new];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:lg];
    
    lg.blk = blk;
    [[MainViewController currentInstance] presentViewController:navi animated:YES completion:nil];
}
+(BOOL)showIfNotLogin
{

    
    BOOL isLogin = [[SaiyaUser curUser] isLogined]; //[EMClient sharedClient].isLoggedIn;
    if (isLogin == NO) {
        [LoginPage show];
        return NO;
    }
    return YES;
}

-(void)thirdPartDidLogined
{

        [[SaiyaUser curUser] reloadDataWithCompletion:^(BOOL suc){
            
            if (suc) {
                SaiyaUser * curUser = [SaiyaUser curUser];
                hxName = NSStringFromObject(curUser.Id);
                hxPwd = @"123456";
                [self huanxinLogin:YES];
            }else{
                //登录失败
                [NWFToastView dismissProgress];
            }
            
        }];

}
-(void)thirdPartLogin:(NSDictionary*)dict
{//http://saiya.tv/api/customer/LoginAuths
    
    
    [[NetworkManagementRequset manager] requestPostData:[self thirdLoginUrl] postData:dict complation:^BOOL(BOOL result, id returnData) {
        
        if (result && [[returnData objectForKey:@"result"] boolValue] != NO) {
            
            NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
            [def setObject:[returnData objectForKey:@"data"] forKey:@"acc_token"];
            [def synchronize];
            
           

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self thirdPartDidLogined];
            });
            

         
            NSLog(@"%@",returnData);
        }else{
            [NWFToastView dismissProgress];
            [NWFToastView showToast:@"用户名或密码错误"];
        }
        
        return YES;
    }];


}
-(NSDictionary*)thirdPartDictWithOpenId:(NSString*)pid token:(NSString*)token forType:(int)i
{
    return @{@"Type":@(i),@"OpenId":pid,@"Token":token};
}
@end
