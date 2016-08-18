//
//  FindPwdPage2.m
//  Saiya
//
//  Created by jp007 on 16/8/18.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "FindPwdPage2.h"
#import "GoodsDetailTitle.h"
@interface FindPwdPage2 ()<UITextFieldDelegate>
{
    // IBOutlet UILabel * _phoneLabel,*_tickLabel;;
    IBOutlet UITextField * _pwdField,*_pwdField2;
    IBOutlet UIButton * _nextBtn;
}

@end

@implementation FindPwdPage2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = APPCOLOR_GRAY;
    [self initTitleview];
    _pwdField.delegate = _pwdField2.delegate = self;
    _nextBtn.enabled = NO;
    
}
-(void)initTitleview
{
    
    GoodsDetailTitle *title =[[GoodsDetailTitle alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    title.selectedTitleColor = [UIColor whiteColor];
    title.unselectedTitleColor = APPCOLOR_GRAY;
    
    
    title.titles=@[@"找回密码"];
    
    
    self.navigationItem.titleView=title;
    //self.navigationItem.rightBarButtonItem = [self rightItem];
    
    
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


-(IBAction)registerBtn:(id)sender
{
    if ([_pwdField2.text isEqualToString:_pwdField.text] == NO) {
        [NWFToastView showToast:@"两次密码不一致"];
        return;
    }
    [NWFToastView showProgress:@"正在修改"];
    NSString *url = @"http://saiya.tv/api/customer/ResetPassword";
    NSDictionary * dict = @{@"Account":_phone,@"NewPassword":_pwdField.text,@"ConfirmNewPassword":_pwdField2.text,@"Code":_code};
    [[NetworkManagementRequset manager] requestPostData:url postData:dict complation:^BOOL(BOOL result, id returnData) {
        
        [NWFToastView dismissProgress];
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
  
          [NWFToastView showToast:@"密码修改成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
            
            
        }else{
            [NWFToastView showToast:@"修改失败"];
        }
        
        return  YES;
    }];
    
    
    
}
-(void)doHuanxinRegister
{
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * or = textField.text;
    NSString * pwd1= _pwdField.text;
    NSString * pwd2=_pwdField2.text;
    long count = or.length;
    if (range.location>=count) {
        or = [or stringByAppendingString:string];
    }else{
        or = [or stringByReplacingCharactersInRange:range withString:string];
    }
    
    if (textField == _pwdField) {
        pwd1 = or;
    }else{
        pwd2 = or;
    }
    
    
    
    if (pwd1.length>=6 && pwd2.length>=6) {
        _nextBtn.backgroundColor = APPCOLOR_ORINGE;
        _nextBtn.enabled = YES;
    }else{
        _nextBtn.backgroundColor = [UIColor grayColor];
        _nextBtn.enabled = NO;
    }
    return YES;
}


@end
