//
//  NoneBarWebviewController.m
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "NoneBarWebviewController.h"

@interface NoneBarWebviewController ()
{
    UIView * _barView;
}
@end

@implementation NoneBarWebviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNaviBar = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIView * barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20)];
    [self.view addSubview:barView];
    barView.backgroundColor = APPCOLOR_ORINGE;
    barView.alpha = 0;
    UIView * view = self.webView;
    CGRect f = view.frame;
    f.size.height -= 20;
    f.origin.y = 20;
    view.frame =f;
    _barView = barView;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    _barView.alpha = 1;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [super webViewDidStartLoad:webView];
    _barView.alpha = 0;
}
-(void)reload
{
    [super reload];
    UIView * view = self.webView;
    CGRect f = view.frame;
    f.size.height -= 20;
    f.origin.y = 20;
    view.frame =f;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.backgroundColor = APPCOLOR_ORINGE;
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
-(void)initJSContext
{
    [super initJSContext];


    __weak    typeof(self) ws = self;
    self.jsContext[@"sendSuccess"] = ^{
        //[ws dissmiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"saiya_did_send_suc" object:nil];
        [ws.navigationController popViewControllerAnimated:YES];
    };
}
-(BOOL)handleUrl:(NSString *)url
{
    if ([url hasSuffix:@"#"] && [url isEqualToString:[NSString stringWithFormat:@"%@#",self.baseUrl]]) {
        return YES;
    }
    NoneBarWebviewController * web = [NoneBarWebviewController new];
    web.baseUrl = url;
    [self.navigationController pushViewController:web animated:YES];
    return NO;
}

@end
