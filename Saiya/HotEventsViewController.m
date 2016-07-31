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
#import "AreaModel.h"
#import "AreaSelectorViewController.h"
#import "CategoryViewController.h"
@interface HotEventsViewController ()
{
    NSMutableArray * _sliders;
    NSMutableDictionary * _dataCache;
    int _curIndex;
    id _vc;
    int category;
}
@end

@implementation HotEventsViewController

- (void)viewDidLoad {
    [self setValue:@(1) forKey:@"style"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataCache = [NSMutableDictionary dictionary];
    self.showRefreshHeader = YES;
    self.showRefreshFooter = YES;
    [self.tableView.mj_header beginRefreshing];
    //[self tableViewDidTriggerHeaderRefresh];
    self.tableView.rowHeight = 255;
    [self.tableView registerNib:[UINib nibWithNibName:@"HotEventTableViewCell" bundle:nil] forCellReuseIdentifier:@"hoteventcell"];
    [self loadAreas];
    [self loadCategories];
    [self loadStates];
    
    [self loadSlider];
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
            if (_curIndex == 0) {
               [self.tableView reloadData];
            }
            
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
-(NSString*)keyForIndex:(int)index
{
    return [NSString stringWithFormat:@"key-%d",index];
}
-(void)tabClickedAtIndex:(int)index
{
    if(_vc!=nil){
        [[_vc view] removeFromSuperview];
        _vc = nil;
    
    }
    if (_curIndex == index && (index<3 ||index>4)) {
        return;
    }
   
    _curIndex = index;
    NSArray * models = [_dataCache objectForKey:[self keyForIndex:index]];
    if (index == 0) {
        if (models) {
            self.dataArray = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
        }else{
            [self.tableView.mj_header beginRefreshing];
        }
    }else if(index == 1){
        if (models) {
            self.dataArray = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
        }else{
            [self.tableView.mj_header beginRefreshing];
        }
    }else if(index == 2){//最新
        
    }else if(index == 3){//区域
        models = [_dataCache objectForKey:[self keyForIndex:31]];
        if (models && _vc == nil) {
            if ( _vc == nil) {
                AreaSelectorViewController * vc = [AreaSelectorViewController new];
                
                vc.areasData = models;
                vc.statesData = _dataCache[[self keyForIndex:32]];
                _vc = vc;
                __weak typeof(vc) weakvc = vc;
                
                vc.doSearchBlk = ^(NSString*regions){
                    if (regions == nil) {
                        
                    }else{
                        
                    }
                    [weakvc.view removeFromSuperview];
                    self ->_vc = nil;
                };
                vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
                vc.view.frame = self.view.bounds;
                self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                [self.view addSubview:vc.view];
            }
            
        }else{
        
            [self loadAreas];
            [self loadStates];
        }
        
       
        
    }else if(index == 4){//分类
        models = [_dataCache objectForKey:[self keyForIndex:41]];
        if (models.count > 0 && _vc == nil) {
            if ( _vc == nil) {
                CategoryViewController * vc = [CategoryViewController new];
                
                vc.areasData = models;
                _vc = vc;
                __weak typeof(vc) weakvc = vc;
                
                vc.doSearchBlk = ^(NSString*regions){
                    if (regions != nil) {
                        category = [regions intValue];
                        [self.tableView.mj_header beginRefreshing];
                    }else{
                        
                    }
                    [weakvc.view removeFromSuperview];
                    self ->_vc = nil;
                };
                vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
                vc.view.frame = self.view.bounds;
                self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                [self.view addSubview:vc.view];
            }
            
        }else{
            
            [self loadCategories];
        }
        
    }else if(index == 5){//附近
        
    }else if(index == 6){
        
    }else if(index == 7){
        
    }
    
}
-(void)loadData:(BOOL)refresh
{
    NSString * url = @"http://saiya.tv/API/Event/GetEvents";
   


    if (refresh) {
         // [self loadSlider];
           self.page = 1;
    }
     NSDictionary * params = @{@"Page":@(self.page),@"PageSize":@"10"};
    if (_curIndex == 1) {
        url = @"http://saiya.tv/API/Event/GetMyWatchingedEvents";
    }else if(_curIndex == 4){//类别
        params = @{@"Page":@(self.page),@"PageSize":@"10",@"CategoryId":@(category)};
    }
    int index = _curIndex;
    [[NetworkManagementRequset manager] requestGet:url params:params complation:^(BOOL result, id returnData, id cookieData) {
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
            
                [_dataCache setObject:self.dataArray forKey:[self keyForIndex:index]];
                
            
            if (self.totalCount <= self.dataArray.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
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
-(void)loadMyWatching
{

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
            [_dataCache setObject:[NSArray arrayWithArray:temp] forKey:[self keyForIndex:32]];
        }
        
    }];

}
-(void)loadAreas
{
    NSString* root = @"http://saiya.tv/API/Common/GetAreas";
    
    [[NetworkManagementRequset manager] requestGet:root complation:^(BOOL result, id returnData, id cookieData) {
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            NSArray * datas = returnData[@"data"];
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dict in datas) {
                AreaModel * model = [[AreaModel alloc] initWithAtrribute:dict];
                [temp addObject:model];
                
            }
            [_dataCache setObject:[NSArray arrayWithArray:temp] forKey:[self keyForIndex:31]];
        }

        
    }];
}
-(void)loadCategories
{
    NSString* root = @"http://saiya.tv/API/Category/GetCategories";

    [[NetworkManagementRequset manager] requestGet:root complation:^(BOOL result, id returnData, id cookieData) {
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            NSArray * datas = returnData[@"data"];
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dict in datas) {
                AreaModel * model = [[AreaModel alloc] initWithAtrribute:dict];
                [temp addObject:model];
                
            }
            [_dataCache setObject:[NSArray arrayWithArray:temp] forKey:[self keyForIndex:41]];
        }
        
    }];

}


@end
