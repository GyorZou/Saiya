//
//  NoneBarWebviewController.m
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "NoneBarWebviewController.h"

@interface NoneBarWebviewController ()

@end

@implementation NoneBarWebviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNaviBar = YES;
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
-(BOOL)handleUrl:(NSString *)url
{
    NoneBarWebviewController * web = [NoneBarWebviewController new];
    web.baseUrl = url;
    [self.navigationController pushViewController:web animated:YES];
    return NO;
}

@end
