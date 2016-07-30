//
//  SaiyaListViewController.m
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaiyaListViewController.h"

@interface SaiyaListViewController ()

@end

@implementation SaiyaListViewController

- (void)viewDidLoad {
   // [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setValue:@(1) forKey:@"style"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showRefreshHeader = YES;
    self.showRefreshFooter = YES;
    [self.tableView.mj_header beginRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //320:179 = W:X
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(void)parseData:(NSDictionary*)data
{
    
    

}

-(NSString*)dataUrl
{
    return @"http://saiya.tv/API/Event/GetEvents";
}
-(NSDictionary*)requestParams
{
    return  @{@"Page":@(self.page),@"PageSize":@"10"};
}
-(void)loadData:(BOOL)refresh
{
    NSString * url = [self dataUrl];
    //Page:3
    //PageSize:10
    if (refresh) {
       self.page = 1;
    }
    [[NetworkManagementRequset manager] requestGet:url params:[self requestParams] complation:^(BOOL result, id returnData, id cookieData) {
        if (refresh) {
            [self.dataArray removeAllObjects];
            [self.tableView.mj_header endRefreshing];
            
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            self.page ++;
            [self parseData:returnData];
            
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
