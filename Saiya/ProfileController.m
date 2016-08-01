//
//  ProfileController.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "ProfileController.h"
#import "InputTableViewCell.h"

#import "SaveTableViewCell.h"
#import "MySignatureTableViewCell.h"
#import "ImagesTableViewCell.h"
#import "CityInputCell.h"
@interface ProfileController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
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
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tableView registerNib:[UINib nibWithNibName:@"InputTableViewCell" bundle:nil] forCellReuseIdentifier:@"InputTableViewCell.h"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MySignatureTableViewCell" bundle:nil] forCellReuseIdentifier:@"MySignatureTableViewCell.h"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ImagesTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImagesTableViewCell.h"];
    //#import "CityInputCell.h"
    
    [_tableView registerNib:[UINib nibWithNibName:@"CityInputCell" bundle:nil] forCellReuseIdentifier:@"CityInputCell.h"];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ImagesTableViewCell.h"];
    }else if (indexPath.row == 9){
    
        cell= [tableView dequeueReusableCellWithIdentifier:@"MySignatureTableViewCell.h"];
    }else if (indexPath.row == 5){
        
        cell= [tableView dequeueReusableCellWithIdentifier:@"CityInputCell.h"];
    }else{
        cell= [tableView dequeueReusableCellWithIdentifier:@"InputTableViewCell.h"];
    }
    
 
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

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
