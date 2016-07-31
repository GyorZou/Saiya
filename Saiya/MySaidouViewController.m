//
//  MySaidouViewController.m
//  Saiya
//
//  Created by zougyor on 16/7/31.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "MySaidouViewController.h"
#import "MySaidouDetailViewController.h"
@interface MySaidouViewController ()

@end

@implementation MySaidouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //
    //UIButton * ]
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"明细" style:UIBarButtonItemStyleDone target:self action:@selector(showDetail)];
    self.title =@"赛豆";
}
-(void)showDetail
{
    [self.navigationController pushViewController:[MySaidouDetailViewController new] animated:YES];
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
