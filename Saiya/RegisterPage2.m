//
//  RegisterPage2.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "RegisterPage2.h"

#import "RegisterPage3.h"
@interface RegisterPage2 ()

@end

@implementation RegisterPage2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = APPCOLOR_GRAY; 
    [self initTitleview];
    
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
    RegisterPage3 * p2 = [RegisterPage3 new];
    [self.navigationController pushViewController:p2 animated:YES];
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
