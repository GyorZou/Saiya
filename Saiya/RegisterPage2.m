//
//  RegisterPage2.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "RegisterPage2.h"
#import "SMSSender.h"
#import "RegisterPage3.h"
@interface RegisterPage2 ()<UITextFieldDelegate>
{
    IBOutlet UILabel * _phoneLabel,*_tickLabel;;
    IBOutlet UITextField * _codeField;
    IBOutlet UIButton * _nextBtn;
    int _count;
}
@end

@implementation RegisterPage2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = APPCOLOR_GRAY; 
    [self initTitleview];
    _phoneLabel.text = APPENDSTRING(@"+86 ", _phone);
    _nextBtn.enabled = NO;
    _codeField.delegate = self;
    _nextBtn.backgroundColor = [UIColor grayColor];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    _count = 60;
}
-(void)tick:(NSTimer*)timer
{
    _count--;
    if (_count < 0) {
        [timer invalidate];
        timer = nil;
        return;
    }
    _tickLabel.text = [NSString stringWithFormat:@"接收短信大概需要%d秒",_count];
    
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
    [NWFToastView showProgress:@"正在验证"];
    [SMSSender verifySMS:_codeField.text atPhone:_phone of:SMSTypeRegister block:^(BOOL result, id returnData) {
        [NWFToastView dismissProgress];
        
        if (result) {
            BOOL isTrue = [[returnData objectForKey:@"result"] boolValue];
            if (isTrue) {
                RegisterPage3 * p2 = [RegisterPage3 new];
                p2.phone = _phone;
                p2.code = _codeField.text;
                [self.navigationController pushViewController:p2 animated:YES];
                return ;
            }
            
        }
        [NWFToastView showToast:@"验证码错误"];
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
    
    if (or.length>4) {
        _nextBtn.backgroundColor = APPCOLOR_ORINGE;
        _nextBtn.enabled = YES;
    }else{
        _nextBtn.backgroundColor = [UIColor grayColor];
        _nextBtn.enabled = NO;
    }
    return YES;
}

@end
