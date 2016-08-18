//
//  FindPwdPage1.m
//  Saiya
//
//  Created by jp007 on 16/8/18.
//  Copyright © 2016年 crv. All rights reserved.
//
#import "GoodsDetailTitle.h"
#import "FindPwdPage1.h"
#import "SMSSender.h"
#import "FindPwdPage2.h"
@interface FindPwdPage1 ()
{
    int _time;
}
@end

@implementation FindPwdPage1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _time = 60;
    [self initTitleview];
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
-(void)startTick
{
    self.codeBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _time--;
        if (_time<0) {
            [self endTick];
        }else{
            ;
            [self.codeBtn setTitle:APPENDSTRING(NSStringFromInt(_time), @"s") forState:UIControlStateDisabled];
            [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
            [self startTick];
        }
    });
}
-(void)endTick
{
    _time = 60;
    self.codeBtn.enabled = YES;

}
-(IBAction)sendBtn:(id)sender
{
    
    [NWFToastView showProgress:@"正在发送..."];
    [SMSSender sendSMSToPhone:_nameFiled.text of:SMSTypeRegister block:^(BOOL result, id returnData ) {
      //  NSLog(@"%@",returnData);
        [NWFToastView dismissProgress];
        [self startTick];
        if (result) {
            BOOL isTrue = [[returnData objectForKey:@"result"] boolValue];
            if (isTrue) {
         
                // return ;
            }else{
                [NWFToastView showToast:APPENDSTRING(@"发送失败:", returnData[@"messages"])];
            }
            return;
            
            
        }
        [NWFToastView showToast:@"发送失败"];
        
        
    }];    
}

-(IBAction)nextClick:(id)sender
{
    if ([self checkName:_nameFiled.text]) {
        if(_codeFiled.text.length>0){
        
            [self verifyCode];
        }else{
            [NWFToastView showToast:@"请输入正确手机号码"];
        }
    }else{
        [NWFToastView showToast:@"请输入正确手机号码"];
    }
    
}

-(BOOL)checkName:(NSString*)name
{
    
    return name.length == 11;
}


-(void)verifyCode
{
    [NWFToastView showProgress:@"正在验证"];
    [SMSSender verifySMS:_codeFiled.text atPhone:_nameFiled.text of:SMSTypeRegister block:^(BOOL result, id returnData) {
        [NWFToastView dismissProgress];
        
        if (result) {
            BOOL isTrue = [[returnData objectForKey:@"result"] boolValue];
            if (isTrue) {
                FindPwdPage2 * p2 = [FindPwdPage2 new];
                p2.phone = _nameFiled.text;
                p2.code = _codeFiled.text;
                [self.navigationController pushViewController:p2 animated:YES];
                return ;
            }
            
        }
        [NWFToastView showToast:@"验证码错误"];
    }];
    
}
@end
