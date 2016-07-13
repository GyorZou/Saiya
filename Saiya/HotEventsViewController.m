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
#import "HotEventModel.h"
#import "HotEventTableViewCell.h"
#import "HotSliderModel.h"
#import "EScrollerView.h"
#import "SaishiInfoViewController.h"
@interface HotEventsViewController ()
{
    NSMutableArray * _sliders;
}
@end

@implementation HotEventsViewController

- (void)viewDidLoad {
    [self setValue:@(1) forKey:@"style"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showRefreshHeader = YES;
    self.showRefreshFooter = YES;
    [self.tableView.mj_header beginRefreshing];
    //[self tableViewDidTriggerHeaderRefresh];
    self.tableView.rowHeight = 255;
    [self.tableView registerNib:[UINib nibWithNibName:@"HotEventTableViewCell" bundle:nil] forCellReuseIdentifier:@"hoteventcell"];
    
    
}
-(void)loadSlider
{
    NSString * url = @"http://saiya.tv/API/Common/GetSliders";

    [[NetworkManagementRequset manager] requestGet:url params:nil complation:^(BOOL result, id returnData, id cookieData) {
     
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
       
            _sliders = [NSMutableArray array];
            for (NSDictionary * d in returnData[@"data"]) {
                HotSliderModel * s = [[HotSliderModel alloc] initWithAtrribute:d];
                [_sliders addObject:s];
            }
            [self.tableView reloadData];
        }
        
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //320:179 = W:X
    return SCREENWIDTH* 179/320 + 255 - 179;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString * rid = @"hoteventcell";
    
    HotEventTableViewCell * cell = (HotEventTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"hoteventcell"];
    HotEventModel * model = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary * d =model.Vendor;
    cell.vendorNameLB.text = d[@"Name"];
    d = d[@"Customer"];
    
    cell.selectionStyle = 0;
    
    cell.activeNameLB.text = model.Name;
    cell.timeLB.text = model.CreatedOn;
    
    
    
    [cell.avartarImage setImageWithURL:[NSURL URLWithString:d[@"AvatarUrl"]] placeholderImage:nil];
    [cell.snapImage setImageWithURL:[NSURL URLWithString:[model.Images firstObject]]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 && _sliders.count > 0) {
        return SCREENWIDTH* 179/320 + 20;
    }
    return 0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 && _sliders.count > 0) {
        float h = SCREENWIDTH* 179/320;
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, h+20)];
        EScrollerView * scroll = [[EScrollerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, h)];
        [view addSubview:scroll];
        NSMutableArray * urls = [NSMutableArray array];
        NSMutableArray * nulls=[NSMutableArray array];
        [_sliders enumerateObjectsUsingBlock:^(HotSliderModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.PictureUrl!=nil) {
                [urls addObject:obj.PictureUrl];
            }else{
                [nulls addObject:obj];
            }
            
        }];
        [_sliders removeObjectsInArray:nulls];
    
        [scroll  ImageArray:urls TitleArray:nil rect:scroll.bounds isBanner:NO];
        
        scroll.clickBlock =^(NSUInteger index){
            BaseWebviewController * web = [BaseWebviewController new];
            HotSliderModel * m = [_sliders objectAtIndex:index];
            web.baseUrl = m.Link;
            [self.navigationController pushViewController:web animated:YES];
        
        };
        
        return view;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotEventModel * model = [self.dataArray objectAtIndex:indexPath.section];
    //NSDictionary * d =model.Vendor;
    
    SaishiInfoViewController * info = [SaishiInfoViewController new];
    info.baseUrl = @"http://saiya.tv/h5/competiondetails.html";
    info.saishiId = [NSString stringWithFormat:@"%@",model.Id];
    [self.navigationController pushViewController:info animated:YES];
    
    
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}
-(void)loadData:(BOOL)refresh
{
    NSString * url = @"http://saiya.tv/API/Event/GetEvents";
    //Page:3
    //PageSize:10
    if (refresh) {
          [self loadSlider];
           self.page = 1;
    }
    [[NetworkManagementRequset manager] requestGet:url params:@{@"Page":@(self.page),@"PageSize":@"10"} complation:^(BOOL result, id returnData, id cookieData) {
        if (refresh) {
            [self.dataArray removeAllObjects];
            [self.tableView.mj_header endRefreshing];
 
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
            if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            self.page ++;
            NSDictionary * dict = [returnData objectForKey:@"data"];
            self.totalCount = [dict[@"Total"] intValue];
            
            
                NSArray * items = dict[@"Data"];
                for (NSDictionary * d in items) {
                    HotEventModel * m = [[HotEventModel alloc] initWithAtrribute:d];
                    [self.dataArray addObject:m];
                }
            
            
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
