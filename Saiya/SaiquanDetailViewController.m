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
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString * s = [def objectForKey:@"acc_token"];
    if (s) {
        NSString *js = [NSString stringWithFormat:@"setParams('%@','%@')",_saiquanId,s];
        [self.jsContext evaluateScript:js];
    }


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
