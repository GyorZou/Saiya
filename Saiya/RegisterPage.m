//
//  RegisterPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "RegisterPage.h"
#import "RegisterPage2.h"
#import "SMSSender.h"
@interface RegisterPage ()<UITextFieldDelegate>
{
    IBOutlet UIButton * _registerBtn;
}
@end

@implementation RegisterPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = APPCOLOR_GRAY; 
    [self initTitleview];
    _nameFiled.delegate = self;
    _registerBtn.enabled = NO;
}
-(void)initTitleview
{
    
    GoodsDetailTitle *title =[[GoodsDetailTitle alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    title.selectedTitleColor = [UIColor whiteColor];
    title.unselectedTitleColor = APPCOLOR_GRAY;
    
    
    title.titles=@[@"注册"];
    
    
    self.navigationItem.titleView=title;
    //self.navigationItem.rightBarButtonItem = [self rightItem];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)registerBtn:(id)sender
{
    
    [SMSSender sendSMSToPhone:_nameFiled.text of:SMSTypeRegister block:^(BOOL result, id returnData ) {
        if (result) {
            
            NSLog(@"%@",returnData);
            
        }else{
            
        }
        RegisterPage2 * p2 = [RegisterPage2 new];
        [self.navigationController pushViewController:p2 animated:YES];

    }];    
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
    
    long count = or.length;
    if (range.location>=count) {
        or = [or stringByAppendingString:string];
    }else{
        or = [or stringByReplacingCharactersInRange:range withString:string];
    }
    if (or.length >11) {
        return NO;
    }
   
    if ([self checkName:or]) {
        _registerBtn.backgroundColor = APPCOLOR_ORINGE;
        _registerBtn.enabled = YES;
    }else{
        _registerBtn.backgroundColor = [UIColor grayColor];
        _registerBtn.enabled = NO;
    }
    return or.length < 12;
}
-(BOOL)checkName:(NSString*)name
{
    
    return name.length == 11;
}

@end
