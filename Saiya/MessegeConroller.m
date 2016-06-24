//
//  MessegeConroller.m
//  Saiya
//
//  Created by jp007 on 16/6/24.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "MessegeConroller.h"
#import "SaixinCell.h"
@interface MessegeConroller ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _content;
}
@end

@implementation MessegeConroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _content = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_content];
    _content.dataSource = self;
    _content.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _content.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * s = @"xxxx";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:s];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaixinCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
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
