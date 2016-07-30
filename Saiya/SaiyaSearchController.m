//
//  SaiyaSearchController.m
//  Saiya
//
//  Created by jp007 on 16/7/14.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaiyaSearchController.h"
#import "InfoDetailViewController.h"

@interface SaiyaSearchController ()

@end

@implementation SaiyaSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initJSContext
{
    
    __weak typeof(self) wS = self;
    
    void (^action)(NSString*,InfoType) = ^(NSString* sid,InfoType type){
    
        InfoDetailViewController * detail = [InfoDetailViewController new];
        detail.infoId = sid;
        detail.type = type;
        [wS.navigationController pushViewController:detail animated:YES];
    };
    self.jsContext[@"viewEntertainer"] = ^(NSString * sid){
        action(sid,InfoTypeUser);
    };
    self.jsContext[@"viewVendor"] = ^(NSString * sid){
        action(sid,InfoTypeVendor);
    };
    self.jsContext[@"viewCompetion"] = ^(NSString * sid){
         action(sid,InfoTypeSaishi);
    };
    
    
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
