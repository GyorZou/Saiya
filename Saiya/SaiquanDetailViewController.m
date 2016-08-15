//
//  SaiquanDetailViewController.m
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaiquanDetailViewController.h"

@interface SaiquanDetailViewController ()

@end

@implementation SaiquanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initJSContext
{
    [super initJSContext];
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString * s = [def objectForKey:@"acc_token"];
    if (s) {
        NSString *js = [NSString stringWithFormat:@"setParams('%@','%@')",_saiquanId,s];
        [self.jsContext evaluateScript:js];
    }


}
-(id<ISSContent>)publishContent
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"card"  ofType:@"png"];
    id<ISSContent> publishContent = [ShareSDK content:@"赛圈"
                                       defaultContent:@"默认分享内容测试，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"pmmq"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    return publishContent;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIView * view = self.webView;
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
