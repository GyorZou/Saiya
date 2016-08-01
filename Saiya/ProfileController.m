//
//  ProfileController.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "AreaModel.h"

#import "ProfileController.h"
#import "InputTableViewCell.h"

#import "SaveTableViewCell.h"
#import "MySignatureTableViewCell.h"
#import "ImagesTableViewCell.h"
#import "CityInputCell.h"
@interface ProfileController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    BOOL _editing;
    NSArray * _states;
}
@end

@implementation ProfileController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _tableView.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tableView registerNib:[UINib nibWithNibName:@"InputTableViewCell" bundle:nil] forCellReuseIdentifier:@"InputTableViewCell.h"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MySignatureTableViewCell" bundle:nil] forCellReuseIdentifier:@"MySignatureTableViewCell.h"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ImagesTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImagesTableViewCell.h"];
    //#import "CityInputCell.h"
    
    [_tableView registerNib:[UINib nibWithNibName:@"CityInputCell" bundle:nil] forCellReuseIdentifier:@"CityInputCell.h"];
    _editing = YES;
    //[self showEdit];
    [self loadStates];
    
}
-(void)showEdit
{
     _editing = NO;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 25);
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(editView) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

}
-(void)editView
{
//    self.navigationItem.rightBarButtonItem = nil;
//    _editing = YES;
//    [_tableView reloadData];
    [self.navigationController pushViewController:[ProfileController new] animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return SCREENWIDTH*0.6;
    }else if (indexPath.row == 1){
        return 60;
    }else if (indexPath.row == 9){
        return 130;
    }
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    NSArray  *titles =@[@"头像",@"姓名",@"性别",@"年龄",@"地区",@"情感状态",@"签名",@"微博"];
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ImagesTableViewCell.h"];
    }else if (indexPath.row == 9){
    
        cell= [tableView dequeueReusableCellWithIdentifier:@"MySignatureTableViewCell.h"];
        cell.userInteractionEnabled = _editing == YES;
    }else if (indexPath.row == 5){
        
       CityInputCell *  cell1= [tableView dequeueReusableCellWithIdentifier:@"CityInputCell.h"];
        cell1.states = _states;
        cell = cell1;
        UILabel * label = [cell valueForKey:@"titleLabel"];
        label.text = titles[indexPath.row - 1];
        cell.userInteractionEnabled = _editing == YES;
    }else{
        cell= [tableView dequeueReusableCellWithIdentifier:@"InputTableViewCell.h"];
        UILabel * label = [cell valueForKey:@"titleLabel"];
        label.text = titles[indexPath.row - 1];
        cell.userInteractionEnabled = _editing == YES;
    }
    
 
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _editing?60:0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view;
    if (_editing) {
        view = [[[NSBundle mainBundle] loadNibNamed:@"SaveTableViewCell" owner:nil options:nil] lastObject];//[SaveTableViewCell new];
        view.frame = CGRectMake(0, 0, SCREENWIDTH, 60);
    }
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadStates
{
    NSString* root = @"http://saiya.tv/API/Common/GetStates";
    
    [[NetworkManagementRequset manager] requestGet:root complation:^(BOOL result, id returnData, id cookieData) {
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            NSArray * datas = returnData[@"data"];
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dict in datas) {
                AreaModel * model = [[AreaModel alloc] initWithAtrribute:dict];
                [temp addObject:model];
                
            }
            _states = temp;
            [_tableView reloadData];

        }
        
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




@end
