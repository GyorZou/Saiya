//
//  ShowProfileViewController.m
//  Saiya
//
//  Created by zougyor on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "ShowProfileViewController.h"





//
//  ProfileController.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "ProfileController.h"
#import "InputTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "SaveTableViewCell.h"
#import "MySignatureTableViewCell.h"
#import "ImagesTableViewCell.h"
#import "CityInputCell.h"
#import "ProfileInfoCell.h"
@interface ShowProfileViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    BOOL _editing;
}
@end

@implementation ShowProfileViewController
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
    
    [_tableView registerNib:[UINib nibWithNibName:@"ProfileInfoCell" bundle:nil] forCellReuseIdentifier:@"ProfileInfoCell.h"];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"HeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"HeaderTableViewCell.h"];
    //_editing = YES;
    [self showEdit];
    SaiyaUser * user = [SaiyaUser curUser];
    user.Description = @"asalskdj氨基酸看来大家安看来是大家爱看了沙发客户身份及客户方尽快发货的数据库的恢复的思考及地方案说法就看好飞机开始撒砂浆款式的";
    
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
    ProfileController * p = [ProfileController new];
    p.title = @"个人信息";
    [self.navigationController pushViewController:p animated:YES];
    // [self.navigationController pushViewController:[MySaidouDetailViewController new] animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 6;
            break;
        default:
            break;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.1;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 &&indexPath.section == 0) {
        return SCREENWIDTH*0.6;
    }else if (indexPath.row == 1&&indexPath.section == 0){
        return 60;
    }else if (indexPath.section == 2){
        float w = SCREENWIDTH - 100;
        NSString * s = [SaiyaUser curUser].Description ;
        if ([s isKindOfClass:[NSString class]]) {
            float h = [[SaiyaUser curUser].Description sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(w, 1000)].height;
            return h + 20;
        }
        return 40;
    }
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    NSArray * titles1 = @[@"头像",@"名称",@"赛芽号"];
    NSArray  *titles2 =@[@"性别",@"年龄",@"地区",@"情感状态",@"个性签名",@"微博"];
    
    SaiyaUser * user = [SaiyaUser curUser];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ImagesTableViewCell*  cell1 = [tableView dequeueReusableCellWithIdentifier:@"ImagesTableViewCell.h"];
            
            cell1.deleteBtn.hidden = YES;            cell1.addBtn.hidden =YES;
            
            cell = cell1;
            [cell1.imageViews ImageArray:user.Pictures TitleArray:nil rect:CGRectZero isBanner:NO];
        }else if (indexPath.row == 1){
            //HeaderTableViewCell.h
           HeaderTableViewCell*   cell1= [tableView dequeueReusableCellWithIdentifier:@"HeaderTableViewCell.h"];
            cell =cell1;
            [cell1.headImage setImageWithURL:[NSURL URLWithString:user.AvatarUrl]];
            cell.userInteractionEnabled = _editing == YES;
        }else{
            cell =[tableView dequeueReusableCellWithIdentifier:@"ProfileInfoCell.h"];
            UILabel * label = [cell valueForKey:@"titleLabel"];
            label.text = titles1[indexPath.row -1];
            label = [cell valueForKey:@"infoLabel"];
            switch (indexPath.row) {
                case 2:
                    label.text = user.Username;
                    break;
                case 3:
                    label.text =NSStringFromObject(user.Id);
                    break;
                    
                default:
                    label.text =@"未填写";
                    break;
                    break;
            }
        }
    }else if(indexPath.section == 1){
        cell =[tableView dequeueReusableCellWithIdentifier:@"ProfileInfoCell.h"];
        UILabel * label = [cell valueForKey:@"titleLabel"];
        label.text = titles2[indexPath.row ];
        
        label = [cell valueForKey:@"infoLabel"];
        switch (indexPath.row) {
            case 0:
                label.text = NSStringFromObject(user.Gender);
                break;
            case 1:
                label.text = NSStringFromObject(user.Old);
                break;
            case 2:
                label.text =NSStringFromObject(user.Address);
                break;
            case 3:
                label.text =NSStringFromObject(user.EmotionalState);
                break;
            case 4:
                label.text =NSStringFromObject(user.Signature);
                break;
            case 5:
                label.text =NSStringFromObject(user.Weibo);
                break;
            default:
                label.text =@"未填写";
                break;
        }
        
        if([label.text isEqualToString:@"<null>"]){
            label.text = @"未填写";
        }
        label.textAlignment = NSTextAlignmentRight;
        
    }else{
        cell =[tableView dequeueReusableCellWithIdentifier:@"ProfileInfoCell.h"];
        UILabel * label = [cell valueForKey:@"titleLabel"];
        label.text = @"自我介绍";
        label = [cell valueForKey:@"infoLabel"];
        label.text = NSStringFromObject(user.Description);
        if([label.text isEqualToString:@"<null>"]){
            label.text = @"未填写";
        }
        label.textAlignment = NSTextAlignmentLeft;
    
    }
    
    /*
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ImagesTableViewCell.h"];
    }else if (indexPath.row == 9){
        
        cell= [tableView dequeueReusableCellWithIdentifier:@"MySignatureTableViewCell.h"];
        cell.userInteractionEnabled = _editing == YES;
    }else if (indexPath.row == 5){
        
        cell= [tableView dequeueReusableCellWithIdentifier:@"CityInputCell.h"];
        UILabel * label = [cell valueForKey:@"titleLabel"];
        label.text = titles[indexPath.row - 1];
        cell.userInteractionEnabled = _editing == YES;
    }else{
        cell= [tableView dequeueReusableCellWithIdentifier:@"InputTableViewCell.h"];
        UILabel * label = [cell valueForKey:@"titleLabel"];
        label.text = titles[indexPath.row - 1];
        cell.userInteractionEnabled = _editing == YES;
    }*/
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 2) return 20;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

