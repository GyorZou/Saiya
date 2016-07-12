//
//  HotEventsViewController.m
//  Saiya
//
//  Created by jp007 on 16/7/12.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "HotEventsViewController.h"
#import "UIScrollView+MJExtension.h"
#import "MJRefresh.h"
@interface HotEventsViewController ()

@end

@implementation HotEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showRefreshHeader = YES;
    self.showRefreshFooter = YES;
    [self.tableView.mj_header beginRefreshing];
    [self tableViewDidTriggerHeaderRefresh];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * rid = @"hoteventcell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData:(BOOL)refresh
{
    NSString * url = @"http://saiya.tv/API/Event/GetEvents";
    //Page:3
    //PageSize:10
    if (refresh) {
           self.page = 1;
    }
    [[NetworkManagementRequset manager] requestGet:url params:@{@"Page":@(self.page),@"PageSize":@"10"} complation:^(BOOL result, id returnData, id cookieData) {
        if (refresh) {
            [self.tableView.mj_header endRefreshing];
 
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
            if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            self.page ++;
            NSDictionary * dict = [returnData objectForKey:@"data"];
            self.totalCount = [dict[@"Total"] intValue];
            [self.dataArray removeAllObjects];
            
            
            
            if (self.totalCount <= self.dataArray.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }
        
    }];

}
-(void)tableViewDidTriggerHeaderRefresh
{
    [self loadData:YES];
}
-(void)tableViewDidTriggerFooterRefresh
{
    if (self.totalCount == self.dataArray.count) {
        return;
    }
    [self loadData:NO];
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
