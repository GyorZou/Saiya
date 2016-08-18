//
//  ChangePasswordController.m
//  Saiya
//
//  Created by jp007 on 16/8/15.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "ChangePasswordController.h"

@interface ChangePasswordController ()
{
    IBOutlet UITextField * _oldPwd,*_pwd1,*_pwd2;
}
@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(IBAction)changeBtnClick:(id)sender
{
    
    if ([self checkLength:_oldPwd.text] && [self checkLength:_pwd2.text] && [self checkLength:_pwd1.text] ) {
        if([self checkPwd]){
            NSString * url=@"http://saiya.tv/api/customer/ChangePassword";
            /*
             OldPassword
             NewPassword
             ConfirmNewPassword
             */
            [NWFToastView showProgress:@"正在修改..."];
            NSDictionary * dict = @{@"OldPassword":_oldPwd.text,@"NewPassword":_pwd1.text,@"ConfirmNewPassword":_pwd2.text};
            [[NetworkManagementRequset manager] requestPostData:url postData:dict complation:^BOOL(BOOL result, id returnData) {
                [NWFToastView dismissProgress];
                if (result && [[returnData objectForKey:@"result"] boolValue] != NO) {
                
                    [NWFToastView showToast:@"密码修改成功"];
                    _oldPwd.text = _pwd1.text = _pwd2.text = @"";
                    NSLog(@"%@",returnData);
                }else{
                    
                    [NWFToastView showToast:@"旧密码错误"];
                }
                
                return YES;
            }];
        }else{
            [NWFToastView showToast:@"两次密码不一致"];
        }
 

    }else{
        [NWFToastView showToast:@"密码长度不够"];
    }
    
    
}
-(BOOL)checkLength:(NSString*)name
{
    
    return name.length >= 6;
}
-(BOOL)checkPwd
{
    return [_pwd1.text isEqualToString:_pwd2.text];
}

@end
