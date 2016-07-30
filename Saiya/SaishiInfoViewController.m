//
//  SaishiInfoViewController.m
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaishiInfoViewController.h"
#import "InfoDetailViewController.h"
@interface SaishiInfoViewController ()

@end

@implementation SaishiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString * s = [def objectForKey:@"acc_token"];
    //if (s) {
        NSString *js = [NSString stringWithFormat:@"setParams('%@','%@')",_saishiId,s];
        [self.jsContext evaluateScript:js];
    //}


    __weak typeof(self) wS = self;
    self.jsContext[@"viewDetails"] = ^(NSString * sid){
        NSArray *args = [JSContext currentArguments];
        InfoDetailViewController * detail = [InfoDetailViewController new];
        //detail.baseUrl = @"http://saiya.tv/h5/competionsummary.html";
        detail.infoId = sid;
        detail.type = InfoTypeSaishi;
        [wS.navigationController pushViewController:detail animated:YES];
    };
    self.jsContext[@"viewDetailsxx"] = ^(NSString * sid){
        NSArray *args = [JSContext currentArguments];
        InfoDetailViewController * detail = [InfoDetailViewController new];
        //detail.baseUrl = @"http://saiya.tv/h5/competionsummary.html";
        detail.infoId = sid;
        detail.type = InfoTypeSaishi;
        [wS.navigationController pushViewController:detail animated:YES];
    };

}


@end
