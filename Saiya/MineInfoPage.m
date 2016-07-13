//
//  MineInfoPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "MineInfoPage.h"
#import "MyHeadCell.h"

#import "GoodsDetailTitle.h"

#import "NoneBarWebviewController.h"
@interface MineInfoPage ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _contentView;
    NSArray * _datas;
}
@end

@implementation MineInfoPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"icon-nav4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon-nav4-visited"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _contentView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_contentView];
    _contentView.delegate = self;
    _contentView.dataSource = self;
    
    
    [_contentView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"infocell2"];
    [_contentView registerNib:[UINib nibWithNibName:@"MyHeadCell" bundle:nil] forCellReuseIdentifier:@"infocell1"];
    
    NSDictionary * a1 = @{@"image":@"heart",@"title":@"我的关注",@"class":@"",@"url":@"watchings.html"};
    NSDictionary * a2 = @{@"image":@"trophy",@"title":@"我的赛事",@"class":@"",@"url":@""};
    NSDictionary * a3 = @{@"image":@"authentication",@"title":@"我要认证",@"class":@"",@"url":@""};

    NSDictionary * a4 = @{@"image":@"saidou",@"title":@"赛豆",@"class":@"",@"url":@""};

    NSDictionary * a5 = @{@"image":@"shezhi",@"title":@"设置",@"class":@"",@"url":@""};

    
    _datas = @[a1,a2,a3,a4,a5];
    
    [self initTitleview];
    
}
-(void)initTitleview
{
    
    GoodsDetailTitle *title =[[GoodsDetailTitle alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    title.selectedTitleColor = [UIColor whiteColor];
    title.unselectedTitleColor = APPCOLOR_GRAY;
    
    
    title.titles=@[@"我的"];
    
    
    self.navigationItem.titleView=title;
    //self.navigationItem.rightBarButtonItem = [self rightItem];
    
    
}
-(UIBarButtonItem *)backItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    
    [backBtn addTarget:self action:@selector(searchItemClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];;
}
-(void)searchItemClick
{
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        MyHeadCell * myHead = [tableView dequeueReusableCellWithIdentifier:@"infocell1"];
        myHead.headImgeView.image = [UIImage imageNamed:@"icon-nav4-visited"];
        myHead.clipsToBounds = YES;
        myHead.headImgeView.layer.cornerRadius = myHead.headImgeView.frame.size.width/2;
        cell = myHead;
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"infocell2"];
        cell.detailTextLabel.text = nil;
        if (indexPath.row == 3) {
            cell.detailTextLabel.text = @"1001颗";
            cell.detailTextLabel.textColor =APPCOLOR_ORINGE;
        }
        cell.textLabel.text = _datas[indexPath.row][@"title"];
        cell.imageView.image = [UIImage imageNamed:_datas[indexPath.row][@"image"]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 107;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([LoginPage showIfNotLogin] == YES) {
        if (indexPath.section == 0) {
            
        }else{
            
            NSString * root = @"http://saiya.tv/h5/";
            NSDictionary * dict =  _datas[indexPath.row];
            
            NSString * cls = dict[@"class"];
            NSString * url = dict[@"url"];
            NSString * title = dict[@"title"];
            if (url.length > 0) {
                url = [root stringByAppendingString:url];
            }
            UIViewController * destin;
            if (cls.length > 0) {
                UIViewController * vc = [[NSClassFromString(cls) alloc] init];
                if (url.length > 0) {
                    [vc setValue:url forKey:@"baseUrl"];
                    [vc setValue:@(YES) forKey:@"hideNaviBar"];
                }
                destin = vc;
            }else{
                BaseWebviewController * base = [[NoneBarWebviewController alloc] init];
                if (url.length == 0) {
                    url = [root stringByAppendingString:@"watchings.html"];
                }
                base.baseUrl = url;
                destin = base;
                base.hideNaviBar = YES;
                            }
            destin.view.backgroundColor = APPCOLOR_ORINGE;
            destin.title = title;
            destin.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:destin animated:YES];

        }
        
    }
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
