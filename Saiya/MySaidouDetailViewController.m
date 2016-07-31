//
//  MySaidouDetailViewController.m
//  Saiya
//
//  Created by zougyor on 16/7/31.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "MySaidouDetailViewController.h"
#import "SaidouModel.h"
#import "MySaidouDetailCell.h"
@interface MySaidouDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _datas;
}
@end

@implementation MySaidouDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"赛豆明细";
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 64;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MySaidouDetailCell" bundle:nil] forCellReuseIdentifier:@"MySaidouDetailCell"];
    [self loadData];
}
-(void)loadData
{
    NSString* root = @"http://saiya.tv/API/Customer/GetPoints";
 
    [[NetworkManagementRequset manager] requestGet:root complation:^(BOOL result, id returnData, id cookieData) {
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            NSArray * datas = returnData[@"data"][@"Data"];
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dict in datas) {
                SaidouModel * model = [[SaidouModel alloc] initWithAtrribute:dict];
                [temp addObject:model];
                
            }
        
            _datas = temp;
            [_tableView reloadData];
            
        }
        
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 1, 0.5);
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySaidouDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MySaidouDetailCell"];
    
    SaidouModel * model = _datas[indexPath.row];
    cell.messLable.text = model.Message;
    cell.dateLabel.text = model.CreatedOn;
    cell.pointLabel.text = [NSString stringWithFormat:@"%@", model.Points ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
