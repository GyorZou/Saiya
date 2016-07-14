//
//  RecommendVendorController.m
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "RecommendVendorController.h"

#import "VendorModel.h"
#import "VendorCell.h"
@interface RecommendVendorController ()

@end

@implementation RecommendVendorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"VendorCell" bundle:nil] forCellReuseIdentifier:@"vendorcell"];
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
-(NSString *)dataUrl
{
    return @"http://saiya.tv/API/Vendor/GetVendors";
}
-(void)parseData:(NSDictionary *)data
{
    NSDictionary * dict = [data objectForKey:@"data"];
    
    self.totalCount = [dict[@"Total"] intValue];

    NSArray * items = dict[@"Data"];
    for (NSDictionary * d in items) {
        VendorModel * m = [[VendorModel alloc] initWithAtrribute:d];
        [self.dataArray addObject:m];
    }

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VendorCell * cell = [tableView dequeueReusableCellWithIdentifier:@"vendorcell"];

    VendorModel * model = self.dataArray[indexPath.section];
    [cell.avartarImage setImageWithURL:[NSURL URLWithString:  model.Customer[@"AvatarUrl"]]];
    cell.vendorNameLB.text = model.Name;
    cell.countLB.text = [NSString stringWithFormat:@"%@",model.WatchingNumber];
    cell.detailLB.text = model.Description;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  0.05;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.05;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     VendorModel * model = self.dataArray[indexPath.section];
    InfoDetailViewController * detail = [InfoDetailViewController new];
    detail.infoId = [NSString stringWithFormat:@"%@",model.Id];
    detail.type = InfoTypeVendor;
    [self.navigationController pushViewController:detail animated:YES];

}

@end
