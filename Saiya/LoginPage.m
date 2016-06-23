//
//  LoginPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "LoginPage.h"
#import "RegisterPage.h"
@interface LoginPage ()

@end

@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.backBarButtonItem = [self backItem];
    self.navigationItem.rightBarButtonItem = [self rightItem];
    
    self.view.backgroundColor = APPCOLOR_GRAY; //[UIColor whiteColor];
    self.quickLabel.backgroundColor = APPCOLOR_GRAY;
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
